USE telecom_dwh;

-- ============================================
-- DIMENSION TABLE: DATE
-- ============================================

CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    year INT,
    week INT
);


-- ============================================
-- DIMENSION TABLE: CUSTOMER
-- ============================================

CREATE TABLE IF NOT EXISTS dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    msisdn VARCHAR(20),
    gender VARCHAR(10),
    age INT,
    customer_type VARCHAR(20),
    segment VARCHAR(30),
    region VARCHAR(30),
    activation_date DATE,
    status VARCHAR(20),
    created_date DATE
);


-- ============================================
-- DIMENSION TABLE: CAMPAIGN
-- ============================================

CREATE TABLE IF NOT EXISTS dim_campaign (
    campaign_key INT AUTO_INCREMENT PRIMARY KEY,
    campaign_id VARCHAR(20) NOT NULL,
    campaign_name VARCHAR(100),
    campaign_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    target_segment VARCHAR(30),
    channel VARCHAR(30),
    status VARCHAR(20)
);

