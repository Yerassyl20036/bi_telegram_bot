#!/bin/bash

# Deployment script for Telegram Bot
# This script can be run manually or called by GitHub Actions

set -e

echo "🚀 Starting deployment process..."

# Configuration
PROJECT_DIR="$HOME/bi_telegram_bot"
BACKUP_DIR="$PROJECT_DIR/backups"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to check if service is running
check_service() {
    local service_name=$1
    local process_pattern=$2
    
    if pgrep -f "$process_pattern" > /dev/null; then
        echo "✅ $service_name is running"
        return 0
    else
        echo "❌ $service_name is not running"
        return 1
    fi
}

# Function to wait for database
wait_for_database() {
    echo "⏳ Waiting for database to be ready..."
    local timeout=60
    
    while ! docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; do
        sleep 2
        timeout=$((timeout - 2))
        if [ $timeout -le 0 ]; then
            echo "❌ Database failed to start within timeout"
            return 1
        fi
    done
    
    echo "✅ Database is ready"
    return 0
}

# Navigate to project directory
cd "$PROJECT_DIR"

# Stop existing services
echo "⏹️ Stopping existing services..."

# Stop Python processes gracefully
pkill -f "python.*main.py" || true
pkill -f "python.*photo_server.py" || true

# Give processes time to stop gracefully
sleep 5

# Force kill if still running
pkill -9 -f "python.*main.py" || true
pkill -9 -f "python.*photo_server.py" || true

# Stop Docker containers
echo "🐳 Stopping Docker containers..."
docker-compose down || true

# Create database backup
echo "💾 Creating database backup..."
docker-compose up -d postgres
sleep 10

if wait_for_database; then
    backup_file="$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).sql"
    docker exec power_bi_postgres pg_dump -U bot_user power_bi_bot > "$backup_file"
    echo "✅ Database backup created: $backup_file"
    
    # Keep only last 10 backups
    ls -t "$BACKUP_DIR"/backup_*.sql | tail -n +11 | xargs -r rm
else
    echo "⚠️ Could not create database backup, continuing with deployment..."
fi

docker-compose down

# Pull latest changes (if running from git repository)
if [ -d ".git" ]; then
    echo "📥 Pulling latest changes..."
    git fetch origin
    git reset --hard origin/main
else
    echo "ℹ️ Not a git repository, skipping git pull"
fi

# Set up environment
echo "🔧 Setting up environment..."
if [ -f ".env.vps" ]; then
    cp .env.vps .env
    echo "✅ Copied VPS environment configuration"
else
    echo "⚠️ No .env.vps file found, using existing .env"
fi

# Start Docker services
echo "🐳 Starting Docker services..."
docker-compose up -d

# Wait for database
if ! wait_for_database; then
    echo "❌ Database failed to start, aborting deployment"
    exit 1
fi

# Install/update Python dependencies
echo "📦 Installing Python dependencies..."
python3 -m pip install --user -r requirements.txt

# Create photos directory if it doesn't exist
mkdir -p photos

# Start photo server
echo "📸 Starting photo server..."
nohup python3 photo_server.py > photo_server.log 2>&1 &
sleep 5

# Verify photo server started
if ! check_service "Photo server" "python.*photo_server.py"; then
    echo "❌ Photo server failed to start"
    echo "Last 20 lines of photo server log:"
    tail -20 photo_server.log || true
    exit 1
fi

# Start the bot
echo "🤖 Starting Telegram bot..."
nohup python3 main.py > bot.log 2>&1 &
sleep 10

# Verify bot started
if ! check_service "Telegram bot" "python.*main.py"; then
    echo "❌ Bot failed to start"
    echo "Last 20 lines of bot log:"
    tail -20 bot.log || true
    exit 1
fi

# Final verification
echo "✅ Verifying all services..."

echo "📊 Docker containers status:"
docker-compose ps

echo ""
echo "🐍 Python processes:"
check_service "Telegram bot" "python.*main.py"
check_service "Photo server" "python.*photo_server.py"

echo ""
echo "🌐 Service URLs:"
echo "Grafana: http://$(hostname -I | awk '{print $1}'):80"
echo "Photo server: http://$(hostname -I | awk '{print $1}'):8080"

echo ""
echo "🎉 Deployment completed successfully!"
echo "📝 Logs are available in:"
echo "  - Bot: $PROJECT_DIR/bot.log"
echo "  - Photo server: $PROJECT_DIR/photo_server.log"
echo "  - Docker: docker-compose logs"
