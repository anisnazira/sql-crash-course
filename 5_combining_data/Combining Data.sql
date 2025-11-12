 -- Combining Data
 -- JOINS, SET Operators

 -- How to combine 2 tables?
 -- Ask yourslef are you combining columns or rows?
 -- If columns, then its JOINs - Inner join, full join, right join..
 -- If rows, its SET operators - Union, union all, except, intercept


 -- JOIN
 -- Must have Key column (same column, primary key)


 -- SET operators
 -- Must have same column

 -- NO JOIN
SELECT * FROM customers
SELECT * FROM orders


-- INNER JOIN
-- Returns only matching rows from both tables

-- Get all customers along with their orders , but only for customers who have placed an order

SELECT * 
FROM customers
INNER JOIN orders
ON id = customer_id

-- but, it resulted in too many columns unneeded
-- therefore, specify only necessary column

SELECT 
	id,
	first_name,
	order_id,
	sales
FROM customers
INNER JOIN orders
ON id = customer_id

-- theres also potential ambiguity when 2 table have similar column name
-- to differentiate, put table name
-- table customers, column id --> customers.id

SELECT 
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id

-- and, can do even shorter name to simplify

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

-- LEFT JOIN
-- Returns all rows from left and only matching from right
-- Orders of left and right table matters 

-- Get all customers along with their orders, including those without orders 
SELECT * 
FROM customers
LEFT JOIN orders
ON id = customer_id

-- OR

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON id = customer_id

-- Get all customers along with their orders, including orders without matching customers 
-- (LEFT JOIN)

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON id = customer_id

SELECT * FROM customers
SELECT * FROM orders

-- RIGHT JOIN
-- Returns all rows from right and only matching from left
-- Orders of left and right table matters 


-- Get all customers along with their orders, including orders without matching customers 

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id

-- FULL JOIN
-- Return all rows from both table

-- Get all customers and all orders, even if theres no match

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id

-- ADVANCED
-- LEFT ANTI JOIN
-- Returns row from the left table that has no match in right table 
-- NO ANTI CLAUSE, USE WHERE TO FILTER. SO ITS A LEFT JOIN + WHERE 
-- TABLE A AND B ORDER IS IMPORTANT

-- Get all customers who havents place any order
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTI JOIN
-- Returns row from the right table that has no match in right table 

-- Get all orders without matching customers
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

-- FULL ANTI JOIN
-- ONLY UNMATCHING ROWS
-- Returns only rows thst dont match in either tables
-- Use full join + WHERE + OR (2 filters)

-- Find customers without orders and orders without customers
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE 
	c.id IS NULL
	OR
	o.customer_id IS NULL

-- BONUS
-- Get all customers along with their orders, but only for customers who have placed an order
-- WITHOUT INNER JOIN

-- FULL JOIN
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE 
	c.id IS NOT NULL
	AND
	o.customer_id IS NOT NULL

-- LEFT JOIN
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL

SELECT * FROM customers
SELECT * FROM orders
-- INNER JOIN (TO REFER)
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

-- CROSS JOIN
-- Combines every row from the left with every row from the right
-- all possible combinations, cartesian join
-- dont need keywords ON, means no need any condition
-- may not makes sense, but u might want to see pattern/ relation/ testing

SELECT *
FROM customers
CROSS JOIN orders

-- so many JOIN types, how do you choose it?
-- if you want to find only matching : inner join
-- if you to find all rows on both side : full join
-- if you to find all rows on one side : left join
-- if you want to find only unmatching on both side : full anti join
-- if you want to find only unmatching on one side : left anti join
-- best join is left because you might need to combine mutliple tables, so u get overlapping one. control using WHERE


-- Using SalesDB, retrieve a list of all orders, along with the related customers, product, and employee details

USE SalesDB
SELECT * FROM Sales.Customers
SELECT * FROM Sales.Employees
SELECT * FROM Sales.Orders
SELECT * FROM Sales.OrdersArchive
SELECT * FROM Sales.Products 

SELECT 
	so.OrderID,
	sc.FirstName AS CustomerFirstName,
	sc.LastName AS CustomerLastName,
	sp.Product AS ProductName,
	so.Sales,
	se.FirstName AS SalesPersonFirstName,
	se.LastName AS SalesPersonLastName
FROM Sales.Orders AS so
LEFT JOIN Sales.Customers AS sc
ON so.CustomerID = sc.CustomerID
LEFT JOIN Sales.Products AS sp
ON so.ProductID = sp.ProductID
LEFT JOIN Sales.Employees AS se
ON so.SalesPersonID = se.EmployeeID


-- Combining Data Part 2

-- SET Operators
-- Union, union all, except, intercept
-- To combine rows
-- Rule 1: SET operators can use in all clause; where, join, group by, having
-- except for order by. is allowed only once at the end of the query

SELECT
FirstName,
LastName
FROM Sales.Customers

UNION 

SELECT
FirstName,
LastName
FROM Sales.Employees

ORDER BY FirstName --must be always place at the end of the query 

-- Rule 2: Num of column must be the same

SELECT
CustomerID, -- query 1st has 3 columns
FirstName,
LastName
FROM Sales.Customers

UNION 

SELECT
FirstName, -- here only 2 columns
LastName
FROM Sales.Employees


-- Rule 3: Data types must be compatible (varchar, int etc)
-- to check that, browse columns at the left 

SELECT
CustomerID, -- int data type
LastName
FROM Sales.Customers

UNION 

SELECT
FirstName, -- varchar data type
LastName
FROM Sales.Employees

-- mismatch data type cause errors. cant compare int to varchar


-- Rule 4: Order of columns must be the same

SELECT
LastName,
CustomerID
FROM Sales.Customers

UNION 

SELECT
EmployeeID, -- SQL will map lastName to EmployeeID, which is wrong
LastName -- First query has LastName too, but not the same order
FROM Sales.Employees

-- Rule 5: First Query Controls Aliases. First query responsible for naming column names in the result

SELECT
CustomerID AS ID,
LastName
FROM Sales.Customers

UNION 

SELECT
EmployeeID,
LastName  AS Last_Name --this aliases will be totally ignored
FROM Sales.Employees

-- Rule 6 : Mapping Correct columns. even if all rules are met and SQL shows no errors, the result may be incorrect


SELECT
FirstName,
LastName
FROM Sales.Customers

UNION 

SELECT
LastName, -- swap with FirstName
FirstName
FROM Sales.Employees

-- it shows no errors because both are same data types (varchar), but the result is wrong
 

 -- UNION
 -- Returns all ditrict rows from both queries
 -- Removes duplicates rows

 -- Combine the data from employees and customers into one table
SELECT 
FirstName,
LastName
FROM Sales.Employees

UNION 

SELECT 
FirstName,
LastName
FROM Sales.Customers

 -- UNION ALL
 -- Returns all rows from both queries
 -- Including duplicates


 -- Combine the data from employees and customers into one table, including duplicates
SELECT 
FirstName,
LastName
FROM Sales.Customers

UNION ALL

SELECT 
FirstName,
LastName
FROM Sales.Employees

-- Union All vs Union
-- When to use either of these?
-- Union All is generally faster than Union, because it doesnt performs addtional step like removing duplicates
-- If you are confidentd there are no duplicates, use union all
-- or use union all to find duplicates and quality issue



-- EXCEPT
-- Returns all distinct rows from the first 

-- Find employees that are not customers at the same time
SELECT 
FirstName,
LastName
FROM Sales.Employees

EXCEPT

SELECT 
FirstName,
LastName
FROM Sales.Customers


-- INTERSECT
-- Returns only the rows that are common in both queries
-- Very similar to inner join
-- Removes dupe

-- Find employees who also a customers

SELECT 
FirstName,
LastName
FROM Sales.Employees

INTERSECT

SELECT 
FirstName,
LastName
FROM Sales.Customers

-- Union use cases, combine information
-- Combine similar information before analyzing the data


-- Orders are stored in separate tables (Orders and OrdersArchive)
--	Combine all orders into one report without duplicates

SELECT * FROM Sales.Orders
SELECT * FROM Sales.OrdersArchive

SELECT 
'Orders' AS SourceTable,
[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
FROM Sales.Orders

UNION

SELECT 
'OrdersArchive' AS SourceTable,
[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID
-- However, this query is quick and dirty and not following best practices. List the columns not use asterisk
-- because at times, we might change the table name, orders

-- DELTA detection
-- 'Orders' AS SourceTable, line is to display source for each record. Static table. Best for data analytics

-- Data completeness check (EXCEPT)
-- EXCEPT operator can be used to compare tables to detect disrepancies between databases
-- From data source to go to data warehouse, there are same data, so we want to filter duplicates
-- And also if you want to move all data in database A to B. use except to make sure except is empty. means all data is transferred
-- To improve quality of data migration
