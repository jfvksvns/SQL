  
#USER DEFINED FUNCTIONS

use excelr;
DELIMITER //
CREATE FUNCTION CalculateAnnualSalary(monthly_salary DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC   #IF I GIVE ANY INPUT PARAMETER IT WILL SUPPORT AND WILL GET A OUTPUT
BEGIN
    DECLARE annual_salary DECIMAL(10,2);
    SET annual_salary = monthly_salary * 12;
    RETURN annual_salary;
END //
DELIMITER ;

  SELECT *FROM MYEMP;
    SELECT *,CalculateAnnualSalary(SALARY) AS ANNUAL_SALARY FROM MYEMP;
  
#Function to Get Department Name
DELIMITER //
CREATE FUNCTION GetDepartmentName(dep_id INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE dep_name VARCHAR(50);
        CASE dep_id
        WHEN 10 THEN SET dep_name = 'Administration';
        WHEN 20 THEN SET dep_name = 'Marketing';
        WHEN 30 THEN SET dep_name = 'Purchasing';
        WHEN 40 THEN SET dep_name = 'Human Resources';
        WHEN 50 THEN SET dep_name = 'Shipping';
        WHEN 60 THEN SET dep_name = 'IT';
        WHEN 70 THEN SET dep_name = 'Public Relations';
        WHEN 80 THEN SET dep_name = 'Sales';
        WHEN 90 THEN SET dep_name = 'Executive';
        WHEN 100 THEN SET dep_name = 'Finance';
        WHEN 110 THEN SET dep_name = 'Accounting';
        ELSE SET dep_name = 'Unknown';
    END CASE;
        RETURN dep_name;
END //
DELIMITER ;

SELECT *,GetDepartmentName(DEP_ID) AS DEP_NAMES FROM MYEMP;

#Calculate Years of Service
DELIMITER //
CREATE FUNCTION CalculateYearsOfService(hire_date DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE years_of_service INT;
    SET years_of_service = YEAR(CURDATE()) - YEAR(hire_date);
    RETURN years_of_service;
END //
DELIMITER ;

SELECT *,CalculateYearsOfService(hire_date) AS EXP FROM MYEMP;






CREATE DATABASE CASE_STUDY;
use  case_study;

#SCENARIO1

/*You are working on an e-commerce platform (Amazon-like).
Every day:
Customers place orders
Some customers are new (first-time buyers)
Some customers are repeat buyers

 Goal
For each day, find:
Number of new customers
Number of repeat customers*/

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);



insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


select * from customer_orders;

WITH FIRST_VISIT AS(SELECT CUSTOMER_ID,
						   MIN(ORDER_DATE) AS FIRST_VISIT_ORDER
                           FROM CUSTOMER_ORDERS
                           GROUP BY CUSTOMER_ID)
		
SELECT A.ORDER_DATE,
  SUM(CASE WHEN A.ORDER_DATE=B.FIRST_VISIT_ORDER THEN 1 ELSE 0 END) AS NEW_CUSTOMERS, #here 1 and  0 are flag
  SUM(CASE WHEN A.ORDER_DATE!=B.FIRST_VISIT_ORDER THEN 1 ELSE 0 END) AS REPEAT_CUSTOMERS
  FROM customer_orders AS A
  INNER JOIN
  FIRST_VISIT AS B 
  ON A.CUSTOMER_ID=B.CUSTOMER_ID
  GROUP BY A.ORDER_DATE;
  
  
  
  
  use case_study;
  #SCENARIO2

CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL 
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);


INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;

select * from booking_table;





CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);


INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');




/*Q1.Write a SQL query to find, for each user segment:
Total number of users
Number of users who booked at least one Flight in April 2022

Q2.Write a SQL query to find all users whose first booking was a Hotel booking.

Q3.Write a SQL query to find, for each user:

Their first booking date
Their last booking date
The number of days between their first and last booking. */
use case_study;

SELECT 
    user_id,
    MIN(booking_date) AS first_booking_date,
    MAX(booking_date) AS last_booking_date,
    DATEDIFF(MAX(booking_date), MIN(booking_date)) AS NO_OF_DAYS
FROM Booking_TABLE
GROUP BY user_id;


/* Q4.Write a SQL query to calculate, for each user segment, the total number of:

Flight bookings
Hotel bookings
made in the year 2022.

*/



