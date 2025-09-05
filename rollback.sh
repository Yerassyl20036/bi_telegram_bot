#!/bin/bash

# Rollback script for Telegram Bot
# This script helps rollback to a previous version in case of deployment issues

set -e

echo "🔄 Starting rollback process..."

PROJECT_DIR="$HOME/bi_telegram_bot"
BACKUP_DIR="$PROJECT_DIR/backups"

cd "$PROJECT_DIR"

# Function to list available backups
list_backups() {
    echo "📋 Available database backups:"
    ls -la "$BACKUP_DIR"/backup_*.sql 2>/dev/null | nl || echo "No backups found"
}

# Function to restore database
restore_database() {
    local backup_file=$1
    
    if [ ! -f "$backup_file" ]; then
        echo "❌ Backup file not found: $backup_file"
        return 1
    fi
    
    echo "🔄 Restoring database from: $backup_file"
    
    # Stop services
    pkill -f "python.*main.py" || true
    pkill -f "python.*photo_server.py" || true
    
    # Start only postgres
    docker-compose up -d postgres
    sleep 10
    
    # Drop and recreate database
    docker exec power_bi_postgres psql -U bot_user -c "DROP DATABASE IF EXISTS power_bi_bot;"
    docker exec power_bi_postgres psql -U bot_user -c "CREATE DATABASE power_bi_bot;"
    
    # Restore backup
    docker exec -i power_bi_postgres psql -U bot_user power_bi_bot < "$backup_file"
    
    echo "✅ Database restored successfully"
}

# Function to rollback to previous git commit
rollback_git() {
    echo "🔄 Rolling back to previous commit..."
    
    if [ ! -d ".git" ]; then
        echo "❌ Not a git repository"
        return 1
    fi
    
    # Show recent commits
    echo "📋 Recent commits:"
    git log --oneline -10
    
    echo ""
    read -p "Enter commit hash to rollback to (or press Enter for previous commit): " commit_hash
    
    if [ -z "$commit_hash" ]; then
        commit_hash="HEAD~1"
    fi
    
    git reset --hard "$commit_hash"
    echo "✅ Rolled back to commit: $commit_hash"
}

# Main rollback menu
echo "🔄 Rollback Options:"
echo "1. Restore database only"
echo "2. Rollback code only"
echo "3. Full rollback (code + database)"
echo "4. Show service status"
echo "5. Show logs"
echo "6. Exit"

read -p "Choose an option (1-6): " choice

case $choice in
    1)
        list_backups
        read -p "Enter backup number or full path: " backup_choice
        
        if [[ "$backup_choice" =~ ^[0-9]+$ ]]; then
            # User entered a number
            backup_file=$(ls -t "$BACKUP_DIR"/backup_*.sql 2>/dev/null | sed -n "${backup_choice}p")
        else
            # User entered a path
            backup_file="$backup_choice"
        fi
        
        restore_database "$backup_file"
        ;;
        
    2)
        rollback_git
        ;;
        
    3)
        list_backups
        read -p "Enter backup number or full path: " backup_choice
        
        if [[ "$backup_choice" =~ ^[0-9]+$ ]]; then
            backup_file=$(ls -t "$BACKUP_DIR"/backup_*.sql 2>/dev/null | sed -n "${backup_choice}p")
        else
            backup_file="$backup_choice"
        fi
        
        rollback_git
        restore_database "$backup_file"
        
        # Restart services
        echo "🚀 Restarting services..."
        ./deploy.sh
        ;;
        
    4)
        echo "📊 Service Status:"
        echo ""
        echo "Docker containers:"
        docker-compose ps || echo "No containers running"
        
        echo ""
        echo "Python processes:"
        pgrep -f "python.*main.py" && echo "✅ Bot is running" || echo "❌ Bot is not running"
        pgrep -f "python.*photo_server.py" && echo "✅ Photo server is running" || echo "❌ Photo server is not running"
        ;;
        
    5)
        echo "📝 Recent Logs:"
        echo ""
        echo "=== Bot Log (last 20 lines) ==="
        tail -20 bot.log 2>/dev/null || echo "No bot log found"
        
        echo ""
        echo "=== Photo Server Log (last 20 lines) ==="
        tail -20 photo_server.log 2>/dev/null || echo "No photo server log found"
        
        echo ""
        echo "=== Docker Logs ==="
        docker-compose logs --tail=20 || echo "No docker logs available"
        ;;
        
    6)
        echo "👋 Exiting rollback script"
        exit 0
        ;;
        
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac

echo "🎉 Rollback operation completed!"
