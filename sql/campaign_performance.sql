-- ============================================================
-- campaign_performance.sql
-- Campaign conversion and revenue metrics
-- Assumes campaign_results table loaded from Python output
-- ============================================================

-- 1. Overall campaign summary
SELECT
    grp                                             AS campaign_group,
    COUNT(*)                                        AS total_customers,
    SUM(converted)                                  AS conversions,
    ROUND(AVG(converted) * 100, 2)                  AS conversion_rate_pct,
    ROUND(SUM(campaign_order_value), 2)             AS total_revenue,
    ROUND(AVG(campaign_order_value)
        FILTER (WHERE converted = 1), 2)            AS avg_order_value_converters

FROM campaign_results
GROUP BY grp;


-- 2. Conversion rate by RFM segment and group
SELECT
    "Segment"                                       AS segment,
    grp                                             AS campaign_group,
    COUNT(*)                                        AS customers,
    SUM(converted)                                  AS conversions,
    ROUND(AVG(converted) * 100, 2)                  AS conversion_rate_pct,
    ROUND(SUM(campaign_order_value), 2)             AS revenue

FROM campaign_results
GROUP BY "Segment", grp
ORDER BY segment, grp;


-- 3. Churn risk breakdown — conversion by risk tier
SELECT
    churn_risk,
    grp                                             AS campaign_group,
    COUNT(*)                                        AS customers,
    SUM(converted)                                  AS conversions,
    ROUND(AVG(converted) * 100, 2)                  AS conversion_rate_pct

FROM campaign_results
WHERE churn_risk IS NOT NULL
GROUP BY churn_risk, grp
ORDER BY churn_risk, grp;


-- 4. Revenue uplift calculation
SELECT
    ROUND(SUM(CASE WHEN grp = 'treatment' THEN campaign_order_value ELSE 0 END), 2)  AS treatment_revenue,
    ROUND(SUM(CASE WHEN grp = 'control'   THEN campaign_order_value ELSE 0 END), 2)  AS control_revenue,
    ROUND(
        SUM(CASE WHEN grp = 'treatment' THEN campaign_order_value ELSE 0 END) -
        SUM(CASE WHEN grp = 'control'   THEN campaign_order_value ELSE 0 END),
    2)                                                                                 AS revenue_uplift,
    ROUND(
        (AVG(CASE WHEN grp = 'treatment' THEN converted END) -
         AVG(CASE WHEN grp = 'control'   THEN converted END)) * 100,
    2)                                                                                 AS conversion_uplift_pct

FROM campaign_results;
