-- P1 Table: Complaints and Suggestions
CREATE TABLE IF NOT EXISTS dbo.P1 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_problem TEXT,
    edu_describtion TEXT,
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- P2 Table: Ideas and Initiatives
CREATE TABLE IF NOT EXISTS dbo.P2 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_sphere VARCHAR(255),
    edu_result TEXT,
    edu_describtion TEXT,
    edu_author VARCHAR(255),
    edu_action TEXT,
    edu_status VARCHAR(100),
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- P3 Table: Psychological Support
CREATE TABLE IF NOT EXISTS dbo.P3 (
    id SERIAL PRIMARY KEY,
    edu_school VARCHAR(255),
    edu_date DATE,
    edu_time TIME,
    edu_role VARCHAR(255),
    edu_category VARCHAR(255),
    edu_additional TEXT,
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
