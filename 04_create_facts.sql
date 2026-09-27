USE telecom_dwh;

-- ============================================
-- FACT TABLE: CUSTOMER REVENUE
-- Grain:
-- One row represents one customer recharge
-- transaction.
-- ============================================

CREATE TABLE IF NOT EXISTS fact_customer_revenue (
    revenue_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    date_key INT NOT NULL,
    customer_key INT NOT NULL,
    campaign_key INT,
    transaction_id VARCHAR(30) NOT NULL,
    revenue_amount DECIMAL(12,2),
    transaction_count INT DEFAULT 1,

    -- Date dimension relationship
    CONSTRAINT fk_fact_date
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    -- Customer dimension relationship
    CONSTRAINT fk_fact_customer
        FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    -- Campaign dimension relationship
    CONSTRAINT fk_fact_campaign
        FOREIGN KEY (campaign_key)
        REFERENCES dim_campaign(campaign_key)
);