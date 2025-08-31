-- Q1 Table: Schedule Problems
CREATE TABLE IF NOT EXISTS dbo.Q1 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_problem TEXT,
    edu_grate VARCHAR(50),
    edu_litter VARCHAR(10),
    edu_subject VARCHAR(255),
    edu_problem_date DATE,
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Q2 Table: Subject Issues
CREATE TABLE IF NOT EXISTS dbo.Q2 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_problem TEXT,
    edu_grate VARCHAR(50),
    edu_litter VARCHAR(10),
    edu_subject VARCHAR(255),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Q3 Table: Discipline Issues
CREATE TABLE IF NOT EXISTS dbo.Q3 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_problem TEXT,
    edu_full_name VARCHAR(255),
    edu_grate VARCHAR(50),
    edu_litter VARCHAR(10),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Q4 Table: Food Issues
CREATE TABLE IF NOT EXISTS dbo.Q4 (
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

-- Q5 Table: Teacher Availability
CREATE TABLE IF NOT EXISTS dbo.Q5 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_total_teachers INTEGER DEFAULT 0,       -- 👥 Барлығы / Всего учителей
    edu_illness INTEGER DEFAULT 0,              -- 🤒 Ауырғанына байланысты / По болезни
    edu_business_trip INTEGER DEFAULT 0,        -- ✈️ Іссапар / Командировка
    edu_personal_reasons INTEGER DEFAULT 0,     -- 🏠 Жеке себептер / Личные причины
    edu_professional_development INTEGER DEFAULT 0, -- 🎓 Біліктілікті арттыру / Повышение квалификации
    edu_other INTEGER DEFAULT 0,               -- 📌 Басқа / Прочее
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
