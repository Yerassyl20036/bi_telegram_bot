# Power BI Telegram Bot with PostgreSQL

This project contains a Telegram bot for collecting feedback data for Power BI analytics, with a PostgreSQL database backend.

## Quick Start

### 1. Prerequisites
- Docker and Docker Compose installed
- Python 3.8+ (for running the bot)

### 2. Start the Database

```bash
# Start PostgreSQL database
docker-compose up -d

# Check if database is running
docker-compose ps
```

This will:
- Create a PostgreSQL 15 database named `power_bi_bot`
- Create a user `bot_user` with password `bot_password`
- Automatically create all required tables (S1-S8, Q1-Q5, P1-P3)
- Set up proper indexes for performance

### 3. Database Connection Details

- **Host**: localhost
- **Port**: 5432
- **Database**: power_bi_bot
- **Username**: bot_user
- **Password**: bot_password
- **Connection URL**: `postgresql://bot_user:bot_password@localhost:5432/power_bi_bot`

### 4. Tables Created

The following tables will be automatically created:

#### Safety/Cleanliness/Tech/Health (S1-S8):
- **S1**: Class cleanliness
- **S2**: Common places cleanliness  
- **S3**: Temperature issues
- **S4**: Safety hazards
- **S5**: Security incidents
- **S6**: Security guard issues
- **S7**: Technical issues
- **S8**: Health issues

#### Study/Quality (Q1-Q5):
- **Q1**: Schedule problems
- **Q2**: Subject issues
- **Q3**: Discipline issues
- **Q4**: Food issues
- **Q5**: Teacher availability

#### People (P1-P3):
- **P1**: Complaints and suggestions
- **P2**: Ideas and initiatives
- **P3**: Psychological support

### 5. Install Python Dependencies

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
# venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 6. Configure Environment Variables

Create a `.env` file with your Telegram bot token and other credentials:

```env
TELEGRAM_BOT_TOKEN=your_bot_token_here
DATAVERSE_BASE_URL=https://your-org.crm4.dynamics.com/
DATAVERSE_TENANT_ID=your-tenant-id
DATAVERSE_CLIENT_ID=your-client-id
DATAVERSE_CLIENT_SECRET=your-client-secret
DATAVERSE_PREFIX=edu_
```

### 7. Run the Bot

```bash
python main.py
```

## Database Management

### View Tables
```bash
# Connect to PostgreSQL
docker exec -it power_bi_postgres psql -U bot_user -d power_bi_bot

# List all tables
\dt dbo.*

# View table structure
\d dbo.s1

# Exit
\q
```

### Stop and Clean Up
```bash
# Stop containers
docker-compose down

# Remove data (WARNING: This will delete all data!)
docker-compose down -v
```

### Backup Database
```bash
# Create backup
docker exec power_bi_postgres pg_dump -U bot_user power_bi_bot > backup.sql

# Restore backup
docker exec -i power_bi_postgres psql -U bot_user power_bi_bot < backup.sql
```

## Troubleshooting

### Check Database Logs
```bash
docker-compose logs postgres
```

### Check Database Connection
```bash
docker exec power_bi_postgres pg_isready -U bot_user -d power_bi_bot
```

### Reset Database
```bash
# Stop and remove containers and volumes
docker-compose down -v

# Start again (will recreate tables)
docker-compose up -d
```
clear all the tables

docker exec -i power_bi_postgres psql -U bot_user -d power_bi_bot -c "
TRUNCATE TABLE dbo.p1, dbo.p2, dbo.p3, dbo.q1, dbo.q2, dbo.q3, dbo.q4, dbo.q5, dbo.s1, dbo.s2, dbo.s3, dbo.s4, dbo.s5, dbo.s6, dbo.s7, dbo.s8 RESTART IDENTITY CASCADE;
"