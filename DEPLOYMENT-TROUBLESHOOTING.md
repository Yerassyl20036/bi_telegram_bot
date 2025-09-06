# Deployment Troubleshooting Guide

## Understanding Exit Codes

### Exit Code 143 - NOT AN ERROR!
- **What it means**: Process exited due to SIGTERM (normal shutdown)
- **When it happens**: When Docker gracefully stops containers with `docker-compose down`
- **Is it bad?**: No! This is the expected behavior for clean shutdowns
- **Mathematical breakdown**: 143 = 128 + 15 (where 15 is SIGTERM signal number)

### Other Common Exit Codes
- **0**: Success
- **1**: General error
- **2**: Misuse of shell built-ins
- **125**: Container failed to run
- **126**: Container command not executable
- **127**: Container command not found
- **137**: Container killed with SIGKILL (143 + 9)

## Current Deployment Architecture

### Production (VPS via GitHub Actions)
- **Method**: Fully containerized with Docker Compose
- **Services**: 4 containers (PostgreSQL, Telegram Bot, Photo Server, Grafana)
- **Deployment**: Automated via GitHub Actions SSH
- **Logs**: Available via `docker logs [container-name]`

### Local Development
- **Method**: Mixed (Docker for DB, Python processes for services)
- **Services**: Docker PostgreSQL + local Python processes
- **Deployment**: Manual via `deploy.sh`
- **Logs**: Available in `bot.log`, `photo_server.log`

## Deployment Steps Breakdown

### GitHub Actions Deployment Process
1. **Build Docker Images**: Creates containerized versions of bot and photo server
2. **Push to Docker Hub**: Makes images available for VPS
3. **SSH to VPS**: Connects to production server
4. **Stop Services**: Gracefully shuts down running containers (exit 143 is normal!)
5. **Pull Images**: Downloads latest Docker images
6. **Start Services**: Launches all services in correct order
7. **Health Checks**: Verifies all services are running properly

## Common Issues and Solutions

### Issue: "Process exited with status 143"
**Status**: ✅ Normal (not an error)
**Solution**: No action needed - this indicates clean shutdown

### Issue: PostgreSQL not ready
**Symptoms**: Database connection timeouts
**Solutions**:
1. Increase wait time in deployment script
2. Check PostgreSQL logs: `docker logs power_bi_postgres`
3. Verify database credentials in `.env.vps`

### Issue: Bot container not starting
**Symptoms**: Bot container exits immediately
**Solutions**:
1. Check bot logs: `docker logs bi-telegram-bot`
2. Verify `TELEGRAM_BOT_TOKEN` in environment
3. Ensure database is accessible
4. Check for Python dependency issues

### Issue: Photo server not responding
**Symptoms**: HTTP requests to port 8080 fail
**Solutions**:
1. Check photo server logs: `docker logs bi-photo-server`
2. Verify port mapping in docker-compose.yml
3. Ensure photos directory exists and has correct permissions

### Issue: Services fail after deployment
**Symptoms**: Containers exit after seemingly successful deployment
**Debugging steps**:
1. Check all container logs: `docker-compose logs`
2. Verify environment variables: `docker exec [container] env`
3. Test database connectivity: `docker exec power_bi_postgres pg_isready`
4. Check resource usage: `docker stats`

## Troubleshooting Commands

### Check Service Status
```bash
# View all containers
docker ps -a

# View running containers only
docker ps

# Check specific service logs
docker logs bi-telegram-bot --tail 50
docker logs bi-photo-server --tail 50
docker logs power_bi_postgres --tail 50

# Follow logs in real-time
docker logs bi-telegram-bot -f
```

### Database Debugging
```bash
# Check if PostgreSQL is ready
docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot

# Connect to database
docker exec -it power_bi_postgres psql -U bot_user -d power_bi_bot

# View database tables
docker exec -it power_bi_postgres psql -U bot_user -d power_bi_bot -c "\\dt dbo.*"
```

### Network Testing
```bash
# Test photo server locally
curl http://localhost:8080/

# Test from within container network
docker exec bi-telegram-bot curl http://bi-photo-server:8080/

# Check container networking
docker network ls
docker inspect bi_telegram_bot_app-network
```

### Resource Monitoring
```bash
# Check resource usage
docker stats

# Check disk space
df -h

# Check memory usage
free -h

# Check running processes
top
```

## Environment Files

### Required Variables for VPS (.env.vps)
```bash
TELEGRAM_BOT_TOKEN=your_actual_bot_token
DATABASE_URL=postgresql://bot_user:secure_password@postgres:5432/power_bi_bot
DB_PASSWORD=secure_password
PHOTO_DIR=/app/photos
PHOTO_URL_BASE=http://your_vps_ip:8080
DOCKER_USERNAME=your_dockerhub_username
```

### Local Development (.env)
```bash
TELEGRAM_BOT_TOKEN=your_test_bot_token
DATABASE_URL=postgresql://bot_user:bot_password@localhost:5432/power_bi_bot
DB_PASSWORD=bot_password
PHOTO_DIR=./photos
PHOTO_URL_BASE=http://localhost:8080
```

## Testing Deployments

### Local Testing
```bash
# Test Docker deployment locally
./test-docker-deployment.sh

# Test traditional deployment
./test-deployment-local.sh

# Manual testing
docker-compose up -d
docker-compose logs -f
```

### Production Testing
```bash
# SSH into VPS
ssh root@your_vps_ip

# Check services
cd ~/bi_telegram_bot
docker ps
docker-compose ps

# View recent deployments
ls -la ~/bi_telegram_bot/backups/
```

## Performance Optimization

### Resource Limits
Consider adding resource limits to docker-compose.yml:
```yaml
services:
  telegram-bot:
    deploy:
      resources:
        limits:
          memory: 512M
          cpus: '0.5'
```

### Database Optimization
```bash
# Check database size
docker exec power_bi_postgres psql -U bot_user -d power_bi_bot -c "SELECT pg_database_size('power_bi_bot');"

# Optimize database
docker exec power_bi_postgres psql -U bot_user -d power_bi_bot -c "VACUUM ANALYZE;"
```

## Backup and Recovery

### Database Backups
```bash
# Create manual backup
docker exec power_bi_postgres pg_dump -U bot_user power_bi_bot > backup_$(date +%Y%m%d).sql

# Restore from backup
docker exec -i power_bi_postgres psql -U bot_user -d power_bi_bot < backup_file.sql
```

### Container Data
```bash
# Backup persistent volumes
docker run --rm -v power_bi_postgres_data:/data -v $(pwd):/backup alpine tar czf /backup/postgres_data.tar.gz /data
```

## When to Escalate

Contact system administrator if:
1. VPS is completely unresponsive
2. Docker daemon is not running
3. Persistent storage issues
4. Network connectivity problems
5. Resource exhaustion (CPU/Memory/Disk)

## Quick Health Check Script

```bash
#!/bin/bash
echo "=== Quick Health Check ==="
echo "Containers:"
docker ps --format "table {{.Names}}\t{{.Status}}"
echo ""
echo "Database:"
docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot && echo "✅ Healthy" || echo "❌ Failed"
echo ""
echo "Photo Server:"
curl -f http://localhost:8080/ >/dev/null 2>&1 && echo "✅ Responding" || echo "❌ Not responding"
echo ""
echo "Recent logs (last 5 lines):"
docker-compose logs --tail 5
```

This guide should help you understand and troubleshoot deployment issues. Remember: **Exit code 143 is normal and expected during shutdowns!**
