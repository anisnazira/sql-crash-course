
-- Data Definition Language (DDL)
-- CREATE, ALTER, DROP
-- How to define structure of database


-- Create a new table called persons 
-- with columns: id, person_name, birth_date and phone

CREATE TABLE persons(
id INT NOT NULL,
person_name VARCHAR(15) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL
CONSTRAINT pk_persons PRIMARY KEY (id)
)

-- CREATE TABLE, table name, variable, INT/VARCHAR/DATE, NOT NULL (optional), comma, close bracket
-- Dont forget open bracket, comma
-- If you want to find script of the table you created,
-- Right click of the table > Script table as > Create TO > New Query Editor window



-- Add a new column called email to the perosns table
-- Adding always at the end of the table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

-- Remove columns phone from the persons table

ALTER TABLE persons
DROP COLUMN phone

-- Drop table persons from database

DROP TABLE persons
