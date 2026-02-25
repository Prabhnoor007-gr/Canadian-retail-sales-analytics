-- Create dimension tables

CREATE TABLE customers AS
SELECT DISTINCT
    CustomerID AS customer_id,
    province
FROM retail_clean;

CREATE TABLE products AS
SELECT DISTINCT
    StockCode AS product_id,
    Description,
    UnitPrice
FROM retail_clean;

-- Create fact table (orders)

CREATE TABLE orders AS
SELECT 
    InvoiceNo AS order_id,
    MIN(CustomerID) AS customer_id,
    MIN(InvoiceDate) AS invoicedate,
    MIN(province) AS province
FROM retail_clean
GROUP BY InvoiceNo;

-- Create order_items fact details

CREATE TABLE order_items AS
SELECT
    InvoiceNo AS order_id,
    StockCode AS product_id,
    Quantity,
    UnitPrice
FROM retail_clean;
