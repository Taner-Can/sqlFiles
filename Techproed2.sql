CREATE TABLE customers_products
( 
  product_id number(10),
  customer_name varchar2(50),
  product_name varchar2(50)
);

INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');  
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers_products

--==================================
--        IN Condition:
--==================================

--8)Select records whose product name is Orange or Apple or Palm
--1.WAY:

SELECT * 
FROM customers_products
WHERE product_name = 'Orange' OR  product_name = 'Apple' OR  product_name = 'Palm'; 

--2.WAY:
SELECT *
FROM customers_products
WHERE product_name IN ('Orange', 'Apple', 'Palm');

--=====================================
--        NOT IN Condition:
--=====================================

--9) Select records whose product name is not Orange or Apple or Palm
SELECT *
FROM customers_products
WHERE product_name NOT IN ('Orange', 'Apple', 'Palm');

--=======================================
--        BETWEEN Condition:
--=======================================

--10) Select records whose product id is less than or equal to 30 and greater than or equal to 20
--1.WAY:
SELECT * 
FROM customers_products
WHERE product_id <= 30 AND product_id >= 20;

--2.WAY:
SELECT * 
FROM customers_products
WHERE product_id BETWEEN 20 AND 30; -- 20 and 30 are inclusive

--======================================
--        NOT BETWEEN Condition:
--======================================

--11) Select records whose product id is less than 20 or greater than 25
--1.WAY:
SELECT *
FROM customers_products
WHERE product_id < 20 OR product_id > 25;

--2.WAY:
SELECT *
FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 25;  -- In NOT BETWEEN 20 and 25 are exclusive

--================================================
--        EXISTS Condition: Is used with Subquery
--                          If the Subquery returns any records, Outer Query will be executed.
--                          If the Subquery does not returns any records, Outer Query will not be executed.
--                          EXISTS can be used in SELECT, INSERT, UPDATE and DELETE Commands.
--================================================

CREATE TABLE customers_likes
( 
  product_id number(10),
  customer_name varchar2(50),
  liked_product varchar2(50)
);

INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers_likes;

--12) Update names to "No Name" if there is "Lary" among names in customers_likes table.
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name = 'Lary');

--13)Delete records if there is 'Orange' as product_name in customers_likes table
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product = 'Orange'); -- if there is orange in the table, delete all records

--14) Select customer names if the product id's are the same in customers_products table and customers_likes tables. 
SELECT product_id, customer_name
FROM customers_products
WHERE EXISTS (SELECT product_id FROM customers_likes WHERE customers_products.product_id = customers_likes.product_id);

--================================
-- SUBQUERY:
--================================

CREATE TABLE employee 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);

INSERT INTO employee VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employee VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employee VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employee VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employee VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employee VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employee VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employee;


CREATE TABLE companies 
(  
  company_id number(9), 
  company varchar2(20),
  number_of_employees number(20)
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(100, 'APPLE', 21000);

SELECT * FROM companies;

--15)Find the employee and company names whose company has more than 15000 employees
SELECT name, company 
FROM employee
WHERE company IN (SELECT company FROM companies WHERE companies.number_of_employees > 15000);

--16) Find the company id's and company names which are in Florida.
SELECT company_id, company --3.
FROM companies  -- 2. 
WHERE company IN (SELECT company FROM employee WHERE employee.state = 'Florida');   --1. to look at

--17) Find the employee name and State which has companies, whose company id's are greater than 100.
SELECT name, state
FROM employee
WHERE company IN (SELECT company FROM companies WHERE companies.company_id > 100); -- WHERE company, because common coloumn of both tables

--18)Find the company name, number of employees and average salary for every company
SELECT company, number_of_employees, (SELECT AVG(salary) 
                                      FROM employees 
                                      WHERE companies.company = employees.company) 
                                      AS avg_salary_per_company
FROM companies;
?
--19)Find the name of the companies, company ids, maximum and minimum salaries per company.
SELECT company_id, company, (SELECT MAX(salary) FROM employees WHERE companies.company = employees.company) AS max_salary, 
                            (SELECT MIN(salary) FROM employees WHERE companies.company = employees.company) AS min_salary
FROM companies;
?
--20)Get the number of employees whose company id is 100 or 101
-- Later
?
--LIKE Condition: It is used with WildCard
--1) % Wildcard: It represents zero or more characters
--21)Select employee names which start with 'E'
SELECT name
FROM employees
WHERE name LIKE 'E%';
?
--22)Select employee names which end with 'e'
SELECT name
FROM employees
WHERE name LIKE '%e';
?
--23)Select employee names which start with B, end with 't'
SELECT name
FROM employees
WHERE name LIKE 'B%t';
?
--24)Select employee names which has 'a' in any position
SELECT name
FROM employees
WHERE name LIKE '%a%';
?
--25)Select employee names which has 'e' and 'r' in any position
SELECT name
FROM employees
WHERE name LIKE '%e%r%' OR name LIKE '%r%e%';

--2 _ Wildcard: It represents a single character

--26) Select a state whose second character is 'e' and forth character is 'n'
SELECT state
FROM employee
WHERE state LIKE '_e_n%';

--27) Select a state whose last second character is 'i'
SELECT state
FROM employee
WHERE state LIKE '%i_';

--28) Select a state whose last second character is 'e' and has at least 6 charscters
SELECT state
FROM employee
WHERE state LIKE '_e____%'; -- although it looks joint there are 4 seperate underscores after 'e'...

--28) Select a state which has 'i' in any position after second character
SELECT state
FROM employee
WHERE state LIKE '__%i%';


-- REGEXP_LIKE Condition: You can use regular expressions with this condition.

CREATE TABLE words
( 
  word_id number(10) UNIQUE,
  word varchar2(50) NOT NULL,
  number_of_letters number(6)
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

SELECT * FROM words;


--30) Select words whose first character is 'h' , last character is 't'. and second character is 'o', or 'a' or 'i'.
--1.WAY: Using LIKE, not recommended, due to repetiton
SELECT word
FROM words
WHERE word LIKE 'hot' OR  word LIKE 'hat' OR  word LIKE 'hit';

--2.WAY: Using REGEXP_LIKE
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'h[oai]t');

--31) Select words whose first character is 'h' , last character is 't'. and second character is 'a' to 'e'
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'h[a-e]t'); -- [a-e] means a,b,c,d,e

--32) Select words whose first character is 'a' or 's' to 'y'
SELECT word
FROM words
WHERE REGEXP_LIKE(word, '^[asy](*)'); -- ^ means starting point, (*) is optional, same output

--33) Select words whose last characetr is 'a' or 'm' or 'f'...
SELECT word
FROM words
WHERE REGEXP_LIKE(word, '[amf]$'); -- $ means ending point

--34) Select words whose first characetr is 's' and last character 'a'
SELECT word
FROM words
WHERE REGEXP_LIKE(word, '^[s].*[a]$'); -- .*, use for multiple or zero characters between first and last characters..

--35) Select words which have 'a' anywhere
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'a'); -- 'a' in REGEXP_LIKE same with %a% in LIKE

--36) Select words which have 'd' to 't' at the beginning, followed by any characters other then 'l'
SELECT word
FROM words
WHERE REGEXP_LIKE(word, '^[d-t].[l]');  -- . in REGEXP_LIKE same with _ in LIKE

--37) Select words which have 'd' to 'l' at the beginning, followed by any 2 characters other then 'e'
SELECT word
FROM words
WHERE REGEXP_LIKE(word, '^[d-t]..[e]'); 

--38) Select words which have 'u' repeated twice
-- Later on


--NOT LIKE Condition:

--39) Select words which do not have 'h' in any position
SELECT word
FROM words
WHERE word NOT LIKE '%h%';

--40) Select words which do not end with 't' and 'f'
SELECT word
FROM words
WHERE word NOT LIKE '%t' AND word not like '%f'; -- be careful about using AND, 

--41) Select words which starts with any character, not followed by 'a' and 'e'...
SELECT word
FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';  -- not followed by 'a' and 'e'

--========================================
--ORDER BY Condition: To put the records by ascending order OR descending order we use "ORDER BY"
--                    ORDER BY can be used only with SELECT statement...
-- In ORDER BY , instead of field names, field numbers can be used as well.
--=========================================

--42) Put the records in ascending order by using number_of_letters
SELECT * 
FROM words 
ORDER BY number_of_letters;  -- ascending order

-- OR OR OR

SELECT * 
FROM words 
ORDER BY 3; --3 stands for number_of_letters field

--43) Put the records in descending order by using number_of_letters
SELECT * 
FROM words 
ORDER BY word DESC;  -- Descending order DESC is not optional, if you don't type "DESC", as default it will be ascending

-- OR OR OR

SELECT * 
FROM words 
ORDER BY 2 DESC;  -- 2 stands for word field

--44) Put the records in descending order by using word field, ans ascending order by using number_of_letters

CREATE TABLE points
(
   name VARCHAR2(50),
   point NUMBER(3)
);

INSERT INTO points values('Ali', 25);
INSERT INTO points values('Veli', 37);
INSERT INTO points values('Kemal', 43);
INSERT INTO points values('Ali', 36);
INSERT INTO points values('Ali', 25);
INSERT INTO points values('Veli', 29);
INSERT INTO points values('Ali', 45);
INSERT INTO points values('Veli', 11);
INSERT INTO points values('Ali', 125);

SELECT* 
FROM points
ORDER BY name DESC, point ASC;

SELECT* 
FROM points
ORDER BY name ASC, point DESC;

