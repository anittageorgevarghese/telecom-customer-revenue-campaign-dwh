USE telecom_dwh;

-- ============================================
-- LOAD FACT_CUSTOMER_REVENUE
-- Grain:
-- One row represents one customer recharge
-- transaction.
-- ============================================

INSERT INTO fact_customer_revenue (
    date_key,
    customer_key,
    campaign_key,
    transaction_id,
    revenue_amount,
    transaction_count
)
SELECT
    d.date_key,
    c.customer_key,
    cp.campaign_key,
    r.transaction_id,
    r.recharge_amount,
    1 AS transaction_count
FROM stg_recharge r

-- Lookup customer surrogate key
JOIN dim_customer c
    ON r.customer_id = c.customer_id

-- Lookup date surrogate key
JOIN dim_date d
    ON r.transaction_date = d.full_date

-- Lookup campaign surrogate key
LEFT JOIN dim_campaign cp
    ON r.campaign_id = cp.campaign_id;