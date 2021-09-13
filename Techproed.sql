--How to create a table:

--1.Way: Create a table from scratch:

CREATE TABLE students
(
  student_id CHAR(3),
  student_name VARCHAR2(50),
  student_age NUMBER(2),
  student_dob DATE   -- no comma at last one
);

--2. Way: Create table by using another table:

CREATE TABLE student_name_age
AS SELECT student_name, student_age
FROM students;

SELECT * FROM students;
SELECT * FROM student_name_age;

--While we create a table, we can put some "Constraints" for fields, like
--CONSTRAINTS:
--a)PRIMARY KEY, can only be used once. 
--b)UNIQUE, can be used multiple times.
--c)NOT NULL
--d)FOREIGN KEY
--e)CHECK CONSTRAINT

--There are two ways to create PRIMARY KEY
--1. Way to create PRIMARY KEY:



CREATE TABLE students
(
  student_id CHAR(3) PRIMARY KEY, -- student_id cannot have repeated data, cannot have null value, hence Primary Key
  student_name VARCHAR2(50) NOT NULL, --student_name will not have null as data
  student_age NUMBER(2),
  student_dob DATE UNIQUE -- student_dob is unique key ==> Data different form null must be unique, can have multiple null's
);


--2. Way to create PRIMARY KEY(preferred way):
CREATE TABLE students
(
  student_id CHAR(3),
  student_name VARCHAR2(50),
  student_age NUMBER(2),
  student_dob DATE,
  CONSTRAINT student_id_pk PRIMARY KEY(student_id) -- we are able to put a name for our PK.
); 

--How to add Foreign Key Constraint
CREATE TABLE parents
(
student_id CHAR(3),
parent_name VARCHAR2(50),
phone_number CHAR(10),
CONSTRAINT student_id_pk PRIMARY KEY(student_id)
);

CREATE TABLE students
(
  student_id CHAR(3),
  student_name VARCHAR2(50),
  student_age NUMBER(2),
  student_dob DATE, 
  CONSTRAINT student_id_fk FOREIGN KEY(student_id) REFERENCES parents(student_id) --To create FK we needed a class with PK, to create the link.
);

--How to add "Check" Constraint:
CREATE TABLE students
(
  student_id CHAR(3),
  student_name VARCHAR2(50),
  student_age NUMBER(2),
  student_dob DATE, 
  CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 30), -- use constraint and student_age_check, to give it a name
  CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))
);

--How to insert Data into a Table
CREATE TABLE students
(
  student_id CHAR(3) PRIMARY KEY,
  student_name VARCHAR2(50) UNIQUE,
  student_age NUMBER(2) NOT NULL,
  student_dob DATE, 
  CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 30), -- 0 and 30 are included.
  CONSTRAINT student_name_upper_case CHECK(student_name = upper(student_name))
);

--1 Way: Insert Data for all fields.
--For CHAR we use single quotes, but it works without too, like in ID part od the example.
--For VARCHAR2 we have to use single quotes.
INSERT INTO students VALUES('101', 'ALI CAN', 13, '10-Aug-08'); -- This is a "CREATE" operation (DML)
INSERT INTO students VALUES('102', 'VELI HAN', 14, '10-Aug-07');
INSERT INTO students VALUES('103', 'AYSE TAN', 14, '22-Aug-07');
INSERT INTO students VALUES(104, 'KAAN CEM', 15, null);
INSERT INTO students VALUES('105', 'JOHN WAYNE', 24, '11-Aug-87');
INSERT INTO students VALUES('106', 'JACK RYAN', 30, '10-Aug-07');
INSERT INTO students VALUES('107', 'CAN SERIN', 0, '10-Aug-07');

--2 Way: How to Insert Data for specific fields.
INSERT INTO students(student_id, student_age) VALUES(108, 17);
INSERT INTO students(student_id, student_name, student_age) VALUES(109, 'SUE ALLEN', 17);

--How to update existing Data:

UPDATE students  -- updated the name of record 108
SET student_name = 'LEON CARR'
WHERE student_id = 108;

-- Update the dob of Sue Allen to 11-Dec-97
UPDATE students    -- updated the DOB of record 109
SET student_dob = '11-Dec-97'
WHERE student_id = 109;

--How to update multiple cell's:
-- Update the dob of 105 to 11-Apr-96 and name to Tom Hanks
UPDATE students
SET student_dob = '11-Apr-96',
    student_name = 'TOM HANKS'
WHERE student_id = 105;    

--How to update multiple record's:
-- Make the names of all students ******, if their id's are less 106.
UPDATE students  -- names are unique, thus not excepted
SET student_name = '******'
WHERE student_id < 106;

-- Make the DOB of all students 01-Jan-99, if their id's are less 106.
UPDATE students
SET student_dob = '01-Jan-99' -- worked, but only after changing it to the right date-format. 
WHERE student_id < 106;

--Update all students age to the max age.
UPDATE students
SET student_age = (SELECT MAX(student_age)FROM students);
--(WHERE student_id > 100;) -- No need to type where since it is for all students

--Update all students DOB to the min DOB.
UPDATE students
SET student_dob = (SELECT MIN(student_dob)FROM students);


SELECT * FROM students;  -- This is a "READ" operation (DQL)


