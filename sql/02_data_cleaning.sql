-- Create cleaned table

CREATE TABLE retail_clean AS
SELECT *
FROM raw_retail
WHERE Quantity > 0
  AND CustomerID IS NOT NULL;

-- Add province column

ALTER TABLE retail_clean
ADD COLUMN province VARCHAR(50);

-- Simulate Canadian provinces

UPDATE retail_clean
SET province = CASE 
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 0 THEN 'Ontario'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 1 THEN 'British Columbia'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 2 THEN 'Quebec'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 3 THEN 'Alberta'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 4 THEN 'Manitoba'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 5 THEN 'Saskatchewan'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 6 THEN 'Nova Scotia'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 7 THEN 'New Brunswick'
    WHEN MOD(ABS(HASHTEXT(CustomerID)), 10) = 8 THEN 'Newfoundland'
    ELSE 'Prince Edward Island'
END;
