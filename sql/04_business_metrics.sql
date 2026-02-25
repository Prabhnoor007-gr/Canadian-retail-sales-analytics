SELECT 
    o.province,
    ROUND(SUM(oi.quantity * oi.unitprice), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY o.province
ORDER BY total_revenue DESC;
