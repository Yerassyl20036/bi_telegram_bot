#!/bin/bash

# Local deployment test script
# Run this on your VPS to test the deployment steps locally

set -x  # Enable debug output to see each command

echo "🧪 LOCAL DEPLOYMENT TEST STARTED"
echo "=================================="

# Check current directory
echo "📍 Current directory: $(pwd)"
echo "📁 Contents:"
ls -la

# Check if we're in the right directory
if [ ! -f "main.py" ]; then
    echo "❌ main.py not found. Are you in the bi_telegram_bot directory?"
    exit 1
fi

echo "✅ Found main.py - we're in the right directory"

# Check for running Python processes
echo "🔍 Checking for existing Python processes..."
pgrep -f "python.*main.py" && echo "📍 Found main.py processes" || echo "✅ No main.py processes found"
pgrep -f "python.*photo_server.py" && echo "📍 Found photo_server.py processes" || echo "✅ No photo_server.py processes found"

# Check Docker
echo "🐳 Checking Docker..."
if command -v docker >/dev/null 2>&1; then
    echo "✅ Docker is installed"
    docker --version
else
    echo "❌ Docker not found"
    exit 1
fi

# Check docker-compose
echo "🐳 Checking docker-compose..."
if command -v docker-compose >/dev/null 2>&1; then
    echo "✅ docker-compose is installed"
    docker-compose --version
else
    echo "❌ docker-compose not found"
    exit 1
fi

# Check current containers
echo "🔍 Current running containers:"
docker ps

# Check current docker-compose status
echo "🔍 Current docker-compose status:"
docker-compose ps || echo "No docker-compose services running"

# Test killing Python processes (safely)
echo "🔪 Testing process termination..."
echo "Before termination:"
ps aux | grep python | grep -E "(main\.py|photo_server\.py)" || echo "No Python bot processes found"

# Kill processes
pkill -f "python.*main.py" 2>/dev/null && echo "✅ Killed main.py processes" || echo "✅ No main.py processes to kill"
pkill -f "python.*photo_server.py" 2>/dev/null && echo "✅ Killed photo_server.py processes" || echo "✅ No photo_server.py processes to kill"

echo "After termination:"
ps aux | grep python | grep -E "(main\.py|photo_server\.py)" || echo "✅ All Python bot processes terminated"

# Test Docker operations
echo "🐳 Testing Docker operations..."

# Stop existing containers
echo "⏹️ Stopping existing containers..."
docker-compose down --timeout 10 2>&1 || echo "✅ No containers to stop"

# Test docker system prune
echo "🧹 Testing Docker cleanup..."
docker system prune -f 2>&1 || echo "⚠️ Docker cleanup had issues"

# Check .env files
echo "🔧 Checking environment files..."
if [ -f ".env" ]; then
    echo "✅ Found .env file"
    echo "📝 .env file size: $(wc -l < .env) lines"
else
    echo "⚠️ No .env file found"
fi

if [ -f ".env.vps" ]; then
    echo "✅ Found .env.vps file"
    echo "📝 .env.vps file size: $(wc -l < .env.vps) lines"
else
    echo "⚠️ No .env.vps file found"
fi

# Test environment setup
echo "🔧 Testing environment setup..."
if [ -f ".env.vps" ]; then
    cp .env.vps .env
    echo "✅ Copied .env.vps to .env"
else
    echo "⚠️ Using existing .env or no .env available"
fi

# Check docker-compose.yml
echo "📄 Checking docker-compose.yml..."
if [ -f "docker-compose.yml" ]; then
    echo "✅ Found docker-compose.yml"
    echo "📝 Services defined:"
    grep -E "^  [a-zA-Z].*:" docker-compose.yml || echo "Could not parse services"
else
    echo "❌ docker-compose.yml not found"
    exit 1
fi

# Test starting only PostgreSQL
echo "🗄️ Testing PostgreSQL startup..."
docker-compose up -d postgres 2>&1

if [ $? -eq 0 ]; then
    echo "✅ PostgreSQL container started"
    
    # Wait for database
    echo "⏳ Waiting for database to be ready..."
    for i in {1..15}; do
        if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
            echo "✅ Database is ready!"
            break
        fi
        echo "Waiting for database... ($i/15)"
        sleep 2
    done
    
    # Final database check
    if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
        echo "✅ Database connection test passed"
    else
        echo "❌ Database connection test failed"
        echo "PostgreSQL logs:"
        docker logs power_bi_postgres
    fi
else
    echo "❌ Failed to start PostgreSQL"
    exit 1
fi

echo ""
echo "🏁 LOCAL DEPLOYMENT TEST COMPLETED"
echo "=================================="
echo "✅ All basic tests passed. You can now test the full deployment."
echo ""
echo "Next steps:"
echo "1. If this script runs successfully, the environment is ready"
echo "2. Test the full deployment with: docker-compose up -d"
echo "3. Check logs with: docker-compose logs"
echo "4. If everything works locally, push to GitHub to trigger CI/CD"
