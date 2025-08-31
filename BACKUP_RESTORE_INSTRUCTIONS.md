# Database Backup & Restore Instructions

## 📥 **Created Backup**
- **File:** `backup_20250901_004921_with_data.sql`
- **Size:** 151 KB
- **Contains:** Complete database with all data (408 rows total)
- **Tables:** All 16 tables (P1-P3, Q1-Q5, S1-S8) with updated structure

## 🚀 **VPS Restore Commands**

### 1. Upload backup to VPS
```bash
# Copy backup file to your VPS
scp backup_20250901_004921_with_data.sql user@your-vps:/path/to/project/
```

### 2. Stop current containers
```bash
cd /path/to/project
docker-compose down -v  # This removes volumes and all data
```

### 3. Start containers with new structure
```bash
docker-compose up -d
# Wait for PostgreSQL to be ready
sleep 10
```

### 4. Restore backup
```bash
# Option A: Direct restore (recommended)
docker exec -i your_postgres_container_name psql -U bot_user < backup_20250901_004921_with_data.sql

# Option B: If above doesn't work, try this:
cat backup_20250901_004921_with_data.sql | docker exec -i your_postgres_container_name psql -U bot_user -d postgres
```

### 5. Verify restore
```bash
# Check if database exists and has data
docker exec your_postgres_container_name psql -U bot_user -d power_bi_bot -c "
SELECT 
    schemaname, 
    tablename, 
    n_tup_ins as inserted_rows 
FROM pg_stat_user_tables 
WHERE schemaname = 'dbo' 
ORDER BY tablename;
"
```

## ✅ **Expected Results After Restore**
- **P1:** 23 rows
- **P2:** 26 rows  
- **P3:** 8 rows (with emoji psychological fields)
- **Q1:** 30 rows
- **Q2:** 22 rows
- **Q3:** 14 rows
- **Q4:** 18 rows
- **Q5:** 1 row (with updated teacher absence structure)
- **S1-S7:** Various rows
- **S8:** 13 rows (with updated health categories structure)

**Total Expected: 408 rows**

## 🔧 **Updated Table Structures**

### Q5 (Teacher Availability) - NEW COLUMNS:
- `edu_total_teachers` (👥 Барлығы / Всего учителей)
- `edu_illness` (🤒 По болезни)
- `edu_business_trip` (✈️ Командировка)  
- `edu_personal_reasons` (🏠 Личные причины)
- `edu_professional_development` (🎓 Повышение квалификации)
- `edu_other` (📌 Прочее)

### S8 (Health Issues) - NEW COLUMNS:
- `edu_digestive_system` (🍽 ЖКТ)
- `edu_cold_flu` (Тұмау / ОРВИ)
- `edu_injuries` (🤕 Травмы)
- `edu_allergic_reactions` (🌸 Аллергии)
- `edu_neurological_general` (🧠 Неврологические)
- `edu_chronic_diseases` (♻️ Хронические заболевания)
- `edu_other` (📌 Прочее)
- `edu_total_medical` (Барлығы_медицина)

## 🔄 **Re-run Excel Import After Restore**
```bash
python excel_to_postgres.py
```

This should now work perfectly with the updated table structures!
