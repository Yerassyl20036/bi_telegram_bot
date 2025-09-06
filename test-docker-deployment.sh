#!/bin/bash

# Local Docker deployment test script
# This script mimics what happens in production to help debug issues

set -e

echo "🧪 Testing Docker deployment locally..."

# Configuration
DOCKER_USERNAME="local"
export DOCKER_USERNAME

# Build images locally
echo "🔨 Building Docker images..."
docker build -f Dockerfile.bot -t ${DOCKER_USERNAME}/bi-telegram-bot:latest .
docker build -f Dockerfile.photo -t ${DOCKER_USERNAME}/bi-photo-server:latest .

# Stop any existing containers
echo "⏹️ Stopping existing containers..."
docker-compose down --timeout 30 2>&1 | grep -v "Process exited with status 143" || true
echo "✅ Containers stopped"

# Set up environment
echo "🔧 Setting up environment..."
if [ -f ".env.local" ]; then
    cp .env.local .env
    echo "✅ Using local environment"
elif [ -f ".env" ]; then
    echo "✅ Using existing .env"
else
    echo "❌ No environment file found!"
    echo "Create .env with required variables:"
    echo "TELEGRAM_BOT_TOKEN=your_token_here"
    echo "DATABASE_URL=postgresql://bot_user:bot_password@postgres:5432/power_bi_bot"
    echo "DB_PASSWORD=bot_password"
    exit 1
fi

# Add Docker username to env
echo "DOCKER_USERNAME=${DOCKER_USERNAME}" >> .env

# Create directories
mkdir -p photos

# Start services in stages
echo "🐳 Starting PostgreSQL..."
docker-compose up -d postgres

# Wait for PostgreSQL
echo "⏳ Waiting for PostgreSQL..."
sleep 15
for i in {1..12}; do
    if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
        echo "✅ PostgreSQL is ready"
        break
    fi
    echo "Waiting for PostgreSQL... ($i/12)"
    sleep 5
done

# Start other services
echo "🐳 Starting other services..."
docker-compose up -d telegram-bot photo-server grafana
echo "⏳ Waiting for services to start..."
sleep 30

# Health checks
echo "🔍 Health checks..."

# Check containers
echo "📊 Container status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Test each service
echo ""
echo "🧪 Service tests:"

# PostgreSQL
if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
    echo "✅ PostgreSQL: Healthy"
else
    echo "❌ PostgreSQL: Failed"
    docker logs power_bi_postgres --tail 10
fi

# Photo server
if curl -f http://localhost:8080/ 2>/dev/null >/dev/null; then
    echo "✅ Photo Server: Responding"
else
    echo "⚠️ Photo Server: Not responding (may still be starting)"
    docker logs bi-photo-server --tail 10 2>/dev/null || true
fi

# Grafana
if curl -f http://localhost:3000/api/health 2>/dev/null >/dev/null; then
    echo "✅ Grafana: Healthy"
else
    echo "⚠️ Grafana: Not responding (may still be starting)"
fi

# Bot (check if container is running)
if docker ps --filter "name=bi-telegram-bot" --filter "status=running" --quiet | grep -q .; then
    echo "✅ Telegram Bot: Container running"
else
    echo "❌ Telegram Bot: Container not running"
    docker logs bi-telegram-bot --tail 10 2>/dev/null || true
fi

echo ""
echo "🎉 Local deployment test completed!"
echo "💡 Check logs with: docker-compose logs -f [service-name]"
echo "🔗 Services available at:"
echo "   - Grafana: http://localhost:3000 (admin/admin)"
echo "   - Photo Server: http://localhost:8080"
echo "   - PostgreSQL: localhost:5432"
