USE telecom_dwh;

-- ============================================
-- 1. OVERALL REVENUE AND ARPU
-- ============================================

SELECT
    SUM(revenue_amount) AS total_revenue,
    COUNT(DISTINCT customer_key) AS active_customers,
    ROUND(
        SUM(revenue_amount)
        / NULLIF(COUNT(DISTINCT customer_key), 0),
        2
    ) AS arpu
FROM fact_customer_revenue;


-- ============================================
-- 2. AVERAGE TRANSACTION VALUE
-- ============================================

SELECT
    SUM(revenue_amount) AS total_revenue,
    SUM(transaction_count) AS total_transactions,
    ROUND(
        SUM(revenue_amount)
        / NULLIF(SUM(transaction_count), 0),
        2
    ) AS average_transaction_value
FROM fact_customer_revenue;


-- ============================================
-- 3. MONTHLY REVENUE PERFORMANCE
-- ============================================

SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.revenue_amount) AS total_revenue,
    SUM(f.transaction_count) AS total_transactions,
    COUNT(DISTINCT f.customer_key) AS active_customers,
    ROUND(
        SUM(f.revenue_amount)
        / NULLIF(COUNT(DISTINCT f.customer_key), 0),
        2
    ) AS arpu
FROM fact_customer_revenue f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


-- ============================================
-- 4. CAMPAIGN PERFORMANCE
-- ============================================

SELECT
    COALESCE(cp.campaign_id, 'UNMAPPED') AS campaign_id,
    COALESCE(cp.campaign_name, 'No Campaign / Unmapped') AS campaign_name,
    cp.campaign_type,
    cp.target_segment,
    cp.channel,
    SUM(f.revenue_amount) AS total_revenue,
    SUM(f.transaction_count) AS total_transactions,
    COUNT(DISTINCT f.customer_key) AS active_customers
FROM fact_customer_revenue f
LEFT JOIN dim_campaign cp
    ON f.campaign_key = cp.campaign_key
GROUP BY
    COALESCE(cp.campaign_id, 'UNMAPPED'),
    COALESCE(cp.campaign_name, 'No Campaign / Unmapped'),
    cp.campaign_type,
    cp.target_segment,
    cp.channel
ORDER BY
    total_revenue DESC;


-- ============================================
-- 5. CUSTOMER REVENUE ANALYSIS
-- ============================================

SELECT
    c.customer_id,
    c.customer_type,
    c.segment,
    c.region,
    c.status,
    SUM(f.revenue_amount) AS total_revenue,
    SUM(f.transaction_count) AS total_transactions,
    COUNT(DISTINCT f.date_key) AS active_days,
    ROUND(
        SUM(f.revenue_amount)
        / NULLIF(SUM(f.transaction_count), 0),
        2
    ) AS average_transaction_value
FROM fact_customer_revenue f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.customer_type,
    c.segment,
    c.region,
    c.status
ORDER BY
    total_revenue DESC;


-- ============================================
-- 6. CUSTOMER SEGMENT PERFORMANCE
-- ============================================

SELECT
    c.segment,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    SUM(f.revenue_amount) AS total_revenue,
    SUM(f.transaction_count) AS total_transactions,
    ROUND(
        SUM(f.revenue_amount)
        / NULLIF(COUNT(DISTINCT c.customer_id), 0),
        2
    ) AS revenue_per_customer
FROM fact_customer_revenue f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.segment
ORDER BY
    total_revenue DESC;