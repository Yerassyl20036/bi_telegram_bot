# GitHub Actions Deployment Setup Guide

This guide will help you configure automated deployment for your Telegram Bot project using GitHub Actions.

## 1. GitHub Repository Secrets

You need to add the following secrets to your GitHub repository:

### Go to GitHub → Your Repository → Settings → Secrets and variables → Actions

Add these secrets:

```
VPS_HOST = srv985126.hstgr.cloud
VPS_USERNAME = yerassyl  
VPS_PORT = 22
VPS_SSH_KEY = [Your private SSH key content]
```

### How to get your SSH key:

1. **On your local machine**, generate an SSH key pair if you don't have one:
```bash
ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
```

2. **Copy your public key to the VPS**:
```bash
ssh-copy-id yerassyl@srv985126.hstgr.cloud
```

3. **Get your private key content** for GitHub secrets:
```bash
cat ~/.ssh/id_rsa
```
Copy the entire content (including `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----`) and paste it as the `VPS_SSH_KEY` secret.

## 2. VPS Preparation

### SSH into your VPS and run these commands:

```bash
# 1. Install required packages
sudo apt update
sudo apt install -y docker.io docker-compose git python3 python3-pip

# 2. Add your user to docker group
sudo usermod -aG docker $USER

# 3. Log out and log back in for group changes to take effect
exit
# SSH back in

# 4. Clone your repository (if not already done)
cd ~
git clone https://github.com/Yerassyl20036/bi_telegram_bot.git
cd bi_telegram_bot

# 5. Set up the .env.vps file with your VPS configuration
cp .env.vps .env

# 6. Create necessary directories
mkdir -p photos backups

# 7. Install Python dependencies
python3 -m pip install --user -r requirements.txt

# 8. Test Docker
docker --version
docker-compose --version

# 9. Make scripts executable
chmod +x deploy.sh rollback.sh health_check.sh
```

## 3. Testing the Setup

### Test manual deployment first:
```bash
cd ~/bi_telegram_bot
./deploy.sh
```

### Check if services are running:
```bash
./health_check.sh
```

### View logs:
```bash
# Bot logs
tail -f bot.log

# Photo server logs  
tail -f photo_server.log

# Docker logs
docker-compose logs -f
```

## 4. GitHub Actions Workflow

The workflow will:

1. **On Pull Request**: Run tests and linting only
2. **On Push to main**: Run tests, then deploy to VPS if tests pass

### What the deployment does:
- ✅ Stops existing services gracefully
- ✅ Creates database backup
- ✅ Pulls latest code
- ✅ Updates environment configuration
- ✅ Starts Docker services (PostgreSQL + Grafana)
- ✅ Installs/updates Python dependencies
- ✅ Starts photo server
- ✅ Starts Telegram bot
- ✅ Verifies all services are running

## 5. Monitoring and Maintenance

### Set up a cron job for health checks:
```bash
# Edit crontab
crontab -e

# Add this line to check every 5 minutes and auto-restart failed services
*/5 * * * * cd /home/yerassyl/bi_telegram_bot && ./health_check.sh --auto-restart >> health_check.log 2>&1
```

### Useful commands:

```bash
# Check deployment status
./health_check.sh

# View recent logs
tail -20 bot.log
tail -20 photo_server.log

# Restart services manually
./deploy.sh

# Rollback if something goes wrong
./rollback.sh

# Check Docker status
docker-compose ps

# Check database
docker exec -it power_bi_postgres psql -U bot_user power_bi_bot
```

## 6. Troubleshooting

### Common issues and solutions:

**1. SSH connection fails:**
- Check if your VPS IP/hostname is correct
- Verify SSH key is properly configured
- Ensure port 22 is open

**2. Docker commands fail:**
- Make sure user is in docker group: `groups $USER`
- Restart Docker service: `sudo systemctl restart docker`

**3. Database connection fails:**
- Check if PostgreSQL container is running: `docker-compose ps`
- Verify database credentials in .env file
- Check Docker logs: `docker-compose logs postgres`

**4. Bot fails to start:**
- Check bot.log for errors: `tail -20 bot.log`
- Verify Telegram token in .env file
- Ensure all Python dependencies are installed

**5. Photo server fails:**
- Check photo_server.log: `tail -20 photo_server.log`
- Verify photos directory exists and is writable
- Check if port 8080 is available

### Emergency rollback:
```bash
cd ~/bi_telegram_bot
./rollback.sh
```

## 7. Optional: Systemd Services

For production environments, you may want to manage services with systemd:

```bash
# Follow instructions in systemd-services.txt
# This will make services start automatically on boot
```

## 8. Security Considerations

1. **Firewall**: Configure UFW to only allow necessary ports
```bash
sudo ufw allow 22    # SSH
sudo ufw allow 80    # Grafana
sudo ufw allow 8080  # Photo server
sudo ufw enable
```

2. **Environment variables**: Never commit .env files with real credentials

3. **Database**: PostgreSQL is only accessible locally (not exposed to internet)

4. **Backups**: Database backups are created automatically before each deployment

## 9. Service URLs

After deployment, your services will be available at:

- **Grafana Dashboard**: http://srv985126.hstgr.cloud:80
  - Username: admin
  - Password: admin123

- **Photo Server**: http://srv985126.hstgr.cloud:8080

- **Telegram Bot**: Search for your bot on Telegram

## 10. Next Steps

1. Add the GitHub secrets
2. Prepare your VPS
3. Test manual deployment
4. Push to main branch to trigger automatic deployment
5. Set up monitoring cron job
6. Configure alerts (optional)

The deployment will now happen automatically every time you push to the main branch! 🚀
