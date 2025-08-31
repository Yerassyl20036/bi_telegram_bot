-- Create indexes for better performance

-- Indexes for S tables
CREATE INDEX IF NOT EXISTS idx_s1_school_date ON dbo.S1(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s1_status ON dbo.S1(edu_status);
CREATE INDEX IF NOT EXISTS idx_s1_created_at ON dbo.S1(created_at);

CREATE INDEX IF NOT EXISTS idx_s2_school_date ON dbo.S2(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s2_status ON dbo.S2(edu_status);
CREATE INDEX IF NOT EXISTS idx_s2_created_at ON dbo.S2(created_at);

CREATE INDEX IF NOT EXISTS idx_s3_school_date ON dbo.S3(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s3_status ON dbo.S3(edu_status);
CREATE INDEX IF NOT EXISTS idx_s3_created_at ON dbo.S3(created_at);

CREATE INDEX IF NOT EXISTS idx_s4_school_date ON dbo.S4(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s4_status ON dbo.S4(edu_status);
CREATE INDEX IF NOT EXISTS idx_s4_created_at ON dbo.S4(created_at);

CREATE INDEX IF NOT EXISTS idx_s5_school_date ON dbo.S5(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s5_status ON dbo.S5(edu_status);
CREATE INDEX IF NOT EXISTS idx_s5_created_at ON dbo.S5(created_at);

CREATE INDEX IF NOT EXISTS idx_s6_school_date ON dbo.S6(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s6_status ON dbo.S6(edu_status);
CREATE INDEX IF NOT EXISTS idx_s6_created_at ON dbo.S6(created_at);

CREATE INDEX IF NOT EXISTS idx_s7_school_date ON dbo.S7(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s7_status ON dbo.S7(edu_status);
CREATE INDEX IF NOT EXISTS idx_s7_created_at ON dbo.S7(created_at);

CREATE INDEX IF NOT EXISTS idx_s8_school_date ON dbo.S8(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_s8_created_at ON dbo.S8(created_at);

-- Indexes for Q tables
CREATE INDEX IF NOT EXISTS idx_q1_school_date ON dbo.Q1(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_q1_status ON dbo.Q1(edu_status);
CREATE INDEX IF NOT EXISTS idx_q1_created_at ON dbo.Q1(created_at);
CREATE INDEX IF NOT EXISTS idx_q1_grate_litter ON dbo.Q1(edu_grate, edu_litter);

CREATE INDEX IF NOT EXISTS idx_q2_school_date ON dbo.Q2(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_q2_status ON dbo.Q2(edu_status);
CREATE INDEX IF NOT EXISTS idx_q2_created_at ON dbo.Q2(created_at);
CREATE INDEX IF NOT EXISTS idx_q2_grate_litter ON dbo.Q2(edu_grate, edu_litter);

CREATE INDEX IF NOT EXISTS idx_q3_school_date ON dbo.Q3(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_q3_status ON dbo.Q3(edu_status);
CREATE INDEX IF NOT EXISTS idx_q3_created_at ON dbo.Q3(created_at);
CREATE INDEX IF NOT EXISTS idx_q3_grate_litter ON dbo.Q3(edu_grate, edu_litter);

CREATE INDEX IF NOT EXISTS idx_q4_school_date ON dbo.Q4(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_q4_status ON dbo.Q4(edu_status);
CREATE INDEX IF NOT EXISTS idx_q4_created_at ON dbo.Q4(created_at);

CREATE INDEX IF NOT EXISTS idx_q5_school_date ON dbo.Q5(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_q5_created_at ON dbo.Q5(created_at);

-- Indexes for P tables
CREATE INDEX IF NOT EXISTS idx_p1_school_date ON dbo.P1(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_p1_status ON dbo.P1(edu_status);
CREATE INDEX IF NOT EXISTS idx_p1_created_at ON dbo.P1(created_at);

CREATE INDEX IF NOT EXISTS idx_p2_school_date ON dbo.P2(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_p2_status ON dbo.P2(edu_status);
CREATE INDEX IF NOT EXISTS idx_p2_created_at ON dbo.P2(created_at);

CREATE INDEX IF NOT EXISTS idx_p3_school_date ON dbo.P3(edu_school, edu_date);
CREATE INDEX IF NOT EXISTS idx_p3_created_at ON dbo.P3(created_at);

-- Grant permissions to the bot user
GRANT ALL PRIVILEGES ON SCHEMA dbo TO bot_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA dbo TO bot_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA dbo TO bot_user;
