# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Power BI Telegram bot system for collecting feedback data from schools in Kazakhstan. The bot conducts multilingual (Kazakh/Russian) surveys about various school issues and stores responses in a PostgreSQL database for analytics.

## Core Architecture

### Main Components
- **Telegram Bot** (`main.py`): Complex FSM-based survey bot using aiogram 3.x framework
- **Photo Server** (`photo_server.py`): HTTP server for serving uploaded images 
- **Database Layer**: PostgreSQL with 16 specialized tables (S1-S8, Q1-Q5, P1-P3)
- **Data Import Tool** (`excel_to_postgres.py`): Excel-to-PostgreSQL migration utility

### Survey Flow Architecture
The bot implements a sophisticated state machine with 16 different survey categories:
- **Safety/Cleanliness/Tech/Health (S1-S8)**: Infrastructure and facility issues
- **Study/Quality (Q1-Q5)**: Educational process problems
- **People (P1-P3)**: Human relations, ideas, psychological support

Each survey type follows a branching decision tree that dynamically determines the target database table based on user responses.

### Database Schema
- All tables follow `dbo.schema` with `edu_` prefixed columns
- Dynamic table mapping via `TABLE_MAP` dictionary connects survey types to database tables
- Comprehensive column mapping in `build_payload()` function handles data transformation

## Development Commands

### Database Operations
```bash
# Start database only
docker-compose up -d postgres

# Connect to database
docker exec -it power_bi_postgres psql -U bot_user -d power_bi_bot

# View all tables
\dt dbo.*

# Create database backup
docker exec power_bi_postgres pg_dump -U bot_user power_bi_bot > backup.sql

# Clear all survey data
docker exec -i power_bi_postgres psql -U bot_user -d power_bi_bot -c "
TRUNCATE TABLE dbo.p1, dbo.p2, dbo.p3, dbo.q1, dbo.q2, dbo.q3, dbo.q4, dbo.q5, dbo.s1, dbo.s2, dbo.s3, dbo.s4, dbo.s5, dbo.s6, dbo.s7, dbo.s8 RESTART IDENTITY CASCADE;
"
```

### Bot Development
```bash
# Install dependencies
pip install -r requirements.txt

# Run bot locally (requires .env with TELEGRAM_BOT_TOKEN and DATABASE_URL)
python main.py

# Run photo server
python photo_server.py

# Test deployment locally
./test-deployment-local.sh

# Full deployment
./deploy.sh
```

### Docker Operations  
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f telegram-bot
docker-compose logs -f postgres

# Stop and remove everything
docker-compose down -v
```

### Data Import
```bash
# Import Excel data (requires Data_DM (3).xlsx)
python excel_to_postgres.py
```

## Key Technical Details

### Environment Configuration
- `.env`: Local development environment
- `.env.vps`: Production VPS environment (copied to `.env` during deployment)
- Required vars: `TELEGRAM_BOT_TOKEN`, `DATABASE_URL`, `PHOTO_DIR`, `PHOTO_URL_BASE`

### Photo Handling
Photos are stored locally and served via a simple HTTP server. The bot generates unique filenames and returns public URLs for database storage.

### Multilingual Support
All user-facing strings are bilingual (Kazakh/Russian). Survey options and responses are stored in both languages with emoji prefixes for better UX.

### State Management
Complex FSM implementation with dynamic state routing based on user responses. The `other_input` state handles "Other" option flows with continuation logic.

### Data Transformation
The `dv()` function converts human-readable headers to database column names using the `PREFIX` (default: "edu_"). The `build_payload()` function maps survey responses to appropriate database schemas.

## Common Development Tasks

### Adding New Survey Questions
1. Add options to relevant arrays (e.g., `FOOD_OPTIONS`, `TECH_OPTIONS`)
2. Update state handlers in main.py  
3. Modify `build_payload()` to handle new fields
4. Update database schema if new columns needed

### Debugging Survey Flow
- Check FSM states in `Survey` class
- Trace `choose_block()` logic for table routing
- Verify `build_payload()` mappings for data transformation
- Use `test_db_connection()` to verify database connectivity

### Testing Changes
- Use `test-deployment-local.sh` to verify deployment steps
- Check logs: `bot.log`, `photo_server.log`, `docker-compose logs`
- Test individual survey flows by starting bot and following conversation paths

### Database Schema Changes
1. Update SQL files in `init-db/` directory
2. Modify `COLUMN_MAPPINGS` in `excel_to_postgres.py` if importing data
3. Update `build_payload()` function for new columns
4. Consider migration strategy for existing data

## Production Deployment

The system uses a bash-based deployment pipeline (`deploy.sh`) that:
1. Creates database backups
2. Stops existing services gracefully
3. Updates code from git
4. Restarts services with health checks
5. Verifies all components are running

Log locations in production:
- Bot: `~/bi_telegram_bot/bot.log`  
- Photo server: `~/bi_telegram_bot/photo_server.log`
- Database: `docker logs power_bi_postgres`
