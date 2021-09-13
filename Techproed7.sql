CREATE TABLE accounts
(
    id NUMBER(3),
    name VARCHAR2(50),
    balance NUMBER(10,2)
);
?
INSERT INTO accounts VALUES(101, 'ali Ca', 12000);
INSERT INTO accounts VALUES(102, 'VELI HAN', 2000);
INSERT INTO accounts VALUES(103, 'mARY sTAR', 7000);
INSERT INTO accounts VALUES(104, 'angie OCEAN', 8500);
?
SELECT * FROM accounts;
?
--Make all names in Initial Capitals
UPDATE accounts
SET name = INITCAP(name);
?
--Make all names in upper cases
UPDATE accounts
SET name = UPPER(name);
?
--Make all names in lower cases
UPDATE accounts
SET name = LOWER(name);
?
--Make names which contain 'l' in any position in Initial Capitals
UPDATE accounts
SET name = INITCAP(name)
WHERE name LIKE '%l%';