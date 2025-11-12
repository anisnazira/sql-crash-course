# Querying Data

### 🧠 What I Learned
- `SELECT` is used to fetch data from a table.
- `WHERE` filters rows based on conditions.
- `ORDER BY` sorts results ascending (`ASC`) or descending (`DESC`).

### 🔍 Examples
```sql
SELECT first_name, last_name FROM employees;

SELECT * FROM employees
WHERE department = 'Sales';

SELECT name, salary
FROM employees
ORDER BY salary DESC;
