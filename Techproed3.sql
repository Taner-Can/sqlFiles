CREATE TABLE employees 
(  
  employee_id number(9), 
  employee_first_name varchar2(20),
  employee_last_name varchar2(20)
);
?
INSERT INTO employees VALUES(14, 'Chris', 'Tae');
INSERT INTO employees VALUES(11, 'John', 'Walker');
INSERT INTO employees VALUES(12, 'Amy', 'Star');
INSERT INTO employees VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees VALUES(15, 'Chris', 'Way');

SELECT * FROM employees;

CREATE TABLE addresses 
(  
  employee_id number(9), 
  street varchar2(20),
  city varchar2(20),
  state char(2),
  zipcode char(5)
);
?
INSERT INTO addresses VALUES(11, '32nd Star 1234', 'Miami', 'FL', '33018');
INSERT INTO addresses VALUES(12, '23rd Rain 567', 'Jacksonville', 'FL', '32256');
INSERT INTO addresses VALUES(13, '5th Snow 765', 'Hialeah', 'VA', '20121');
INSERT INTO addresses VALUES(14, '3rd Man 12', 'Weston', 'MI', '12345');
INSERT INTO addresses VALUES(15, '11th Chris 12', 'St. Johns', 'FL', '32259');

SELECT * FROM addresses;

--======================
--ALIASES ==> AS
--======================

--How to use aliase for table names

--1)Select employee first name and state, for emplyee first name use “firstname” as field name and for state use “employee state” as field name

SELECT e.employee_first_name AS "First Name", a.state AS "Employee State"   -- addresses.state (then a.state), in order to show where it is from since two tables are present
FROM employees e, addresses a  -- employee e as a aliase, not to type table name all the time
WHERE e.employee_id = a.employee_id; 

--How to put multiple fields into a single field and use aliase for the field
--2)Get employee id use “id” as field name, get firstname and lastname put them into the same field and use “full_name” as field name

SELECT employee_id, employee_first_name || ' ' || employee_last_name AS "Full Name"  -- between fields put ( || ' ' || ) to merge(concatination)
FROM employees;

--==============
--GROUP BY
--==============

CREATE TABLE workers 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);
?
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
?
SELECT * FROM workers;

--3)Find the total salary for every employee
SELECT name, SUM(salary) AS "Total Salary"
FROM workers
GROUP BY name 
ORDER BY "Total Salary" DESC;    -- If you use "ORDER BY" together with "GROUP BY", "GROUP BY" must be first.

--4)Find the number of employees per state in descending order by employee number
SELECT state, COUNT(state) AS "Number of Workers" 
FROM workers
GROUP BY state 
ORDER BY "Number of Workers" DESC;

--5)Find the number of the employees whose salary is more than $2000 per company
SELECT company, COUNT(*) AS "Number of Workers" -- If all fields give the same result , you can put an "*" instead of field name.
FROM workers
WHERE salary > 2000  -- If you use "WHERE" together with "GROUP BY" "WHERE" must be first.
GROUP BY company;

--6)Find the minimum and maximum salary for every company
SELECT company, MIN(salary) AS "MIN Salary", MAX(salary) AS "MAX Salary"
FROM workers
GROUP BY company;

--========================
--HAVING CLAUSE: Used after "GROUP BY" and with "Aggregate Functions" ==> [ SUM(), MAX(), MIN(), AVG(), COUNT() ]
--========================

--Interview Question: What is difference between "WHERE" and "HAVING"..?
--ANSWER: Main difference is that HAVING" is used with "Aggregate Functions", "WHERE" is used with "Field Names".
--Note: After "WHERE" "Aggregate Functions" cannot be used.

--7)Find the total salary if it is greater than 2500 for every employee
SELECT name, SUM(salary) AS "Total Salary"
FROM workers
GROUP BY name  -- After "GROUP BY" NEVER use "WHERE".
HAVING SUM(salary) > 2500; 

--8)Find the number of employees if it is more than 1 per state
SELECT state, COUNT(name) AS "Number of Employees"
FROM workers
GROUP BY state
HAVING COUNT(name) > 1;

--9)Find the minimum salary if it is more than 2000 for every company
SELECT company, MIN(salary) AS "MIN Salary"
FROM workers
GROUP BY company
HAVING MIN(salary) > 2000;

--10)Find the maximum salary if it is less than 3000 for every state
SELECT state, MAX(salary) AS "Max Salary Less than 3000"
FROM workers
GROUP BY state
HAVING MAX(salary) < 3000;

--=========================
-- UNION Operator: It is used to join the result of two or more queries.
--=========================

SELECT name, salary
FROM workers
WHERE salary > 4000

UNION -- UNION Operator gives unique records, if there is repeated data, just one will be printed.

SELECT name, salary
FROM workers
WHERE salary < 2000;

--=========================
-- UNION ALL Operator:
--=========================

SELECT name, salary
FROM workers
WHERE salary > 4000

UNION ALL -- UNION ALL Operator gives repeated records, it will give all.

SELECT name, salary
FROM workers
WHERE salary < 2000;

--Example:

SELECT state
FROM workers
WHERE salary > 2000

UNION -- you can have different fields as well.(state & name)(same data type), but (state & salary) cannot be used due to data type (string and number)
      -- you can use same data type in different sizes, but all data must be less or equal to smaller size.(company(20), state(50))-> 20
SELECT name
FROM workers
WHERE salary < 3000;

--==========================
--INTERSECT Operator:  It gives the common results of two queries.
--==========================

SELECT name, salary
FROM workers
WHERE salary > 2000

INTERSECT

SELECT name, salary
FROM workers
WHERE salary < 4000;


--=======================
-- MINUS Operator:  Removes common records. And then gets the remaining unique records from first table.
--=======================

SELECT name, salary
FROM workers
WHERE salary < 3500

MINUS -- Removes common ones. Get remaining from first table, but gives unique records.

SELECT name, salary
FROM workers
WHERE salary > 1600;

--===========================
--JOINS: Are used between two TABLES, not queries.
--===========================
--1-) INNER JOIN: ==> Returns common records.
--2-) LEFT JOIN: ==> Returns all records from the left table.
--3-) RIGHT JOIN: ==> Returns all records from the right table.
--4-) FULL JOIN: ==> Returns all records from the both tables.
--5-) SELF JOIN: ==> You have one table, but clone it and create two tables. Then it becomes same as Inner Join.


CREATE TABLE my_companies 
(  
  company_id number(9), 
  company_name varchar2(20)
);
?
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');
?
SELECT * FROM my_companies;
?
CREATE TABLE orders 
(  
  order_id number(9),
  company_id number(9), 
  order_date date
);
?
INSERT INTO orders VALUES(11, 101, '17-Apr-2020');
INSERT INTO orders VALUES(22, 102, '18-Apr-2020');
INSERT INTO orders VALUES(33, 103, '19-Apr-2020');
INSERT INTO orders VALUES(44, 104, '20-Apr-2020');
INSERT INTO orders VALUES(55, 105, '21-Apr-2020');
?
SELECT * FROM orders;


--1-) INNER JOIN:
--==============

--Select company name, order id, order date for common companies
SELECT mc.company_name, o.order_id, o.order_date -- mc. or o. to show where the table it is comming from, and readibility
FROM my_companies mc INNER JOIN orders o
ON o.company_id = mc.company_id;


--2-) LEFT JOIN:
--==============

--Get order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON o.company_id = mc.company_id
ORDER BY o.order_date; 


--3-) RIGHT JOIN:
--================

--Get order id and order date for the companies in orders table
--1.WAY:
SELECT  mc.company_name, o.order_id, o.order_date 
FROM my_companies mc RIGHT JOIN orders o
ON o.company_id = mc.company_id;

--2.WAY:
SELECT mc.company_name, o.order_id, o.order_date
FROM orders o LEFT JOIN my_companies mc -- By changing positions of tables you will get the same result.
ON o.company_id = mc.company_id;


--4-) FULL JOIN:
--===============

--Get order id and order date from both tables
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc FULL JOIN orders o -- Changing the places of the tables  WILL NOT CHANGE the outcome.
ON o.company_id = mc.company_id;


--5-) SELF JOIN:
--===============

CREATE TABLE workers 
(  
  id number(2), 
  name varchar2(20),
  title varchar2(60),
  manager_id number(2) 
);
?
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);
?
SELECT * FROM workers;

--Create a table which displays the manager of employees
SELECT employee.name, manager.name -- create two tables from one, by giving aliases, check image for this.
FROM workers employee INNER JOIN workers manager -- INNER JOIN = JOIN
ON employee.manager_id = manager.id;








