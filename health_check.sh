#!/bin/bash

# Health check script for Telegram Bot services
# This script checks if all services are running properly

PROJECT_DIR="$HOME/bi_telegram_bot"
LOG_FILE="$PROJECT_DIR/health_check.log"

# Function to log with timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to check if a process is running
check_process() {
    local service_name=$1
    local process_pattern=$2
    
    if pgrep -f "$process_pattern" > /dev/null; then
        log "✅ $service_name is running"
        return 0
    else
        log "❌ $service_name is not running"
        return 1
    fi
}

# Function to check Docker container
check_docker_service() {
    local service_name=$1
    local container_name=$2
    
    if docker ps --format "table {{.Names}}\t{{.Status}}" | grep -q "$container_name.*Up"; then
        log "✅ $service_name container is running"
        return 0
    else
        log "❌ $service_name container is not running"
        return 1
    fi
}

# Function to check HTTP endpoint
check_http() {
    local service_name=$1
    local url=$2
    local timeout=${3:-10}
    
    if curl -s --max-time "$timeout" "$url" > /dev/null 2>&1; then
        log "✅ $service_name HTTP endpoint is responsive"
        return 0
    else
        log "❌ $service_name HTTP endpoint is not responsive"
        return 1
    fi
}

# Function to check database connectivity
check_database() {
    if docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot > /dev/null 2>&1; then
        log "✅ Database is accessible"
        return 0
    else
        log "❌ Database is not accessible"
        return 1
    fi
}

# Function to restart a service if it's down
restart_service() {
    local service_name=$1
    local restart_command=$2
    
    log "🔄 Restarting $service_name..."
    eval "$restart_command"
    sleep 10
    
    if [ "$service_name" = "Bot" ]; then
        check_process "$service_name" "python.*main.py"
    elif [ "$service_name" = "Photo server" ]; then
        check_process "$service_name" "python.*photo_server.py"
    fi
}

# Change to project directory
cd "$PROJECT_DIR" || {
    log "❌ Could not change to project directory: $PROJECT_DIR"
    exit 1
}

log "🏥 Starting health check..."

# Check Docker services
docker_issues=0
check_docker_service "PostgreSQL" "power_bi_postgres" || docker_issues=$((docker_issues + 1))
check_docker_service "Grafana" "power_bi_grafana" || docker_issues=$((docker_issues + 1))

# Check database connectivity
check_database || docker_issues=$((docker_issues + 1))

# Check Python services
python_issues=0
check_process "Telegram Bot" "python.*main.py" || {
    python_issues=$((python_issues + 1))
    if [ "$1" = "--auto-restart" ]; then
        restart_service "Bot" "nohup python3 main.py > bot.log 2>&1 &"
    fi
}

check_process "Photo Server" "python.*photo_server.py" || {
    python_issues=$((python_issues + 1))
    if [ "$1" = "--auto-restart" ]; then
        restart_service "Photo server" "nohup python3 photo_server.py > photo_server.log 2>&1 &"
    fi
}

# Check HTTP endpoints
http_issues=0
check_http "Grafana" "http://localhost:80" || http_issues=$((http_issues + 1))
check_http "Photo Server" "http://localhost:8080" || http_issues=$((http_issues + 1))

# Check disk space
disk_usage=$(df -h . | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$disk_usage" -gt 90 ]; then
    log "⚠️ Disk usage is high: ${disk_usage}%"
else
    log "✅ Disk usage is normal: ${disk_usage}%"
fi

# Check memory usage
memory_usage=$(free | awk 'NR==2{printf "%.1f", $3*100/$2}')
if [ "$(echo "$memory_usage > 90" | bc)" -eq 1 ]; then
    log "⚠️ Memory usage is high: ${memory_usage}%"
else
    log "✅ Memory usage is normal: ${memory_usage}%"
fi

# Summary
total_issues=$((docker_issues + python_issues + http_issues))

if [ $total_issues -eq 0 ]; then
    log "🎉 All services are healthy!"
    exit 0
else
    log "⚠️ Found $total_issues issues:"
    log "   - Docker services: $docker_issues issues"
    log "   - Python services: $python_issues issues"
    log "   - HTTP endpoints: $http_issues issues"
    
    if [ "$1" != "--auto-restart" ]; then
        log "💡 Run with --auto-restart to automatically restart failed services"
    fi
    
    exit 1
fi
