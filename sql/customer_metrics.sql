-- ============================================================
-- customer_metrics.sql
-- Customer-level CRM metrics for dashboard and reporting
-- ============================================================

-- 1. Core customer metrics
SELECT
    c.customer_unique_id                                        AS customer_id,
    COUNT(DISTINCT o.order_id)                                  AS order_count,
    SUM(p.payment_value)                                        AS total_spend,
    AVG(p.payment_value)                                        AS avg_order_value,
    MIN(o.order_purchase_timestamp)                             AS first_order_date,
    MAX(o.order_purchase_timestamp)                             AS last_order_date,
    DATE_PART('day', NOW() - MAX(o.order_purchase_timestamp))   AS recency_days,
    DATE_PART('day', NOW() - MIN(o.order_purchase_timestamp))   AS tenure_days,
    AVG(r.review_score)                                         AS avg_review_score

FROM olist_customers              c
JOIN olist_orders                 o  ON c.customer_id = o.customer_id
JOIN olist_order_payments         p  ON o.order_id    = p.order_id
LEFT JOIN olist_order_reviews     r  ON o.order_id    = r.order_id

WHERE o.order_status = 'delivered'

GROUP BY c.customer_unique_id;


-- 2. Monthly revenue trend
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp)    AS month,
    COUNT(DISTINCT o.order_id)                         AS total_orders,
    COUNT(DISTINCT c.customer_unique_id)               AS unique_customers,
    SUM(p.payment_value)                               AS total_revenue,
    AVG(p.payment_value)                               AS avg_order_value,
    COUNT(DISTINCT CASE
        WHEN prev.customer_unique_id IS NOT NULL THEN c.customer_unique_id
    END)                                               AS returning_customers

FROM olist_orders                 o
JOIN olist_customers              c  ON o.customer_id = c.customer_id
JOIN olist_order_payments         p  ON o.order_id    = p.order_id
LEFT JOIN (
    SELECT DISTINCT customer_unique_id FROM olist_customers
    JOIN olist_orders ON olist_customers.customer_id = olist_orders.customer_id
    WHERE order_status = 'delivered'
) prev ON c.customer_unique_id = prev.customer_unique_id
    AND DATE_TRUNC('month', o.order_purchase_timestamp) >
        (SELECT MIN(DATE_TRUNC('month', order_purchase_timestamp)) FROM olist_orders)

WHERE o.order_status = 'delivered'

GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;


-- 3. Revenue by product category
SELECT
    t.product_category_name_english  AS category,
    COUNT(DISTINCT oi.order_id)       AS total_orders,
    SUM(oi.price)                     AS total_revenue,
    AVG(oi.price)                     AS avg_item_price,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers

FROM olist_order_items                    oi
JOIN olist_products                       pr ON oi.product_id  = pr.product_id
JOIN product_category_name_translation    t  ON pr.product_category_name = t.product_category_name
JOIN olist_orders                         o  ON oi.order_id    = o.order_id
JOIN olist_customers                      c  ON o.customer_id  = c.customer_id

WHERE o.order_status = 'delivered'

GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC;
