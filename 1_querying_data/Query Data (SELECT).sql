-- To connect to the intended database
USE MyDatabase

-- Query Data (SELECT)
-- SELECT, DISTINCT, TOP (LIMIT), FROM, WHERE, GROUP BY, HAVING, ORDER BY
SELECT * 
FROM customers

SELECT *
FROM orders

SELECT
	first_name,
	country,
	score
FROM customers

--WHERE
SELECT *
FROM customers
WHERE score !=0 --or score > 0

SELECT 
	first_name,
	country
FROM customers
WHERE country = 'Germany' --value (country) that contain char must use single quote

--ORDER BY
SELECT *
FROM customers
ORDER BY 
	country ASC,
	score DESC

-- HAVING
-- GROUP BY 1 is wrong in SQL Server
SELECT 
	country,
	AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY avg_score DESC

-- DISTINCT
SELECT DISTINCT country
FROM customers

-- TOP
SELECT TOP 3 *
FROM customers

-- Retrieve Top 3 customers with highest score
-- Cant directly use select top 3 scores, because top syntax just select by row 1,2,3 not highest score
-- Therefore, use ORDER BY to sort the table

SELECT TOP 3 *
FROM customers
ORDER BY score DESC

-- Get two most recent orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC

-- double queries

SELECT  *
FROM customers


SELECT  *
FROM orders

SELECT 123 AS static_number
SELECT 'Hello' AS static_string

-- We can have data from database, and add something from us (static values)
SELECT  
	id,
	first_name,
	'New Customer' AS customer_type
FROM customers
