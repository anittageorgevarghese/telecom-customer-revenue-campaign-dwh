-- ============================================
-- LOAD DIM_CAMPAIGN
-- ============================================

INSERT INTO dim_campaign (
    campaign_id,
    campaign_name,
    campaign_type,
    start_date,
    end_date,
    target_segment,
    channel,
    status
)
SELECT
    campaign_id,
    campaign_name,
    campaign_type,
    start_date,
    end_date,
    target_segment,
    channel,
    status
FROM stg_campaign;