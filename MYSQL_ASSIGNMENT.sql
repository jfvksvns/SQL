show databases;
use classicmodels;
show tables;

# Q1. SELECT clause with WHERE, AND, DISTINCT, Wild Card (LIKE)
select * from employees;
desc employees;

/* a.	Fetch the employee number, first name and last name of those employees who are working as Sales Rep reporting to employee with employeenumber 1102 */

select employeeNumber , firstName , lastName from employees where jobTitle='sales Rep' and reportsTo =1102;

/* b.	Show the unique productline values containing the word cars at the end from the products table. */

select  * from products;
SELECT DISTINCT
    productLine
FROM
    products
WHERE
    productLine LIKE '%cars';



/* Q2  Using a CASE statement, segment customers into three categories based on their country:(Refer Customers table)
                        "North America" for customers from USA or Canada
                        "Europe" for customers from UK, France, or Germany
                        "Other" for all remaining countries
     Select the customerNumber, customerName, and the assigned region as "CustomerSegment".  */ 
     
     select city,country from customers;
     desc customers;

SELECT customerNumber,
       customerName,
       CASE
           WHEN country IN ('USA', 'Canada') THEN 'North America'
           WHEN country IN (
               'France','Germany','UK','Spain','Italy','Portugal',
               'Norway','Sweden','Finland','Denmark','Ireland',
               'Netherlands','Belgium','Austria','Switzerland'
           ) THEN 'Europe'
           ELSE 'Other'
       END AS CustomerSegment
FROM customers;



/* Q3. Group By with Aggregation functions and Having clause, Date and Time functions

a.	Using the OrderDetails table, identify the top 10 products (by productCode) with the highest total order quantity across all orders.
*/

select * from orderdetails;
desc orderdetails;

SELECT 
    productCode,
    SUM(quantityOrdered) AS total_orders
FROM orderdetails
GROUP BY productCode
ORDER BY total_orders DESC
LIMIT 10;


/* b.	Company wants to analyse payment frequency by month. 
Extract the month name from the payment date to count the total number of payments for 
each month and include only those months with a payment count exceeding 20. 
Sort the results by total number of payments in descending order*/

SELECT 
    MONTHNAME(paymentDate) AS payment_month,
    COUNT(*) AS num_payments
FROM payments
GROUP BY MONTHNAME(paymentDate)
HAVING COUNT(*) > 20
ORDER BY num_payments DESC;



#Q4

desc customers;
show tables;
select * from customers;

CREATE TABLE Customers_new (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20));



CREATE TABLE Orders_new (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES Customers_new(customer_id),

    CONSTRAINT chk_amount
    CHECK (total_amount > 0));
    
    
/* Q5. JOINS
a. List the top 5 countries (by order count) that Classic Models ships to. */
    
    SELECT 
    c.country,
    COUNT(o.orderNumber) AS order_count
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
GROUP BY c.country
ORDER BY order_count DESC
LIMIT 5;


# Q6. SELF JOIN

CREATE TABLE project (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female'),
    ManagerID INT);
    
    INSERT INTO project (EmployeeID, FullName, Gender, ManagerID) VALUES
(1, 'Pranaya', 'Male', 3),
(2, 'Priyanka', 'Female', 1),
(3, 'Preety', 'Female', NULL),
(4, 'Anurag', 'Male', 1),
(5, 'Sambit', 'Male', 1),
(6, 'Rajesh', 'Male', 3),
(7, 'Hina', 'Female', 3);


SELECT 
    m.FullName AS Manager_Name,
    e.FullName AS Emp_Name
FROM project e
JOIN project m
    ON e.ManagerID = m.EmployeeID;
    
    
    
    
#Q7 

CREATE TABLE facility (
    Facility_ID INT,
    Name VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100));

ALTER TABLE facility
MODIFY Facility_ID INT AUTO_INCREMENT,
ADD PRIMARY KEY (Facility_ID);

ALTER TABLE facility
ADD City VARCHAR(100) NOT NULL AFTER Name;

select * from facility;
desc facility;



#Q8 views in sql 


CREATE VIEW product_category_sales AS
SELECT 
    pl.productLine,
    SUM(od.quantityOrdered * od.priceEach) AS total_sales,
    COUNT(DISTINCT o.orderNumber) AS number_of_orders
FROM productlines pl
JOIN products p 
    ON pl.productLine = p.productLine
JOIN orderdetails od 
    ON p.productCode = od.productCode
JOIN orders o 
    ON od.orderNumber = o.orderNumber
GROUP BY pl.productLine;

SELECT * FROM product_category_sales;




#Q9 stored procedures



#Q10 window function

SELECT 
    c.customerName,
    COUNT(o.orderNumber) AS order_count,
    RANK() OVER (ORDER BY COUNT(o.orderNumber) DESC) AS order_frequency_rnk
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
GROUP BY c.customerName;



WITH monthly_orders AS (
    SELECT 
        YEAR(orderDate) AS year,
        MONTHNAME(orderDate) AS month,
        MONTH(orderDate) AS month_num,
        COUNT(orderNumber) AS total_orders
    FROM orders
    GROUP BY YEAR(orderDate), MONTH(orderDate), MONTHNAME(orderDate))

SELECT 
    year,
    month,
    total_orders,
    CONCAT(
        ROUND(
            (total_orders - LAG(total_orders) OVER (ORDER BY year, month_num))
            / LAG(total_orders) OVER (ORDER BY year, month_num) * 100),
        '%'
    ) AS YoY_Change
FROM monthly_orders
ORDER BY year, month_num;



#Q11


SELECT 
    productLine,
    COUNT(*) AS Total 
FROM products
WHERE buyPrice > (
    SELECT AVG(buyPrice) 
    FROM products)
GROUP BY productLine;


#Q12

CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    EmailAddress VARCHAR(100));



#Q12


CALL Insert_Emp_EH(1, 'John', 'john@gmail.com');

CALL Insert_Emp_EH(2, 'Priya', 'priya@gmail.com');

CALL Insert_Emp_EH(1, 'Mike', 'mike@gmail.com');

SELECT * FROM Emp_EH;


#Q13

CREATE TABLE Emp_BIT (
    Name VARCHAR(50),
    Occupation VARCHAR(50),
    Working_date DATE,
    Working_hours INT);

	
    
    DELIMITER //

CREATE TRIGGER before_insert_emp_bit
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = ABS(NEW.Working_hours);
    END IF;
END //

DELIMITER ;


INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);


INSERT INTO Emp_BIT VALUES
('Test', 'Tester', '2020-10-05', -8);

SELECT * FROM Emp_BIT;