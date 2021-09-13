CREATE TABLE my_countries(
country_id CHAR(2),
country_name VARCHAR2(30),
region_id number(1)
);


INSERT INTO my_countries VALUES('ON','Ontario',2);
INSERT INTO my_countries VALUES('NY','New York',3);
INSERT INTO my_countries VALUES('CH','Switzerland',3);
INSERT INTO my_countries VALUES('DE','Germany',3);

Select * from my_countries;