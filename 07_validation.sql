USE telecom_dwh;

-- ============================================
-- 1. RECORD COUNT RECONCILIATION
-- ============================================

SELECT
    (SELECT COUNT(*) FROM stg_customer) AS staging_customers,
    (SELECT COUNT(*) FROM dim_customer) AS warehouse_customers,
    (SELECT COUNT(*) FROM stg_campaign) AS staging_campaigns,
    (SELECT COUNT(*) FROM dim_campaign) AS warehouse_campaigns,
    (SELECT COUNT(*) FROM stg_recharge) AS staging_recharges,
    (SELECT COUNT(*) FROM fact_customer_revenue) AS warehouse_revenue_records;


-- ============================================
-- 2. UNMATCHED CUSTOMER CHECK
-- ============================================

SELECT
    r.customer_id
FROM stg_recharge r
LEFT JOIN dim_customer c
    ON r.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- ============================================
-- 3. UNMATCHED CAMPAIGN CHECK
-- Campaign mapping is optional in the fact table.
-- ============================================

SELECT
    r.campaign_id
FROM stg_recharge r
LEFT JOIN dim_campaign cp
    ON r.campaign_id = cp.campaign_id
WHERE r.campaign_id IS NOT NULL
  AND cp.campaign_id IS NULL;


-- ============================================
-- 4. DUPLICATE TRANSACTION CHECK
-- ============================================

SELECT
    transaction_id,
    COUNT(*) AS record_count
FROM fact_customer_revenue
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- ============================================
-- 5. NULL VALUE CHECK
-- ============================================

SELECT
    SUM(CASE WHEN date_key IS NULL THEN 1 ELSE 0 END) AS null_date_keys,
    SUM(CASE WHEN customer_key IS NULL THEN 1 ELSE 0 END) AS null_customer_keys,
    SUM(CASE WHEN campaign_key IS NULL THEN 1 ELSE 0 END) AS null_campaign_keys,
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS null_transaction_ids,
    SUM(CASE WHEN revenue_amount IS NULL THEN 1 ELSE 0 END) AS null_revenue
FROM fact_customer_revenue;


-- ============================================
-- 6. REVENUE RECONCILIATION
-- ============================================

SELECT
    (SELECT SUM(recharge_amount)
     FROM stg_recharge) AS staging_revenue,

    (SELECT SUM(revenue_amount)
     FROM fact_customer_revenue) AS warehouse_revenue,

    (
        (SELECT SUM(recharge_amount)
         FROM stg_recharge)
        -
        (SELECT SUM(revenue_amount)
         FROM fact_customer_revenue)
    ) AS revenue_difference;


-- ============================================
-- 7. FACT TABLE GRAIN VALIDATION
-- ============================================

SELECT
    COUNT(*) AS fact_rows,
    COUNT(DISTINCT transaction_id) AS distinct_transactions,
    SUM(transaction_count) AS transaction_count_sum
FROM fact_customer_revenue;