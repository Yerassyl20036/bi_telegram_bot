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
    edu_emotional_state INTEGER DEFAULT 0,
    edu_conflicts_relations INTEGER DEFAULT 0,
    edu_bullying_cyberbullying INTEGER DEFAULT 0,
    edu_learning_problems INTEGER DEFAULT 0,
    edu_crisis_situations INTEGER DEFAULT 0,
    edu_preventive_consultation INTEGER DEFAULT 0,
    edu_other INTEGER DEFAULT 0,
    edu_total_psychologist INTEGER DEFAULT 0,
    edu_photo VARCHAR(500),
    edu_data_from VARCHAR(100) DEFAULT 'Telegram Bot',
    edu_add_inf TEXT,
    edu_contact VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
