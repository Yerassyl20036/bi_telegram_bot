#!/bin/bash

# Deployment Verification Script for Power BI Telegram Bot
# Run this script to verify that all services are running correctly after deployment

set -e

echo "🔍 Verifying Power BI Telegram Bot deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Initialize counters
total_checks=0
passed_checks=0
failed_checks=0

# Function to run a check
run_check() {
    local check_name=$1
    local check_command=$2
    total_checks=$((total_checks + 1))
    
    print_status "INFO" "Running check: $check_name"
    
    if eval "$check_command" > /dev/null 2>&1; then
        print_status "SUCCESS" "$check_name"
        passed_checks=$((passed_checks + 1))
        return 0
    else
        print_status "ERROR" "$check_name"
        failed_checks=$((failed_checks + 1))
        return 1
    fi
}

# Function to run a check with custom output
run_check_with_output() {
    local check_name=$1
    local check_command=$2
    local success_message=$3
    local error_message=$4
    
    total_checks=$((total_checks + 1))
    print_status "INFO" "Running check: $check_name"
    
    if eval "$check_command"; then
        print_status "SUCCESS" "$success_message"
        passed_checks=$((passed_checks + 1))
        return 0
    else
        print_status "ERROR" "$error_message"
        failed_checks=$((failed_checks + 1))
        return 1
    fi
}

echo ""
echo "📋 Starting deployment verification..."
echo ""

# Check 1: Docker is running
run_check "Docker Service" "systemctl is-active --quiet docker"

# Check 2: Docker Compose is available
run_check "Docker Compose" "command -v docker-compose"

# Check 3: Project directory exists
PROJECT_DIR="$HOME/bi_telegram_bot"
run_check "Project Directory" "[ -d '$PROJECT_DIR' ]"

# Change to project directory
if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
else
    print_status "ERROR" "Cannot change to project directory. Exiting."
    exit 1
fi

# Check 4: Environment file exists
run_check "Environment File" "[ -f '.env' ]"

# Check 5: Docker Compose file exists
run_check "Docker Compose File" "[ -f 'docker-compose.yml' ]"

echo ""
print_status "INFO" "Checking Docker containers..."

# Check 6: PostgreSQL container
run_check_with_output \
    "PostgreSQL Container" \
    "docker ps --filter 'name=power_bi_postgres' --filter 'status=running' | grep -q power_bi_postgres" \
    "PostgreSQL container is running" \
    "PostgreSQL container is not running"

# Check 7: PostgreSQL health
run_check_with_output \
    "PostgreSQL Health" \
    "docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot" \
    "PostgreSQL is accepting connections" \
    "PostgreSQL is not ready"

# Check 8: Telegram Bot container
run_check_with_output \
    "Telegram Bot Container" \
    "docker ps --filter 'name=bi-telegram-bot' --filter 'status=running' | grep -q bi-telegram-bot" \
    "Telegram Bot container is running" \
    "Telegram Bot container is not running"

# Check 9: Photo Server container
run_check_with_output \
    "Photo Server Container" \
    "docker ps --filter 'name=bi-photo-server' --filter 'status=running' | grep -q bi-photo-server" \
    "Photo Server container is running" \
    "Photo Server container is not running"

# Check 10: Grafana container
run_check_with_output \
    "Grafana Container" \
    "docker ps --filter 'name=power_bi_grafana' --filter 'status=running' | grep -q power_bi_grafana" \
    "Grafana container is running" \
    "Grafana container is not running"

echo ""
print_status "INFO" "Checking service endpoints..."

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

# Check 11: Photo Server HTTP endpoint
run_check_with_output \
    "Photo Server HTTP" \
    "curl -f -s http://localhost:8080/ > /dev/null" \
    "Photo Server is responding to HTTP requests" \
    "Photo Server is not responding to HTTP requests"

# Check 12: Grafana HTTP endpoint
run_check_with_output \
    "Grafana HTTP" \
    "curl -f -s http://localhost:3000/api/health > /dev/null" \
    "Grafana is responding to HTTP requests" \
    "Grafana is not responding to HTTP requests"

echo ""
print_status "INFO" "Checking database tables..."

# Check 13: Database tables exist
run_check_with_output \
    "Database Tables" \
    "docker exec power_bi_postgres psql -U bot_user -d power_bi_bot -c \"\\dt dbo.*\" | grep -q 'dbo'" \
    "Database tables are present" \
    "Database tables are missing"

echo ""
print_status "INFO" "Checking volumes and data persistence..."

# Check 14: PostgreSQL data volume
run_check_with_output \
    "PostgreSQL Data Volume" \
    "docker volume inspect bi_telegram_bot_postgres_data > /dev/null" \
    "PostgreSQL data volume exists" \
    "PostgreSQL data volume is missing"

# Check 15: Photo data volume
run_check_with_output \
    "Photo Data Volume" \
    "docker volume inspect bi_telegram_bot_photo_data > /dev/null" \
    "Photo data volume exists" \
    "Photo data volume is missing"

# Check 16: Photos directory in container
run_check_with_output \
    "Photos Directory" \
    "docker exec bi-photo-server ls -la /app/photos > /dev/null" \
    "Photos directory is accessible in container" \
    "Photos directory is not accessible in container"

echo ""
print_status "INFO" "Checking logs..."

# Check 17: Bot logs are being generated
if docker logs bi-telegram-bot --since=5m 2>/dev/null | grep -q .; then
    print_status "SUCCESS" "Bot is generating logs"
    passed_checks=$((passed_checks + 1))
else
    print_status "WARNING" "No recent bot logs found"
fi
total_checks=$((total_checks + 1))

# Check 18: Photo server logs
if docker logs bi-photo-server --since=5m 2>/dev/null | grep -q .; then
    print_status "SUCCESS" "Photo server is generating logs"
    passed_checks=$((passed_checks + 1))
else
    print_status "WARNING" "No recent photo server logs found"
fi
total_checks=$((total_checks + 1))

echo ""
echo "📊 Deployment Verification Summary"
echo "=================================="
echo "Total checks: $total_checks"
echo "Passed: $passed_checks"
echo "Failed: $failed_checks"
echo ""

if [ $failed_checks -eq 0 ]; then
    print_status "SUCCESS" "All checks passed! 🎉"
    echo ""
    echo "🌐 Your services are available at:"
    echo "   - Grafana: http://$SERVER_IP:3000 (admin/admin)"
    echo "   - Photo Server: http://$SERVER_IP:8080/photos/"
    echo "   - PostgreSQL: $SERVER_IP:5432 (bot_user/bot_password)"
    echo ""
    echo "📋 Service status:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" --filter "name=power_bi" --filter "name=bi-"
    echo ""
    exit 0
else
    print_status "ERROR" "$failed_checks checks failed!"
    echo ""
    echo "🔍 Troubleshooting information:"
    echo ""
    
    # Show container status
    echo "Container status:"
    docker ps -a --filter "name=power_bi" --filter "name=bi-"
    echo ""
    
    # Show recent logs for failed containers
    echo "Recent logs:"
    for container in power_bi_postgres bi-telegram-bot bi-photo-server power_bi_grafana; do
        if ! docker ps --filter "name=$container" --filter "status=running" | grep -q $container; then
            echo ""
            echo "=== $container logs ==="
            docker logs --tail=20 $container 2>/dev/null || echo "No logs available"
        fi
    done
    
    exit 1
fi
