USE telecom_dwh;

-- ============================================
-- STAGING TABLE: CUSTOMER
-- ============================================

CREATE TABLE IF NOT EXISTS stg_customer (
    customer_id VARCHAR(20),
    msisdn VARCHAR(20),
    gender VARCHAR(10),
    age INT,
    customer_type VARCHAR(20),
    segment VARCHAR(30),
    region VARCHAR(30),
    activation_date DATE,
    status VARCHAR(20));


-- ============================================
-- STAGING TABLE: CAMPAIGN
-- ============================================

CREATE TABLE IF NOT EXISTS stg_campaign (
    campaign_id VARCHAR(20),
    campaign_name VARCHAR(100),
    campaign_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    target_segment VARCHAR(30),
    channel VARCHAR(30),
    status VARCHAR(20));


-- ============================================
-- STAGING TABLE: RECHARGE
-- ============================================

CREATE TABLE IF NOT EXISTS stg_recharge (
    transaction_id VARCHAR(30),
    customer_id VARCHAR(20),
    transaction_date DATE,
    recharge_amount DECIMAL(12,2),
    payment_channel VARCHAR(30),
    recharge_type VARCHAR(30),
    campaign_id VARCHAR(20));


