#!/bin/bash

# VPS Setup Script for Power BI Telegram Bot
# Run this script on your VPS to prepare it for automated deployments

set -e

echo "🚀 Setting up VPS for Power BI Telegram Bot deployment..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install required packages
echo "📦 Installing required packages..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    htop \
    vim \
    unzip

# Install Docker
echo "🐳 Installing Docker..."
if ! command -v docker &> /dev/null; then
    # Add Docker's official GPG key
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # Set up the repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Install Docker Engine
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    # Add current user to docker group
    sudo usermod -aG docker $USER
    
    echo "✅ Docker installed successfully"
else
    echo "✅ Docker already installed"
fi

# Install Docker Compose (standalone)
echo "🐳 Installing Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "✅ Docker Compose installed successfully"
else
    echo "✅ Docker Compose already installed"
fi

# Create project directory
echo "📁 Setting up project directory..."
PROJECT_DIR="$HOME/bi_telegram_bot"
mkdir -p "$PROJECT_DIR"

# Set up Git configuration (if not already configured)
if [ -z "$(git config --global user.name)" ]; then
    echo "🔧 Configuring Git..."
    read -p "Enter your Git username: " git_username
    read -p "Enter your Git email: " git_email
    git config --global user.name "$git_username"
    git config --global user.email "$git_email"
fi

# Clone repository (if not already cloned)
if [ ! -d "$PROJECT_DIR/.git" ]; then
    echo "📥 Cloning repository..."
    read -p "Enter your GitHub repository URL (e.g., https://github.com/username/repo.git): " repo_url
    cd "$PROJECT_DIR"
    git clone "$repo_url" .
else
    echo "✅ Repository already exists"
fi

# Create .env.vps file template
echo "📝 Creating environment configuration template..."
ENV_FILE="$PROJECT_DIR/.env.vps"
if [ ! -f "$ENV_FILE" ]; then
    cat > "$ENV_FILE" << EOL
# Production Environment Configuration for VPS
# Copy this file to .env.vps and update with your actual values

# Database Configuration
DATABASE_URL=postgresql://bot_user:bot_password@postgres:5432/power_bi_bot
DATABASE_HOST=postgres
DATABASE_PORT=5432
DATABASE_NAME=power_bi_bot
DATABASE_USER=bot_user
DATABASE_PASSWORD=bot_password
DB_PASSWORD=bot_password

# Telegram Bot Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here

# Photo Server Configuration
PHOTO_DIR=/app/photos
PHOTO_URL_BASE=http://YOUR_VPS_IP:8080/photos
PHOTO_SERVER_PORT=8080
MAX_PHOTO_SIZE=10485760

# Database Table Prefix
TABLE_PREFIX=edu_

# Docker Configuration
DOCKER_USERNAME=your_docker_username

# Grafana Configuration
GF_SECURITY_ADMIN_PASSWORD=admin
EOL
    echo "✅ Created .env.vps template"
    echo "⚠️  Please edit $ENV_FILE with your actual configuration values"
else
    echo "✅ .env.vps already exists"
fi

# Set up firewall rules
echo "🔥 Configuring firewall..."
sudo ufw --force enable
sudo ufw allow ssh
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw allow 5432/tcp  # PostgreSQL
sudo ufw allow 3000/tcp  # Grafana
sudo ufw allow 8080/tcp  # Photo Server

# Create backup directory
echo "💾 Setting up backup directory..."
mkdir -p "$PROJECT_DIR/backups"

# Set up log rotation
echo "📋 Setting up log rotation..."
sudo tee /etc/logrotate.d/telegram-bot > /dev/null << EOL
$PROJECT_DIR/bot.log $PROJECT_DIR/photo_server.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    copytruncate
}
EOL

# Create systemctl service for monitoring (optional)
echo "🔧 Creating monitoring service..."
sudo tee /etc/systemd/system/telegram-bot-monitor.service > /dev/null << EOL
[Unit]
Description=Telegram Bot Monitor
After=docker.service

[Service]
Type=oneshot
ExecStart=/usr/bin/docker ps --filter "name=bi-telegram-bot" --format "{{.Status}}" | grep -q "Up"
User=$USER
WorkingDirectory=$PROJECT_DIR

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload

# Set up automatic Docker cleanup cron job
echo "🧹 Setting up automatic Docker cleanup..."
(crontab -l 2>/dev/null; echo "0 2 * * * /usr/bin/docker system prune -f --volumes") | crontab -

echo ""
echo "🎉 VPS setup completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Edit $PROJECT_DIR/.env.vps with your actual configuration"
echo "2. Ensure your GitHub Actions secrets are configured:"
echo "   - VPS_HOST: $(hostname -I | awk '{print $1}')"
echo "   - VPS_USERNAME: $USER"
echo "   - VPS_SSH_KEY: Your private SSH key"
echo "   - VPS_PORT: 22 (or your custom SSH port)"
echo "   - DOCKER_USERNAME: Your Docker Hub username"
echo "   - DOCKER_PASSWORD: Your Docker Hub password/token"
echo "3. Test the deployment by pushing to your main branch"
echo ""
echo "🌐 Your services will be available at:"
echo "   - Grafana: http://$(hostname -I | awk '{print $1}'):3000"
echo "   - Photo Server: http://$(hostname -I | awk '{print $1}'):8080"
echo "   - PostgreSQL: $(hostname -I | awk '{print $1}'):5432"
echo ""
echo "⚠️  Remember to reboot or re-login to apply Docker group membership!"
