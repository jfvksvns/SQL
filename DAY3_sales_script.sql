create database sales;
use sales;
select * from orders;
SELECT count(*) from orders;

describe orders;

set sql_safe_updates=0;#for update and delete we need to execute safe query
UPDATE Orders 
SET `Order Date` = STR_TO_DATE(`Order Date`, '%d-%b-%Y')
WHERE `Order Date` LIKE '__-___-____';

ALTER TABLE Orders 
MODIFY `Order Date` DATE;#here i had chaneg the text type to date type 
DESC Orders;

#query for selecting and count the unique countries in the orders table
select distinct(country) from orders; 
select count(distinct(country)) from orders; 

ALTER TABLE orders 
CHANGE COLUMN `ï»¿Order ID` order_id INT;#here there was litte changes that has to be done in the orderID column
SELECT COUNT(DISTINCT order_id) FROM orders;

#number of orders in 2018
SELECT COUNT(DISTINCT order_id) FROM orders WHERE YEAR(`Order Date`) = 2018;

