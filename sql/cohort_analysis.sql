-- ============================================================
-- cohort_analysis.sql
-- Monthly cohort retention analysis
-- ============================================================

-- Step 1: Assign each customer to their acquisition cohort (first order month)
WITH customer_cohorts AS (
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS cohort_month
    FROM olist_customers  c
    JOIN olist_orders     o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),

-- Step 2: Get all order months per customer
customer_orders AS (
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month
    FROM olist_customers  c
    JOIN olist_orders     o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
),

-- Step 3: Calculate months since acquisition for each order
cohort_data AS (
    SELECT
        co.customer_unique_id,
        cc.cohort_month,
        co.order_month,
        DATE_PART('month', AGE(co.order_month, cc.cohort_month))::INT AS months_since_first_order
    FROM customer_orders     co
    JOIN customer_cohorts    cc ON co.customer_unique_id = cc.customer_unique_id
)

-- Step 4: Build cohort retention table
SELECT
    cohort_month,
    months_since_first_order,
    COUNT(DISTINCT customer_unique_id)                                              AS customers,
    COUNT(DISTINCT customer_unique_id) * 100.0 /
        FIRST_VALUE(COUNT(DISTINCT customer_unique_id))
        OVER (PARTITION BY cohort_month ORDER BY months_since_first_order)          AS retention_rate

FROM cohort_data
GROUP BY cohort_month, months_since_first_order
ORDER BY cohort_month, months_since_first_order;
