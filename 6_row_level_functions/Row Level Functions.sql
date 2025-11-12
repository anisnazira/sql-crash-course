

-- Row level functions
-- String, Number, Date & Time, Null, Case statement funtion
-- Functions : accepts input value, processes it, returns an output value
-- Single row functions (LOWER()) and Multi row functions (SUM())
-- Nested functions : Function inside funtion
-- Maria -> LEFT(2) -> Ma -> LOWER() -> ma
-- Therefore, LEN(LOWER(LEFT('Maria', 2)))


-- Single row functions : String, Numeric, Data and Time (mostly for data engineer)
-- Multi row functions : Aggregate (basic), window (advance)


-- String funtions : Manipulation, Calculation, String extraction  (how to extract from string value)
-- Manipulation : Concat, Upper, Lower, Trim, Replace
-- Calculation : LEN
-- String extration : LEFT, RIGHT, SUBSTRING


-- Manipulation
-- Concat : Combine multiple string into one
-- Lets say you have first name and last name is separate columns, doesnt makes sense right
-- You want to combine the column, use concat

-- Show a list of customers' first names together with their country in one column

SELECT 
first_name,
country,
CONCAT (first_name,'-', country) AS 'Name + Country'
FROM customers


-- UPPER & LOWER
-- converts all characters to uppercase and lowercase

-- Tranform the customers's first name to lowercase
-- Convert's customer first name to uppercase

SELECT 
first_name,
country,
CONCAT (first_name,'-', country) AS 'Name + Country',
LOWER (first_name) AS lower_name,
UPPER (first_name) AS upper_name
FROM customers


-- TRIM
-- Removes leading and trailing spaces

-- Find customers whose first name contains leading or trailing spaces
-- using WHERE

SELECT
	first_name
FROM customers
WHERE first_name != TRIM(first_name)

-- OR TO CHECK USING LEN
SELECT
	first_name,
	LEN(first_name) AS len_name,
	LEN(TRIM(first_name)) AS trim_len_name,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM customers


SELECT 
first_name,
country,
CONCAT (first_name,'-', country) AS 'Name + Country',
LOWER (first_name) AS lower_name,
UPPER (first_name) AS upper_name,
TRIM (first_name) AS clean_name
FROM customers

-- REPLACE
-- Lets say you have phone numbers, but you want to repalce dash - with / slah
-- Not only replace but also remove. remove using blank " "
-- SYNTAX : VALUE, OLD VALUE, NEW VALUE

SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-',' ') AS clean_phone

-- Replace file format from txt to csv

SELECT
'report.txt' AS old_file,
REPLACE('report.txt', '.txt', '.srv') AS new_file

-- Calculation
-- LEN
-- Calculate num/ word
-- Calculate even the dash 2026-01-02

-- Calculate the length of each customer's first name

SELECT
first_name,
LEN(first_name) AS length_name
FROM customers


-- String extraction
-- Left & Right
-- Extract specific characters from the start and end
-- SYNTAX : LEFT (Value, No of characters)

-- Maria
-- LEFT(Maria, 2) = Ma
-- RIGHT(Maria, 2) = ia

-- Retrieve first & last 2 characters of each first name

SELECT
first_name,
LEFT (TRIM(first_name), 2) AS First_Two,
RIGHT (TRIM(first_name), 2) AS Last_Two
FROM customers

-- SUBSTRING
-- Extract a part of string at a specified position
-- Similar, but we dont want first or last, we want exact position
-- SYNTAX : SUBSTRING (Value, Start, Length)

-- After the 2nd character extract 2 characters
-- Means the start is 3rd character
-- SUBSTRING ('Maria', 3, 2) : ri


-- After the 2nd character extract ALL characters
-- harder, you have diffferent names with different length
-- so, dont use static numbers. use function LEN()

-- Retrieve list of customers' first names after removing the first character

SELECT
	first_name,
	SUBSTRING(TRIM(first_name),2, LEN(first_name)) AS part_name
FROM customers

-- END OF STRING FUNTIONS
-- B. Number functions

-- 1. ROUND


SELECT 
3.516 AS Num,
ROUND (3.516,2) AS round_2,
ROUND (3.516,1) AS round_1,
ROUND (3.516,0) AS round_0

-- 2. ABS
-- Returns absolute (positive)value of a number, removing any rengative sign

SELECT
-10,
ABS(-10),
ABS(10)

-- C. Date & Time functions
-- 2025-11-06
-- 18:55:45
-- If you combine both date and time, its called timestamp in (Oracle, Postgres, MySQL)
-- DateTime in SQL Server

SELECT
OrderID,
OrderDate,
ShipDate,
CreationTime,
'2025-08-020' Hardcoded,
GETDATE() TODAY
FROM Sales.Orders

-- Values
-- 3 different sources to query the date
-- 1. Date column from a table (stored inside database)
-- 2. Hardcoded constant string value.. like static numbers
-- 3. GETDATE() Function. Returns current date and time of executing the query


-- Functions Overview
-- Can extract different part of date. Want months only
-- Can change date format. using slash 08/2/2025 or 20 Aug 2025
-- Calculations. Difference between 2 dates
-- Validate the date to know if SQL understand


-- Date Extractions
-- DAY(), MONTH(), YEAR()
-- Reutrns the day, month, year from a date

SELECT
OrderID,
CreationTime,
YEAR(CreationTime) AS Year,
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Day,
DATEPART(week, CreationTime) Week_dp,
DATEPART(quarter, CreationTime) Qtr_dp,
DATEPART(hour, CreationTime) hr_dp,
DATENAME(weekday, CreationTime) Week_dn,
DATENAME(month, CreationTime) month_dn,
DATENAME(day, CreationTime) day_dn, -- because of DATENAME(), this will be stored as string instead of int despite being numbers
DATETRUNC(minute, CreationTime) minute_dt,
DATETRUNC(month, CreationTime) month_dt,
EOMONTH(CreationTime) EndOfMonth,
CAST(DATETRUNC(month, CreationTime) AS DATE) StartofMonth
FROM Sales.Orders

-- DATEPART()
-- Returns specific part of the date as a number
-- In the date, we can also find by week, quarter etc
-- DATEPART (part, date)
-- EX: DATEPART(month, OrderDate)
-- month can also refers as mm (abbreviation)

-- DATENAME()
-- Returns the name of the date part
-- DATEPART(part, date)

-- DATETRUNC()
-- Truncates date to specific part
-- DATETRUNC(part, date)
-- if you said DATETRUNC minute, means you are interested minutes level onwards (years, month, day,hours, minutes)
-- Seconds will be reset to 0. Not interested
-- If truncate month, day will be reset to 01. cause theres no 00 date

SELECT
CreationTime,
COUNT(*) 
FROM Sales.Orders
GROUP BY CreationTime --1 Shows that we will not get 2 orders at the same time

SELECT
DATETRUNC(month,CreationTime) Creation,
COUNT(*) 
FROM Sales.Orders
GROUP BY DATETRUNC(month,CreationTime)
-- only 3 rows bcs 3 months. 4 orders in january

-- EOMONTH()
-- Returns last day of a month
-- change only the day info
-- 2025-02-01 -> 2025-02-28
-- EOMONTH(date)

-- so, is theres function to get start of the month? no. but theres a trick
-- using DATETRUNC(month, CreationTime)
-- but it will return many 00:00:00000
-- change data type using CAST(DATETRUNC(month, CreationTime) AS DATE) StartOfMonth
-- helpful if generating a report


-- Data Aggregations
-- Why do we need to extract date part from a date
-- if you want to make Sales by year, quarter

-- How many orders were placed each year


SELECT
CAST(DATETRUNC(year,CreationTime) AS DATE) Creation,
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATETRUNC(year,CreationTime)

SELECT
YEAR(OrderDate),
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- How many orders were placed each month


SELECT
MONTH(OrderDate),
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- OR
SELECT
DATENAME(month, CreationTime) month_dn,
COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month, CreationTime)
ORDER BY 2

-- Show all orders that were placed during the month of February

SELECT 
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2 --DONT USE DATENAME, FILTERING USING INT IS FASTER THAN STRING

-- Functions Comparison
-- to choose which one functions see -> 6:03:31

-- FORMAT & CASTING
-- Format, Convert, Cast
-- Casting : Changing data type from one to another. using CAST or CONVERT()

-- 2025 Can be represented as YYYY. Called format specifier
-- YYYY-MM-dd HH:mm:ss -- small mm cause big MM represent month

-- FORMAT()
-- Formats a date or time value
-- Syntax: FORMAT(value, format [,culture])
-- culture is optional. means shows a value whether its time data or num in the specific region
-- Ex: FORMAT(OrderDate,'dd/MM/yyyy')
--	   FORMAT(OrderDate,'dd/MM/yyyy', 'ja-JP') -- format in the style of Japan

SELECT 
OrderID,
CreationTime,
FORMAT(CreationTime,'MM--dd-yyyyy') USA_Format,
FORMAT(CreationTime,'dd-MM-yyyy') Euro,
FORMAT(CreationTime,'dd') dd,
FORMAT(CreationTime,'ddd') ddd, -- short name of the day
FORMAT(CreationTime,'dddd') dddd, -- Full name of the day
FORMAT(CreationTime,'MM') MM,
FORMAT(CreationTime,'MMM') MMM,
FORMAT(CreationTime,'MMMM') MMMM
FROM Sales.Orders


-- Show CreationTime using the following format:
-- Day Wed Jan Q1 2025 12:34:56 PM

SELECT
OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime,'ddd MMM ') + 
'Q' + DATENAME(quarter, CreationTime) + ' ' + 
FORMAT(CreationTime,'yyyy HH:mm:s tt') 
AS CustomFormat
FROM Sales.Orders

-- Data Aggregations
-- Normally report sales by month use Jan 2025, Feb 25..


SELECT
FORMAT(OrderDate, 'MMM yy') OrderDate,
COUNT(*) AS SalesByMonth
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy')

-- yy is 25. yyyy is 2025
-- hh is 12 hour. HH is 24 hour
-- Data Standardization
-- Data coming from csv, api, database to central storage minght be different
-- need to formatting for storage to do analysis

-- CONVERT()
-- Change value to diff type
-- CAST () JUST CHANGING DATA TYPE
-- CONVERT DO BOTH CASTING AND FORMATTING
-- Syntex: CONVERT(data_type, value [,style])

SELECT
CONVERT(INT, '123') AS [String to Int CONVERT],
CONVERT(DATE, '2025-09-20') AS [String to Date CONVERT],
CreationTime,
CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
CONVERT(VARCHAR, CreationTime, 32) AS [USA Std Style:32],
CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std Style:34]
FROM Sales.Orders

-- CAST
-- CAST(value AS data_type)

SELECT
CAST('123' AS INT) [String to INT],
CAST( 123 AS VARCHAR) AS [INT to String],
CAST('2025-08-20' AS DATE) AS [String to Date],
CAST('2025-08-20' AS DATETIME) AS [String to Datetime],
CreationTime,
CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders


-- Calculation
-- DATEADD & DATEDIFF

-- DATEADD()
-- 2025-08-20 , sometimes we want to add 3years to the date to 2028
-- can you for substract to using negative
-- Syntax: DATEADD (part, interval, date)
-- Ex: DATEADD( year, 2, OrderDate) -- want to change year, add 2 months at OrderDate

SELECT
OrderID,
OrderDate,
DATEADD(day, -10, OrderDate) AS TenDaysBefore,
DATEADD(MONTH, 3, OrderDate) AS ThreeMLaters,
DATEADD(year, 2, OrderDate) AS TwoYearsLaters,
DATEDIFF(day, OrderDate,ShipDate)
FROM Sales.Orders

-- DATEDIFF()
-- Find difference between two dates
-- have order and shipping date
-- Syntax: DATEDIFF (part, start_date, end_date)
-- state diff in year months or days


-- Calculate age of employees


SELECT 
BirthDate,
DATEDIFF(year, BirthDate, GETDATE()) Age
FROM Sales.Employees

-- Find the average shipping duration in days for each month

SELECT
--MONTH(OrderDate) AS OrderDate,
DATENAME(month, OrderDate) OrderMonth,
AVG(DATEDIFF(day, OrderDate,ShipDate)) SverageShip
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate) 

-- TimeGap
-- Find the number of days between each orders and the previous orders
-- use LAG() to access value from previous record

SELECT
OrderID,
OrderDate CurrentOrderDate,
LAG(OrderDate) OVER (ORDER BY OrderDate) PrevOrderDate,
DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate) Gap
FROM Sales.Orders
 
 -- shopee


 -- VALIDATION

 -- ISDATE()
 -- Check whether the value is a date. Return 1 is valid date

 SELECT
 ISDATE('2025-08-20')check1,
 ISDATE('123') check2,
 ISDATE('20-08-2025') check3, --bcs not following standard format
 ISDATE('2025') check4, -- understand as year
 ISDATE('08') check5-- not understand as month

 -- help in finding data quality issues

 SELECT
	 --CAST(OrderDate AS DATE) OrderDate,
	 OrderDate,
	 ISDATE(OrderDate),
	 CASE WHEN ISDATE(OrderDate) = 1 THEN  CAST(OrderDate AS DATE)
	 END NewOrderDate
 FROM
 (
	 SELECT '2025-08-20' AS OrderDate UNION
	 SELECT '2025-08-21' UNION
	 SELECT '2025-08-23' UNION
	 SELECT '2025-08' 
 )t
 WHERE ISDATE(OrderDate) = 0

 -- SQL didnt identify '2025-08'  as a date. so to check, use above

 -- NULL FUNCTIONS
 -- Want to replace  NULL value into number or vice versa
 -- ISNULL, COALESCE(), NULLIF, IS NULL (with space), IS NOT NULL (false)


 -- ISNULL()
 -- Replace NULL with specific value
 -- ISNULL (value, replacement_value) --IF SQL encounter NULL, it replace with other value
 -- ISNULL (shipping_address, Billing_address)

 -- COALESCE()
 -- Return first non null value from a list (dlm bebanyak value, dia pilih value yg tak null)
 -- accept list of many value
 -- better than ISNULL

 -- Find average scores of the customers

 SELECT *
 FROM Sales.Customers


SELECT 
CustomerID,
Score,
AVG(COALESCE(Score, 0))  OVER () AS avg_score
FROM Sales.Customers

-- Handle the NULL before doing mathematical operations
-- NULL + 5 = NULL

-- Display the full name of customers in a single field by merging their first and last names,
-- and add 10 bonus points to each customer's score


SELECT *
FROM Sales.Customers

SELECT
COALESCE(FirstName, '') FirstName2,
COALESCE(LastName, '') LastName2,
CONCAT(COALESCE(FirstName, ''), ' ' , COALESCE(LastName, '')) AS name,
-- OR COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS Fullname
Score,
COALESCE(Score,0) AS Score2,
COALESCE(Score,0) + 10 AS Finalscore 
FROM Sales.Customers

-- Can use CONCAT or just simply use +

-- Handle NULL before JOINS
-- SQL will not find match with NULL
-- therefore, replace dgn ISNULL utk samakan 2 table

ON a.year = b.year
AND ISNULL (a.type, ' ') = ISNULL (b.type, ' ')

-- but the value of the table is still NULL, we just changed at the queary

-- SORTING DATA
-- Handle NULL before sorting data
-- in order by, NULL order is the lowest
-- NULL, 15, 25 ASC

-- Sort the customer from lowest to highest scores, with NULL appearing last

SELECT
CustomerID,
Score
FROM Sales.Customers
ORDER BY Score ASC

-- not solved yet

-- METHOD 1
-- Replace NULLS with very big number

SELECT
CustomerID,
Score,
COALESCE(Score, 9999)
FROM Sales.Customers
ORDER BY COALESCE(Score, 9999)

-- METHOD 2

SELECT
CustomerID,
Score,
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

-- Order by do 2, first sort by flag (case when) then score
-- so null value, the only 1 in flag will sorted to last
-- Basically make column that give 1 for NULL case

-- NULLIF()
-- Compares 2 expression returns:
-- NULL if they are equal, first value, if they are not equal
-- NULLIF(value1, value2)
-- NULLIF(Price, -1)
-- If price equal to negative one, returns NULL
-- because data quality issue we have price that is negative
 
 NULLIF(Price, -1)

 -- NULLIFF DIVISION BY ZERO
 -- Preventing error dividing by zero

 -- Find the sales price for each order by dividing the sales by the quantity

 SELECT
 OrderID,
 Sales,
 Quantity,
 Sales/NULLIF( Quantity,0) AS Price
 FROM Sales.Orders

-- IS NULL & IS NOT NULL
-- Return true is value IS NULL and vice versa
-- Value IS NULL
-- like boolean
-- searching for missing information

-- identify the customers who have no scores 

SELECT *
FROM Sales.Customers
WHERE Score IS NULL

-- IS NULL with ANTI JOINS
-- LEFT ANTI JOIN in another terms is
-- Left Join + IS NULL

-- Finding the unmatched rows between 2 tables

-- List all details for customers who have not placed any orders

SELECT 
a.*,
o.OrderID
FROM Sales.Customers as a
LEFT JOIN Sales.Orders as o
ON a.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL -- OR  o.CustomerID IS NULL bcs the customer id not appear on order table

-- NULL vs Empty vs Space
-- NULL is when u dont know the value. Length is also NULL
-- Empty string is value with zero character. Length is 0
-- Space is when u enter unknowingly but it still takes up storage. Its a string value that has one or more space characters. Length is 1

WITH Orders AS(
SELECT 1 Id, '' Category UNION
SELECT 2, ' ' UNION
SELECT 3, '    '
)
SELECT
*,
DATALENGTH(Category) CategoryLen
FROM Orders

-- use DATALENGTH() instead of len(). len() ignores trailing spaces and only work with char type.
-- Dealing with real world data, you are guaranteed data with messy structure
-- Therefore its important to define DATA POLICY. rule how it should be handled


-- DATA POLICY 1: only use NULLs and empty strings, but avoid blank spaces.
-- remove spaces using TRIM(Category)
-- empty string is '' without space. blank space is '     '


-- DATA POLICY 2: only use NULLs and avoid  empty strings and blank spaces.


-- DATA POLICY 3: Use default value 'unknown' and avoid using NULLs, empty strings, blank space

WITH Orders AS(
SELECT 1 Id, '' Category UNION
SELECT 2, ' ' UNION
SELECT 3, '    ' UNION
SELECT 4, 'A' UNION
SELECT 5, NULL
)
SELECT
*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category), '') Policy2,
COALESCE(NULLIF(TRIM(Category), '') , 'unknown')  Policy3
FROM Orders

-- coalesce replace null with first non null value
-- policy2 is the best, takes less storage and good performance. 
-- if doing data preparation before insert into table, database policy 2  better
-- if data preparation before present to users in terms of power bi, tableau
-- because to present null in the report its hard to read

WITH Orders AS(
SELECT 1 Id, '' Category UNION
SELECT 2, ' ' UNION
SELECT 3, '    ' UNION
SELECT 4, 'A' UNION
SELECT 5, NULL '    '
)
SELECT
*,
TRIM(Category) Policy1,
DATALENGTH(Category) CategoryLen,
NULLIF(TRIM(Category), '') Policy2,
COALESCE(NULLIF(TRIM(Category), '') , 'unknown')  Policy3
FROM Orders


-- CASE STATEMENT
-- evaluates list of conditions and returns a value when the first condition is met
-- starts with CASE, end with END
-- condition is WHEN, is met THEN, is not met ELSE
-- If you dont put ELSE, then if not met, result is NULL
-- If you use else, then theres no NULL in the results

-- DATA ANALYST CASE STATEMENT:
-- Main purpose of CASE STATEMENT is for data transformation. Create new columns based on existing data
-- Also for categorizing data into different categories based on conditions

-- Generate a report showing the total sales for each category:
--- High: If the sales higher than 50
--- Meidum : 20-50
--- Lower: equal or lower than 20
-- Sort the result from lowest to highest

SELECT 
OrderID,
Sales,
CASE 
	WHEN Sales >50 THEN 'High'
	WHEN Sales >20  THEN 'Medium'
	ELSE 'Low' END Category
FROM Sales.Orders
ORDER BY Sales


-- but you want report how many total sales for high, how many for low etc only
-- so need to aggregate

SELECT 
Category,
SUM(Sales) AS TotalSales
FROM(
	SELECT 
OrderID,
Sales,
CASE 
	WHEN Sales >50 THEN 'High'
	WHEN Sales >20  THEN 'Medium'
	ELSE 'Low' END Category
FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC

-- CASE STATEMENT RULES
-- 1. Data Type must be matching (high, medium, low)
-- Case can be use everywhere. join, group by etc


-- Retrieve employee details with gender displayed as full text

SELECT 
EmployeeID,
COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS Fullname,
Gender,
CASE
WHEN Gender ='M' THEN 'Male'
WHEN Gender ='F' THEN 'Female'
ELSE 'Not Available' END Gender
FROM Sales.Employees

-- Retrieved customers details with abbreviated country code
SELECT DISTINCT Country
FROM Sales.Customers

SELECT 
CustomerID,
COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName,
CASE
WHEN Country = 'Germany' THEN 'DE'
WHEN Country = 'USA' THEN 'US'
ELSE 'Not Available' END CountryAbbr
FROM Sales.Customers

-- CASE STATEMENT QUICKFORM
-- If youre using it from mapping values, you will end up writing same thing

SELECT 
CustomerID,
COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName,
CASE Country
WHEN  'Germany' THEN 'DE'
WHEN 'USA' THEN 'US'
ELSE 'Not Available' END CountryAbbr
FROM Sales.Customers

-- only for one column and only for equal operator
-- but not recommended

-- CASE STATEMENT CAN HANDLE NULL


-- Find average scores of customers and treat NULLs as 0

SELECT *
FROM Sales.Customers


SELECT 
CustomerID,
COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName,
Score,
CASE
	WHEN Score IS NULL THEN 0 
	ELSE Score 
END ScoreClean,

AVG(Score) OVER () AvgCust,

AVG(CASE
	WHEN Score IS NULL THEN 0 
	ELSE Score 
END) OVER () CleanAvgCust
FROM Sales.Customers

-- dont do Score = NULL, do Score IS NULL

-- Conditional Aggregation
-- amazing technique for deep dive data

-- Count how many times each customer has made an order with sales greater than 30

SELECT *
FROM Sales.Customers

SELECT *
FROM Sales.Orders

SELECT 
	CustomerID,
	SUM(CASE
		WHEN Sales > 30 THEN 1 
		ELSE 0 
	END ) TotalOrderHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID


-- first, flag with 0 or 1 whether sales higher than 30 or not
-- next calculate how many have 1

-- AGGREGATION & ANALYTICAL FUNCTION

-- accept multiple rows as multiple input and produce 1 output
-- simple but powerful
-- COUNT, SUM, AVG, MAX , MIN

-- Find the total number of customers
--  Find the total sales of all orders
--  Find the average sales of all orders
--  Find the highest & lowest sales of all orders

SELECT 
COUNT(*) AS totalCust,
SUM(sales)  AS totalSales,
AVG(sales)  AS avgSales,
MAX(sales) AS highestSales,
MIN(sales) AS lowestSales
FROM orders

-- GROUP BY CUST ID. this will break down the aggragate

SELECT 
customer_id,
COUNT(*) AS totalCust,
SUM(sales)  AS totalSales,
AVG(sales)  AS avgSales,
MAX(sales) AS highestSales,
MIN(sales) AS lowestSales
FROM orders
GROUP BY customer_id

SELECT *
FROM orders

-- Analyse scores in customers table:

 -- Group rows in the orders table that have the same customer_id.
 -- Then will apply your aggregate functions within each group, not across the whole table.
 -- So your query will return one row per customer_id

 -- window basics
 -- windows allows you to perform calculations (aggregation)
 -- syntax : 'aggregations' OVER (PARTITION BY  'COLUMN NAME' ORDER BY ROWS UNBOUDED PRECEDING) AS ..
 -- window functions (SUM(sales)) : Perform calculations within windows
-- function experssion (sales)
-- over clause  OVER (..) : tell SQL that the function used is a window function. define the windows or subset if data
-- frame clause ROWS UNBOUNDED PRECEDING: Define a subset of rows in a window (only some are involve, not entire window and must use ORDER BY together)





 -- windows vs group by
 -- group by : changes the granularity, for simple aggregations
 -- maitain granularity, aggregations + details

 -- group by and windows for count, sum, avg, min max functions
 -- but windows have more functions : rank functions and value functions
 -- windows for more advanced data analysos

 -- Find the total sales across all orders

 SELECT *
 FROM Sales.Orders

 SELECT 
 SUM(Sales) as total_sales
 FROM Sales.Orders


  -- Find the total sales for each product


 SELECT 
 ProductID,
 SUM(Sales) as total_sales
 FROM Sales.Orders
 GROUP BY ProductID

 -- if column mention in select, it also must be in group by statement



-- Find the total sales for each product, additionally provide details such order id & order date

SELECT 
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER(PARTITION BY ProductID) as totalSalesByProduct 
FROM Sales.Orders


-- cant do aggregations and provide details at the same time
-- if you want to calc total sales but also want additional details, use windows
-- window functions (SUM(sales)) : Perform calculations within windows
-- function experssion (sales)
-- over clause  OVER (..) : tell SQL that the function used is a window function. define the windows or subset if data
-- if you dont use PARTITION BY, basically just same as SUM (..)
-- can also paritition double columns : OVER (PARTITION BY Product, Sales)


-- Find the total sales , additionally provide details such order id & order date

SELECT 
ProductID,
OrderID,
OrderDate,
SUM(Sales) OVER() as totalSalesByProduct 
FROM Sales.Orders

-- combine em all

SELECT 
ProductID,
OrderID,
OrderDate,
Sales,
SUM(Sales) OVER() as totalSales,
SUM(Sales) OVER(PARTITION BY ProductID) as totalSalesByProduct 
FROM Sales.Orders

-- Find the total sales for each combination of products and order status 

SELECT *
FROM Sales.Orders


SELECT 
OrderID,
OrderDate,
ProductID,
OrderStatus,
Sales,
SUM(Sales) OVER() as totalSales,
SUM(Sales) OVER(PARTITION BY ProductID) as totalSalesByProduct,
SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) as totalSalesByProductandStatus
FROM Sales.Orders


-- if you want to RANK sales by month and auto rank it, use this
-- RANK () OVER (PARTITION BY Month ORDER BY Sales DESC)


-- Rank each order based on their sales from highest to lowest, additionally provide details such order id & order date

SELECT 
OrderID,
OrderDate,
ProductID,
OrderStatus,
Sales,
RANK () OVER (ORDER BY Sales DESC) as rankSales
FROM Sales.Orders

/*
SUM(Sales)
OVER(ORDER BY Month
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)

-- does not have partition by, because this data only have one record one month. not jan jan jan feb feb.
-- order by month: jan feb mar
row between current row and 2 following: result for column one: sales of jab + feb + mar
-- december dont have antoher month after that. therefore, it sums total sales dec only
-- november: nov + dec



SUM(Sales)
OVER(ORDER BY Month
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- unbouded following is static. the last row in the table
-- so dari current row sampaila last row punya total



SUM(Sales)
OVER(ORDER BY Month
ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)

-- 1 PRECEDING IS THE 1 ROW BEFORE CURRENT ROW


SUM(Sales)
OVER(ORDER BY Month
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- unbouded preceding is static. the first row in the table


SUM(Sales)
OVER(ORDER BY Month
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- add with 1 row before and 1 row after


*/


SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

-- shortcut only for PRECEDING, CURRENT ROW can be skipped
-- ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
-- SHORT FORM: ROWS 2 FOLLOWING

-- if you dont say rows between ...etc  AFTER ORDER BY
-- default is unbounded preceding and current row
-- so either dont write anything
-- or shortcut: rows unbounded prceeding
-- or full:rows between unbounded preceding and current row
-- if dont have ORDER BY, then it will be normal partition


-- limitations of WINDOW FUNCTIONS
-- use only in the SELECT CLAUSE or ORDER BY. cant be use to filter data (like filter using	WHERE)
-- nesting window functions is not allowed SUM(SUM(Sales) OVER(...etc)
-- SQL execute WINDOW functions after WHERE clause


-- Find the total sales for each order status, only for 2 products 101 and 102

SELECT
OrderID,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE 
ProductID IN (101,102)



-- Rank customers based on total sales
-- RANK function cant use GROUP BY, GROUP BY only aggregation

SELECT
CustomerID,
SUM(Sales) as TotalSales,
RANK () OVER(ORDER BY SUM(Sales) DESC) AS rank
FROM Sales.Orders
GROUP BY CustomerID

-- Window Aggregate Function

-- COUNT() : Return number of rows 
-- COUNT(*) will count all rows even NULLs. Count(Sales) will not count NULL
-- COUNT(1) is similar to COUNT(*)

--Find the total number of orders

SELECT 
COUNT(OrderID) OVER as TotalOrders
FROM Sales.Orders

--Find the total number of orders, additionally provide orderid and order date

SELECT 
OrderID,
OrderDate,
COUNT(*) OVER() as TotalOrders
FROM Sales.Orders

--Find the total number of orders OF EACH CUSTOMERS

SELECT 
OrderID,
OrderDate,
CustomerID,
COUNT(*) OVER() as TotalOrders,
COUNT(*) OVER(PARTITION BY CustomerID) as TotalOrdersByCust
FROM Sales.Orders

--Find the total number of CUSTOMERS, additionally provide details

SELECT 
*,
COUNT(*) OVER() as TotalCust
FROM Sales.Customers

--Find the total number of scores for the CUSTOMERS


SELECT 
*,
COUNT(*) OVER() as TotalCust,
SUM(Score) OVER() as TotalScores
FROM Sales.Customers