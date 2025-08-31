-- Initialize database with proper schema and tables for Power BI Telegram Bot

-- Create schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS dbo;

-- S1 Table: Class Cleanliness
CREATE TABLE IF NOT EXISTS dbo.S1 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_class_num VARCHAR(50),
    edu_floor VARCHAR(50),
    edu_classroom VARCHAR(100),
    edu_problem TEXT,
    edu_condition VARCHAR(100),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S2 Table: Common Places Cleanliness
CREATE TABLE IF NOT EXISTS dbo.S2 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_loc_num VARCHAR(50),
    edu_floor VARCHAR(50),
    edu_location VARCHAR(100),
    edu_place VARCHAR(255),
    edu_problem TEXT,
    edu_condition VARCHAR(100),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S3 Table: Temperature
CREATE TABLE IF NOT EXISTS dbo.S3 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_loc_num VARCHAR(50),
    edu_floor VARCHAR(50),
    edu_location VARCHAR(100),
    edu_place VARCHAR(255),
    edu_problem TEXT,
    edu_condition VARCHAR(100),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S4 Table: Safety Hazards
CREATE TABLE IF NOT EXISTS dbo.S4 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_problem TEXT,
    edu_condition VARCHAR(100),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S5 Table: Security Incidents
CREATE TABLE IF NOT EXISTS dbo.S5 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_incident VARCHAR(255),
    edu_describtion TEXT,
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S6 Table: Security Guard Issues
CREATE TABLE IF NOT EXISTS dbo.S6 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_security TEXT,
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S7 Table: Technical Issues
CREATE TABLE IF NOT EXISTS dbo.S7 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_problem TEXT,
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- S8 Table: Health Issues
CREATE TABLE IF NOT EXISTS dbo.S8 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_digestive_system INTEGER DEFAULT 0,     -- 🍽 Ас қорыту жүйесі / ЖКТ (пищеварительная система)
    edu_cold_flu INTEGER DEFAULT 0,             -- Тұмау / ОРВИ и простудные заболевания
    edu_injuries INTEGER DEFAULT 0,             -- 🤕 Жарақаттар / Травмы
    edu_allergic_reactions INTEGER DEFAULT 0,   -- 🌸 Аллергиялық реакциялар / Аллергические реакции
    edu_neurological_general INTEGER DEFAULT 0, -- 🧠 Неврологиялық және жалпы жағдай / Неврологические и общее самочувствие
    edu_chronic_diseases INTEGER DEFAULT 0,     -- ♻️ Созылмалы аурулардың асқынуы / Обострение хронических заболеваний
    edu_other INTEGER DEFAULT 0,               -- 📌 Басқа / Прочее
    edu_total_medical INTEGER DEFAULT 0,       -- Барлығы_медицина
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
