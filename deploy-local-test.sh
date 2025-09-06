#!/bin/bash

# Simplified deployment script for local testing
# This mimics what the GitHub Actions workflow does

echo "🚀 STARTING LOCAL DEPLOYMENT SIMULATION"
echo "======================================="

# Set variables (you'll need to set these)
DOCKER_USERNAME="your_docker_username"  # Replace with your actual username
PROJECT_DIR="~/bi_telegram_bot"

# Function to check command success
check_success() {
    if [ $? -eq 0 ]; then
        echo "✅ $1: SUCCESS"
    else
        echo "❌ $1: FAILED"
        exit 1
    fi
}

# Function to check if container is running
check_container() {
    if docker ps | grep -q "$1"; then
        echo "✅ $1 Container: RUNNING"
        return 0
    else
        echo "❌ $1 Container: NOT RUNNING"
        echo "Logs for $1:"
        docker logs "$1" 2>&1 || echo "No logs available"
        return 1
    fi
}

echo "🔌 SSH Connection: ✅ SUCCESSFUL (local test)"

# Navigate to project directory
cd $PROJECT_DIR
check_success "Navigate to project directory"

# Note: Skip Docker Hub login for local testing
echo "🔐 Docker Login: ✅ SKIPPED (local test)"

# Stop ALL existing processes and containers
echo "⏹️ Stopping ALL existing services..."

# Kill any existing Python processes
echo "🔪 Killing existing Python processes..."
pkill -f "python.*main.py" 2>/dev/null || echo "No main.py processes found"
pkill -f "python.*photo_server.py" 2>/dev/null || echo "No photo_server.py processes found"
pkill -f "python3.*main.py" 2>/dev/null || echo "No python3 main.py processes found"
pkill -f "python3.*photo_server.py" 2>/dev/null || echo "No python3 photo_server.py processes found"

# Stop and remove all existing containers
echo "🐳 Stopping Docker containers..."
docker-compose down --timeout 10 2>&1 || echo "No docker-compose containers running"
docker stop $(docker ps -aq) 2>/dev/null || echo "No containers to stop"
docker rm $(docker ps -aq) 2>/dev/null || echo "No containers to remove"

# Clean up Docker
echo "🧹 Cleaning up Docker..."
docker system prune -f || true

# For local testing, we'll build images instead of pulling
echo "🔨 Building Docker images locally..."
docker build -t bi-telegram-bot:latest -f Dockerfile.bot .
check_success "Build telegram bot image"

docker build -t bi-photo-server:latest -f Dockerfile.photo .
check_success "Build photo server image"

# Update environment file
echo "🔧 Setting up environment..."
if [ -f ".env.vps" ]; then
    cp .env.vps .env
    echo "✅ Copied .env.vps to .env"
else
    echo "⚠️ Using existing .env"
fi

# Start only PostgreSQL first
echo "🗄️ Starting PostgreSQL..."
docker-compose up -d postgres
check_success "Start PostgreSQL"

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
for i in {1..30}; do
    if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
        echo "🗄️ Database: ✅ READY"
        break
    fi
    echo "Waiting for database... ($i/30)"
    sleep 2
done

# Check if database is really ready
if ! docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
    echo "🗄️ Database: ❌ NOT READY AFTER 60s"
    exit 1
fi

# Start Grafana
echo "📊 Starting Grafana..."
docker-compose up -d grafana
check_success "Start Grafana"

# Start Telegram Bot
echo "🤖 Starting Telegram bot..."
docker-compose up -d telegram-bot
check_success "Start Telegram bot service"

# Wait and check if bot container is running
sleep 10
check_container "bi-telegram-bot"

# Start Photo Server
echo "📸 Starting photo server..."
docker-compose up -d photo-server
check_success "Start Photo server service"

# Wait and check if photo server container is running
sleep 5
check_container "bi-photo-server"

echo ""
echo "🎉 LOCAL DEPLOYMENT COMPLETED SUCCESSFULLY!"
echo "=========================================="
echo "All services are running in Docker containers."

# Show running containers
echo "📊 Container Status:"
docker ps --format "table {{.Names}}\t{{.Status}}" | grep -E "(postgres|bot|photo|grafana)" || true

echo ""
echo "🔍 Service Health Check:"
echo "Database: $(docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null && echo '✅ Ready' || echo '❌ Not Ready')"
echo "Bot: $(docker ps | grep -q 'bi-telegram-bot' && echo '✅ Running' || echo '❌ Not Running')"
echo "Photo: $(docker ps | grep -q 'bi-photo-server' && echo '✅ Running' || echo '❌ Not Running')"
echo "Grafana: $(docker ps | grep -q 'power_bi_grafana' && echo '✅ Running' || echo '❌ Not Running')"

echo ""
echo "📝 To check logs:"
echo "docker logs bi-telegram-bot"
echo "docker logs bi-photo-server"
echo "docker logs power_bi_postgres"
echo ""
echo "📝 To stop all services:"
echo "docker-compose down"
