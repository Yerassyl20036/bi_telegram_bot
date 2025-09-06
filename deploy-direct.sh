#!/bin/bash

# Direct Deployment Script for Power BI Telegram Bot
# Run this script directly on your VPS as an alternative to GitHub Actions

set -e

echo "🚀 Direct deployment started on VPS..."

# Configuration
PROJECT_DIR="$HOME/bi_telegram_bot"
LOG_FILE="$PROJECT_DIR/deploy.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    local status=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    case $status in
        "SUCCESS")
            echo -e "${GREEN}✅ [$timestamp] $message${NC}" | tee -a "$LOG_FILE"
            ;;
        "ERROR")
            echo -e "${RED}❌ [$timestamp] $message${NC}" | tee -a "$LOG_FILE"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  [$timestamp] $message${NC}" | tee -a "$LOG_FILE"
            ;;
        "INFO")
            echo -e "${BLUE}ℹ️  [$timestamp] $message${NC}" | tee -a "$LOG_FILE"
            ;;
    esac
}

# Function to run command with logging
run_cmd() {
    local cmd="$1"
    local description="$2"
    
    print_status "INFO" "Running: $description"
    if eval "$cmd" >> "$LOG_FILE" 2>&1; then
        print_status "SUCCESS" "$description completed"
        return 0
    else
        print_status "ERROR" "$description failed"
        return 1
    fi
}

# Check if we're in the right directory
if [ ! -d "$PROJECT_DIR" ]; then
    print_status "ERROR" "Project directory $PROJECT_DIR not found. Please run vps-setup.sh first."
    exit 1
fi

cd "$PROJECT_DIR"

# Initialize log file
echo "=== Direct Deployment Started at $(date) ===" > "$LOG_FILE"

print_status "INFO" "Starting deployment in $PROJECT_DIR"

# Check required commands
for cmd in docker docker-compose git; do
    if ! command -v $cmd &> /dev/null; then
        print_status "ERROR" "$cmd is not installed or not in PATH"
        exit 1
    fi
done
print_status "SUCCESS" "All required commands are available"

# Stop existing services
print_status "INFO" "Stopping existing services..."
if [ -f "docker-compose.yml" ]; then
    docker-compose down --timeout 15 2>/dev/null || true
    print_status "SUCCESS" "Existing services stopped"
else
    print_status "WARNING" "No docker-compose.yml found"
fi

# Clean up processes
print_status "INFO" "Cleaning up orphaned processes..."
pkill -f "python.*main.py" 2>/dev/null || true
pkill -f "python.*photo_server.py" 2>/dev/null || true

# Quick Docker cleanup
print_status "INFO" "Cleaning up Docker resources..."
docker container prune -f --filter "until=1h" 2>/dev/null || true
docker image prune -f --filter "until=24h" 2>/dev/null || true

# Pull latest code
print_status "INFO" "Pulling latest code from repository..."
if run_cmd "git fetch origin" "Git fetch"; then
    if run_cmd "git reset --hard origin/main" "Git reset to latest"; then
        print_status "SUCCESS" "Code updated successfully"
    else
        print_status "ERROR" "Failed to reset to latest code"
        exit 1
    fi
else
    print_status "ERROR" "Failed to fetch latest code"
    exit 1
fi

# Set up environment
print_status "INFO" "Setting up environment..."
if [ -f ".env.vps" ]; then
    cp .env.vps .env
    print_status "SUCCESS" "Environment configuration copied"
else
    print_status "WARNING" "No .env.vps file found, using existing .env"
fi

# Create necessary directories
mkdir -p photos
print_status "SUCCESS" "Created necessary directories"

# Build and start services
print_status "INFO" "Starting deployment process..."

# Start PostgreSQL first
print_status "INFO" "Starting PostgreSQL..."
if run_cmd "docker-compose up -d postgres" "PostgreSQL startup"; then
    print_status "SUCCESS" "PostgreSQL container started"
    
    # Wait for PostgreSQL to be ready
    print_status "INFO" "Waiting for PostgreSQL to be ready..."
    for i in {1..30}; do
        if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
            print_status "SUCCESS" "PostgreSQL is ready"
            break
        fi
        if [ $i -eq 30 ]; then
            print_status "ERROR" "PostgreSQL did not become ready within timeout"
            docker logs power_bi_postgres | tail -20 >> "$LOG_FILE"
            exit 1
        fi
        sleep 2
    done
else
    print_status "ERROR" "Failed to start PostgreSQL"
    exit 1
fi

# Start other services
print_status "INFO" "Starting application services..."
if run_cmd "docker-compose up -d telegram-bot photo-server" "Application services"; then
    print_status "SUCCESS" "Application services started"
else
    print_status "ERROR" "Failed to start application services"
    docker-compose logs >> "$LOG_FILE"
    exit 1
fi

# Start Grafana
print_status "INFO" "Starting Grafana..."
run_cmd "docker-compose up -d grafana" "Grafana startup" || print_status "WARNING" "Grafana may have failed to start"

# Wait for services to stabilize
print_status "INFO" "Waiting for services to stabilize..."
sleep 15

# Health checks
print_status "INFO" "Running health checks..."

# PostgreSQL check
if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot 2>/dev/null; then
    print_status "SUCCESS" "PostgreSQL health check passed"
else
    print_status "WARNING" "PostgreSQL health check failed"
fi

# Container status check
RUNNING_CONTAINERS=$(docker ps --filter "name=bi-" --filter "status=running" --format "{{.Names}}" | wc -l)
if [ "$RUNNING_CONTAINERS" -ge 2 ]; then
    print_status "SUCCESS" "Core services are running ($RUNNING_CONTAINERS containers)"
else
    print_status "WARNING" "Only $RUNNING_CONTAINERS services are running"
fi

# Final status
print_status "INFO" "Final container status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | tee -a "$LOG_FILE"

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
print_status "SUCCESS" "🎉 DEPLOYMENT COMPLETED!"
echo ""
echo "🌐 Your services are available at:"
echo "   - Grafana: http://$SERVER_IP:3000 (admin/admin)"
echo "   - Photo Server: http://$SERVER_IP:8080/photos/"
echo "   - PostgreSQL: $SERVER_IP:5432 (bot_user/bot_password)"
echo ""
echo "📋 Logs saved to: $LOG_FILE"
echo "📋 Run './verify-deployment.sh' to perform comprehensive health checks"
echo ""

# Offer to run verification
read -p "Do you want to run the verification script now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -x "./verify-deployment.sh" ]; then
        print_status "INFO" "Running verification script..."
        ./verify-deployment.sh
    else
        print_status "WARNING" "Verification script not found or not executable"
    fi
fi

echo "=== Direct Deployment Completed at $(date) ===" >> "$LOG_FILE"
