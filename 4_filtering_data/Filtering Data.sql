
-- Filtering Data
-- Comparison operators, Logical Operators, BETWEEN, IN, LIKE



-- Comparison operators
-- Retrieve all customers from Germany

SELECT * FROM customers
WHERE country = 'Germany'

-- Retrieve all customers who are not from Germany

SELECT * FROM customers
WHERE country != 'Germany' 
-- or can use WHERE country <> 'Germany' 

-- Retrieve all customers with score greater than 500

SELECT * FROM customers
WHERE score > 500

-- Retrieve all customers with score of 500 or more

SELECT * FROM customers
WHERE score >= 500

-- Retrieve all customers with score less than 500

SELECT * FROM customers
WHERE score < 500

-- Retrieve all customers with score of 500 or less

SELECT * FROM customers
WHERE score <= 500


-- Logical Operator

-- AND
-- Retrieve all customers who are from USA AND score greater than 500

SELECT * FROM customers
WHERE
 country = 'USA'
 AND
 score > 500

 -- OR
 -- Retrieve all customers who are either from USA OR score greater than 500

SELECT * FROM customers
WHERE
 country = 'USA'
 OR
 score > 500

 -- NOT
 -- Retrieve all customers with score NOT less than 500

SELECT * FROM customers
WHERE
 NOT score < 500 --or can just use score >= 500

 -- BETWEEN
 -- Retrieve all customers with score BETWEEN 100 and 500

 
SELECT * FROM customers
WHERE
 score BETWEEN 100 AND 500 -- OR >= 100 AND <= 500

SELECT * FROM customers
WHERE
 score >= 100 AND score <= 500 -- this way better because you know 100 is inclusive

-- IN and NOT IN

-- Retrieve all customers who are either from USA OR Germany

SELECT * FROM customers
WHERE
 country = 'USA'
 OR
 country = 'Germany'

 -- OR

SELECT * FROM customers
WHERE
 country IN ('USA', 'Germany')

 -- this way more clear and shorter
 -- if it fits one values (USA), then the condition is fulfilled

 -- LIKE
 -- To search for a pattern in text
 --  either % or _
 -- % means can be anything. 0, and or many char
 -- _ underscore means only 1 char fill the blank
 -- SELECT * FROM table, WHERE column_name LIKE ''


 -- Find all customers whose first name starts with M

 SELECT * FROM customers
 WHERE first_name LIKE 'M%'

 
 -- Find all customers whose first name ends with n

 SELECT * FROM customers
 WHERE first_name LIKE '%n'

 -- Find all customers whose first name contains r

 SELECT * FROM customers
 WHERE first_name LIKE '%r%'

  -- Find all customers whose first name has r in third position


SELECT * FROM customers
 WHERE first_name LIKE '__r%'