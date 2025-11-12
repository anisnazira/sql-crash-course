

-- Data Manipulation Language (DML)
-- INSERT, UPDATE, DELETE

-- INSERT
-- Table is empty, use command insert to add data
-- INSERT INTO, table name, column (if not define, by default it means u want to insert into every column, VALUES, bracket
-- if you define 3 columns, then insert 3 variable. other columns auto NULL

INSERT INTO customers (id, first_name, country, score)
VALUES 
	(6, 'Anna', 'USA', NULL),
	(7, 'Sam', NULL , 100)


INSERT INTO customers (id, first_name, country, score)
VALUES 
	(8, 'USA', 'Max', NULL)

-- OR CAN JUST DO THIS


INSERT INTO customers 
VALUES 
	(9, 'Andreas', 'Germany', NULL)

INSERT INTO customers (id,first_name) 
VALUES 
	(10, 'Sahra')
SELECT * FROM CUSTOMERS

-- Now, we have already existing table with data but we want to moved it to empty table
-- Use select query to get from source data, use insert to move to empty table
-- Copy data from table customers into table persons
-- Keys : understand target table first (keep in mind null or not null)



INSERT INTO persons (id,person_name, birth_date, phone)
SELECT 
id,
first_name,
NULL, -- not matching with table customers
'Unknown' --not matching also, but this column cant have NULL
FROM customers

-- Comment : No open and close bracket


-- UPDATE
-- SYNTAX : UPDATE table_name, SET columnq = value1, WHERE <condition>
-- always use where to avoid updating all the rows

-- Change the score of customer ID 6 to 0

UPDATE customers
SET score = 0
WHERE id = 6

-- Change the score of customer ID 10 to 0 and update country to UK

UPDATE customers
SET 
score = 0,
country = 'UK'
WHERE id = 10

-- Update all customers with a NULL score by setting their score to 0

UPDATE customers
SET
score = 0
WHERE score IS NULL

SELECT * 
FROM customers
WHERE score IS NULL

-- DELETE
-- DELETE FROM table_name, WHERE <condition>

-- Delete all customers with an ID greater than 5

DELETE FROM customers
WHERE id > 5

-- Notes : if you want to delete all data from table
-- use truncate instead of delete, way faster
-- Ex : TRUNCATE TABLE persons