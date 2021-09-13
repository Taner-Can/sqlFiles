--=======================
--ALTER TABLE:
--=======================

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

--1) We can add a column to an existing table

ALTER TABLE workers
ADD company_industry VARCHAR2(20);
 
--2) How to add a field with default value
ALTER TABLE workers
ADD worker_address VARCHAR2 (80) DEFAULT 'Miami,FL, USA';

--3) How to add multiple fields into a table
ALTER TABLE workers
ADD (number_of_workers NUMBER(5) DEFAULT 0, name_of_ceo VARCHAR2(20));

--4)How to drop fields from a table
ALTER TABLE workers
DROP COLUMN name_of_ceo;

--5)How to rename a field/column
ALTER TABLE workers
RENAME COLUMN company_industry TO company_profession;

--6)How to rename table itself:
ALTER TABLE workers
RENAME TO employees;


--7) How to modify(Add constraints, change data type, change the size) a field

--Note:1) When you modify a filed be careful about existing data

--a) How to add constraints
--a1) Add "NOT NULL" to number of workers field.
ALTER TABLE employees
MODIFY number_of_workers NUMBER(5) NOT NULL;

--a2) Add "UNIQUE" constraint to company_profession field.
ALTER TABLE employees
MODIFY company_profession VARCHAR2(20) UNIQUE; -- UNIQUE accepts repeated "Null" data.

--a3) Add "unique" constraint to worker_address field
ALTER TABLE employees
MODIFY worker_address VARCHAR2(20) UNIQUE; -- "cannot validate duplicate keys found" --> (Miami, FL, USA)

--b) How to change data size of a field
--b1) Change the Data type of the company_profession field to CHAR(5)
ALTER TABLE employees
MODIFY company_profession CHAR(5);

--Note:2) When you modify a field, new size must be greater than or equal to the maximum existing size

--b2) Change the Data type of the worker_address field to CHAR(5)
ALTER TABLE employees
MODIFY worker_address CHAR(5); --  cannot decrease column length because some value is too big

--b3) Change the Data type of the worker_address field to CHAR(30)
ALTER TABLE employees
MODIFY worker_address CHAR(30); 

--c) How to change data type of a field
--c1) Change the data type of number_of_workers to CHAR(5)
ALTER TABLE employees
MODIFY number_of_workers char(5); -- "column to be modified must be empty to change datatype"

SELECT * FROM employees;


--======================================
-- How to Create a FUNCTION in SQL :
--======================================
--1-) We create functions in SQL to do some tasks faster.( Like calculation GPA ...)
--2-) We create functions to do SELECT, INSERT, DELETE, UPDATE tasks faster and efficient.
--3-) In Java some methods may not return any value but in SQL all functions must return data.
--4-) If sth like function does not return data, it is called “Procedure”.





--1)Create a function to add 2 numbers
CREATE OR REPLACE FUNCTION addf(a NUMBER, b NUMBER) RETURN NUMBER IS -- In Function Function names end with "f". 
BEGIN
    RETURN a+b;
END;

--1.Way to call a function
SELECT addf(12, 13) FROM DUAL;

--2.Way to call a function
EXECUTE DBMS_OUTPUT.PUT_LINE('Result is ' || addf(12, 13));

-- or

SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE(‘The sum is ’ || addf(12,13));

--3.Way to call a function
VARIABLE Result NUMBER

EXECUTE :Result := addf(12, 13);

PRINT Result;


--2)Get two numbers and operation sign from user then print the result of the operation
DECLARE
    a NUMBER := '&First_Number';
    b NUMBER := '&Second_Number';
    c CHAR := '&Operation_Sign';
    
FUNCTION calculatorf(a NUMBER, b NUMBER, c CHAR) RETURN NUMBER IS
BEGIN 

    IF c = '+' THEN RETURN a+b;
    
    ELSIF c = '-' THEN RETURN a-b;
    
    ELSIF c = '*' THEN RETURN a*b;
    
    ELSIF c = '/' THEN RETURN a/b;
    
    ELSE DBMS_OUTPUT.PUT_LINE('I told you to enter one of the +, -, *, /'); 
         RETURN 0;
    
    END IF;

END;

BEGIN

    DBMS_OUTPUT.PUT_LINE( a || c || b || ' = ' || calculatorf(a, b, c));

END;


--Create a table insert name and age, and insertion date, and user name into table for each record.
CREATE TABLE students
(
    std_name VARCHAR2(50),
    std_age NUMBER(3),
    insertion_date DATE,
    inserter VARCHAR2(50)
);    
DECLARE

   current_date DATE;
   inserter VARCHAR2(50);
   std_name VARCHAR2(50);
   std_age NUMBER(3);
   
BEGIN
   SELECT sysdate, user -- Comes from DUAL table, sysdate will get you current date, user will get name of your database.
   INTO current_date, inserter
   FROM DUAL;  -- DUAL is a table in Database. It has a field and a record. And you can reach sysdate ( for current Date ), and user (name of your database)

   std_name := '&student_name';
   std_age := '&student_age';
   
   INSERT INTO students VALUES(std_name, std_age, current_date, inserter);
END;

SELECT * FROM students;














