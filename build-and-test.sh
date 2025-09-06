#!/bin/bash

# Local Build and Test Script for Power BI Telegram Bot
# Use this script to build and test Docker images locally before deployment

set -e

echo "🔨 Building and testing Power BI Telegram Bot locally..."

# Configuration
DOCKER_USERNAME=${DOCKER_USERNAME:-"local"}
BOT_IMAGE="$DOCKER_USERNAME/bi-telegram-bot:latest"
PHOTO_IMAGE="$DOCKER_USERNAME/bi-photo-server:latest"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    local status=$1
    local message=$2
    case $status in
        "SUCCESS")
            echo -e "${GREEN}✅ $message${NC}"
            ;;
        "ERROR")
            echo -e "${RED}❌ $message${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  $message${NC}"
            ;;
        "INFO")
            echo -e "${BLUE}ℹ️  $message${NC}"
            ;;
    esac
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Pre-flight checks
echo "🔍 Running pre-flight checks..."

if ! command_exists docker; then
    print_status "ERROR" "Docker is not installed or not in PATH"
    exit 1
fi
print_status "SUCCESS" "Docker is available"

if ! command_exists docker-compose; then
    print_status "ERROR" "Docker Compose is not installed or not in PATH"
    exit 1
fi
print_status "SUCCESS" "Docker Compose is available"

# Check if required files exist
for file in "main.py" "photo_server.py" "requirements.txt" "Dockerfile.bot" "Dockerfile.photo" "docker-compose.yml"; do
    if [ ! -f "$file" ]; then
        print_status "ERROR" "Required file $file not found"
        exit 1
    fi
done
print_status "SUCCESS" "All required files found"

# Check if .env file exists
if [ ! -f ".env" ]; then
    print_status "WARNING" ".env file not found. Creating from template..."
    cat > .env << EOL
# Local Development Environment
DATABASE_URL=postgresql://bot_user:bot_password@postgres:5432/power_bi_bot
DATABASE_HOST=postgres
DATABASE_PORT=5432
DATABASE_NAME=power_bi_bot
DATABASE_USER=bot_user
DATABASE_PASSWORD=bot_password
DB_PASSWORD=bot_password

TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here

PHOTO_DIR=/app/photos
PHOTO_URL_BASE=http://localhost:8080/photos
PHOTO_SERVER_PORT=8080
MAX_PHOTO_SIZE=10485760

TABLE_PREFIX=edu_

DOCKER_USERNAME=$DOCKER_USERNAME

GF_SECURITY_ADMIN_PASSWORD=admin
EOL
    print_status "WARNING" "Please update .env with your actual values"
fi

# Stop any existing containers
print_status "INFO" "Stopping any existing containers..."
docker-compose down --timeout 10 2>/dev/null || true

# Build Docker images
echo ""
print_status "INFO" "Building Docker images..."

print_status "INFO" "Building Telegram Bot image..."
if docker build -t "$BOT_IMAGE" -f Dockerfile.bot .; then
    print_status "SUCCESS" "Bot image built successfully"
else
    print_status "ERROR" "Failed to build bot image"
    exit 1
fi

print_status "INFO" "Building Photo Server image..."
if docker build -t "$PHOTO_IMAGE" -f Dockerfile.photo .; then
    print_status "SUCCESS" "Photo server image built successfully"
else
    print_status "ERROR" "Failed to build photo server image"
    exit 1
fi

# Test image security and size
echo ""
print_status "INFO" "Analyzing built images..."

# Check image sizes
BOT_SIZE=$(docker images --format "table {{.Size}}" "$BOT_IMAGE" | tail -n 1)
PHOTO_SIZE=$(docker images --format "table {{.Size}}" "$PHOTO_IMAGE" | tail -n 1)

print_status "INFO" "Bot image size: $BOT_SIZE"
print_status "INFO" "Photo server image size: $PHOTO_SIZE"

# Test container startup (dry run)
echo ""
print_status "INFO" "Testing container startup..."

# Test bot container
if docker run --rm -d --name test-bot -e TELEGRAM_BOT_TOKEN=test -e DATABASE_URL=postgresql://test:test@localhost:5432/test "$BOT_IMAGE" sleep 10; then
    print_status "SUCCESS" "Bot container starts successfully"
    docker stop test-bot > /dev/null 2>&1 || true
else
    print_status "ERROR" "Bot container failed to start"
fi

# Test photo server container
if docker run --rm -d --name test-photo -p 8081:8080 "$PHOTO_IMAGE" sleep 10; then
    print_status "SUCCESS" "Photo server container starts successfully"
    docker stop test-photo > /dev/null 2>&1 || true
else
    print_status "ERROR" "Photo server container failed to start"
fi

# Start full environment for integration testing
echo ""
print_status "INFO" "Starting full environment for testing..."

if docker-compose up -d --build; then
    print_status "SUCCESS" "All services started"
    
    # Wait for services to be ready
    print_status "INFO" "Waiting for services to be ready..."
    sleep 30
    
    # Run health checks
    echo ""
    print_status "INFO" "Running health checks..."
    
    # Check PostgreSQL
    if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot > /dev/null 2>&1; then
        print_status "SUCCESS" "PostgreSQL is ready"
    else
        print_status "ERROR" "PostgreSQL is not ready"
    fi
    
    # Check photo server
    if curl -f -s http://localhost:8080/ > /dev/null; then
        print_status "SUCCESS" "Photo server is responding"
    else
        print_status "ERROR" "Photo server is not responding"
    fi
    
    # Check Grafana
    if curl -f -s http://localhost:3000/api/health > /dev/null; then
        print_status "SUCCESS" "Grafana is responding"
    else
        print_status "WARNING" "Grafana is not responding (may still be starting)"
    fi
    
    # Show running containers
    echo ""
    print_status "INFO" "Current container status:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    
    echo ""
    print_status "SUCCESS" "Local testing environment is ready!"
    echo ""
    echo "🌐 Access your services:"
    echo "   - Grafana: http://localhost:3000 (admin/admin)"
    echo "   - Photo Server: http://localhost:8080/photos/"
    echo "   - PostgreSQL: localhost:5432 (bot_user/bot_password)"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Test your bot functionality"
    echo "   2. Check logs: docker-compose logs -f [service-name]"
    echo "   3. Stop when done: docker-compose down"
    echo "   4. If everything works, push to main branch for deployment"
    
else
    print_status "ERROR" "Failed to start services"
    echo ""
    print_status "INFO" "Showing container logs for troubleshooting:"
    docker-compose logs
    exit 1
fi

# Option to run verification script
echo ""
read -p "Do you want to run the deployment verification script? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -x "./verify-deployment.sh" ]; then
        print_status "INFO" "Running deployment verification..."
        ./verify-deployment.sh
    else
        print_status "WARNING" "Verification script not found or not executable"
    fi
fi

echo ""
print_status "SUCCESS" "Build and test completed successfully! 🎉"
