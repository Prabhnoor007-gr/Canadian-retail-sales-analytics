-- Revenue by Province
SELECT 
    o.province,
    ROUND(SUM(oi.quantity * oi.unitprice), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.province
ORDER BY total_revenue DESC;


-- Total Orders by Province
SELECT 
    province,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY province
ORDER BY total_orders DESC;


-- Average Order Value
SELECT 
    o.province,
    ROUND(
        SUM(oi.quantity * oi.unitprice) 
        / COUNT(DISTINCT o.order_id),
    2) AS avg_order_value
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.province
ORDER BY avg_order_value DESC;


-- Repeat Rate
SELECT 
    province,
    ROUND(
        COUNT(CASE WHEN order_count > 1 THEN 1 END) * 100.0
        / COUNT(*),
    2) AS repeat_customer_rate
FROM (
    SELECT 
        o.customer_id,
        o.province,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM orders o
    GROUP BY o.customer_id, o.province
) AS customer_orders
GROUP BY province
ORDER BY repeat_customer_rate DESC;


-- Customer Lifetime Value
SELECT 
    o.province,
    ROUND(
        SUM(oi.quantity * oi.unitprice) 
        / COUNT(DISTINCT o.customer_id),
    2) AS avg_customer_lifetime_value
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.province
ORDER BY avg_customer_lifetime_value DESC;


-- Monthly Revenue
SELECT 
    DATE_TRUNC('month', o.invoicedate) AS month,
    ROUND(SUM(oi.quantity * oi.unitprice), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
