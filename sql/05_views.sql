CREATE VIEW vw_revenue_by_province AS
SELECT 
    o.province,
    ROUND(SUM(oi.quantity * oi.unitprice), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.province;


CREATE VIEW vw_customer_lifetime_value AS
SELECT 
    o.province,
    ROUND(
        SUM(oi.quantity * oi.unitprice) 
        / COUNT(DISTINCT o.customer_id),
    2) AS avg_customer_lifetime_value
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.province;


CREATE VIEW vw_monthly_revenue AS
SELECT 
    DATE_TRUNC('month', o.invoicedate) AS month,
    ROUND(SUM(oi.quantity * oi.unitprice), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY month;
