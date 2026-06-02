create database miniproject;

use miniproject;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender CHAR(1),
  city VARCHAR(50),
  join_date DATE);
  
  
  INSERT INTO customers VALUES
(1,'Arjun','Rao','M','Bangalore','2020-02-15'),
(2,'Sneha','Patil','F','Mumbai','2021-05-10'),
(3,'Kiran','Shah','M','Delhi','2019-08-25'),
(4,'Meena','Kumar','F','Chennai','2022-01-05'),
(5,'Rahul','Das','M','Kolkata','2020-11-22');

select * from customers;


CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  unit_price DECIMAL(10,2));

INSERT INTO products VALUES
(101,'Laptop','Electronics',55000),
(102,'Headphones','Electronics',3000),
(103,'Office Chair','Furniture',7000),
(104,'Notebook','Stationery',80),
(105,'Water Bottle','Accessories',250);

select * from products;


CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  sale_date DATE,
  customer_id INT,
  product_id INT,
  quantity INT,
  discount DECIMAL(5,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id));

INSERT INTO sales VALUES
(1,'2024-01-12',1,101,2,10),
(2,'2024-02-05',2,103,1,0),
(3,'2024-02-10',3,102,3,5),
(4,'2024-03-15',1,104,10,0),
(5,'2024-03-28',4,105,5,8),
(6,'2024-04-02',2,101,1,15),
(7,'2024-04-15',5,104,20,0),
(8,'2024-05-10',3,105,2,10),
(9,'2024-06-01',1,103,1,0),
(10,'2024-07-18',4,101,1,5);

select * from sales;

CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_name VARCHAR(50),
  city VARCHAR(50));

INSERT INTO regions VALUES
(1,'South','Bangalore'),
(2,'West','Mumbai'),
(3,'North','Delhi'),
(4,'South','Chennai'),
(5,'East','Kolkata');

select * from regions;


# 1. Find total sales amount per product.
SELECT 
    p.product_id,
    p.product_name,
    SUM(s.quantity * p.unit_price) AS total_sales_amount
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name;


#2. Calculate average discount per product category.
SELECT 
    p.category,
    AVG(s.discount) AS avg_discount
FROM products p
JOIN sales s
    ON p.product_id = s.product_id
GROUP BY p.category;

#3. Display monthly sales trend (quantity sold per month).
SELECT 
    MONTH(sale_date) AS month,
    SUM(quantity) AS total_quantity_sold
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY month;

#4. Show top 3 cities by total revenue
SELECT 
    c.city,
    SUM(s.quantity * p.unit_price) AS total_revenue
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
JOIN products p
ON s.product_id = p.product_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 3;


#5. Display customer name, product, and sales amount using JOINs
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    (s.quantity * p.unit_price) AS sales_amount
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
JOIN products p
ON s.product_id = p.product_id;


#6. Identify customers who never made a purchase
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;

#7. Combine region and sales data to show total sales per region
SELECT 
    r.region_name,
    SUM(s.quantity * p.unit_price) AS total_sales
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
JOIN regions r
ON c.city = r.city
JOIN products p
ON s.product_id = p.product_id
GROUP BY r.region_name;


#8. Rank customers by total revenue using RANK()
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(s.quantity * p.unit_price) AS total_revenue,
    RANK() OVER(ORDER BY SUM(s.quantity * p.unit_price) DESC) AS customer_rank
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
JOIN products p
ON s.product_id = p.product_id
GROUP BY c.customer_id, customer_name;


#9. Calculate cumulative sales month-over-month using SUM() OVER
SELECT 
    MONTH(sale_date) AS month,
    SUM(quantity) AS monthly_sales,
    SUM(SUM(quantity)) OVER(ORDER BY MONTH(sale_date)) AS cumulative_sales
FROM sales
GROUP BY MONTH(sale_date);

#10. Compare category average vs overall average order size
SELECT 
    p.category,
    AVG(s.quantity) AS category_avg_order_size,
    (SELECT AVG(quantity) FROM sales) AS overall_avg_order_size
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category;

#11. Find each sale’s contribution % to total revenue
SELECT 
    s.sale_id,
    (s.quantity * p.unit_price) AS sale_revenue,
    ROUND(
        ((s.quantity * p.unit_price) /
        SUM(s.quantity * p.unit_price) OVER()) * 100, 2
    ) AS contribution_percentage
FROM sales s
JOIN products p
ON s.product_id = p.product_id;


#12. Identify customers who purchased Electronics more than once
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(*) AS electronics_purchases
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
JOIN products p
ON s.product_id = p.product_id
WHERE p.category = 'Electronics'
GROUP BY c.customer_id, customer_name
HAVING COUNT(*) > 1;


#13. Calculate month-over-month revenue growth using LAG()
SELECT 
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER(ORDER BY month) AS previous_month_revenue,
    (monthly_revenue - LAG(monthly_revenue) OVER(ORDER BY month))
    AS revenue_growth
FROM (
    SELECT 
        MONTH(s.sale_date) AS month,
        SUM(s.quantity * p.unit_price) AS monthly_revenue
    FROM sales s
    JOIN products p
    ON s.product_id = p.product_id
    GROUP BY MONTH(s.sale_date)
) t;

#14. Find top-selling product per month
SELECT *
FROM (
    SELECT 
        MONTH(s.sale_date) AS month,
        p.product_name,
        SUM(s.quantity) AS total_quantity,
        RANK() OVER(
            PARTITION BY MONTH(s.sale_date)
            ORDER BY SUM(s.quantity) DESC
        ) AS rank_no
    FROM sales s
    JOIN products p
    ON s.product_id = p.product_id
    GROUP BY MONTH(s.sale_date), p.product_name
) t
WHERE rank_no = 1;


#15. List repeat customers (purchased in multiple months)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT MONTH(s.sale_date)) AS active_months
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name
HAVING COUNT(DISTINCT MONTH(s.sale_date)) > 1;

#16. Analyze customer retention (first vs last purchase date)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    MIN(s.sale_date) AS first_purchase,
    MAX(s.sale_date) AS last_purchase
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name;


#17. Find most popular category by gender
SELECT *
FROM (
    SELECT 
        c.gender,
        p.category,
        COUNT(*) AS total_purchases,
        RANK() OVER(
            PARTITION BY c.gender
            ORDER BY COUNT(*) DESC
        ) AS rank_no
    FROM sales s
    JOIN customers c
    ON s.customer_id = c.customer_id
    JOIN products p
    ON s.product_id = p.product_id
    GROUP BY c.gender, p.category
) t
WHERE rank_no = 1;


#18. Show top 3 customers in each region by revenue
SELECT *
FROM (
    SELECT 
        r.region_name,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(s.quantity * p.unit_price) AS total_revenue,
        RANK() OVER(
            PARTITION BY r.region_name
            ORDER BY SUM(s.quantity * p.unit_price) DESC
        ) AS rank_no
    FROM sales s
    JOIN customers c
    ON s.customer_id = c.customer_id
    JOIN regions r
    ON c.city = r.city
    JOIN products p
    ON s.product_id = p.product_id
    GROUP BY r.region_name, customer_name
) t
WHERE rank_no <= 3;


#19. Identify slow-moving products with low total sales
SELECT 
    p.product_id,
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(s.quantity) < 5;


#20. Calculate category revenue share percentage
SELECT 
    p.category,
    SUM(s.quantity * p.unit_price) AS category_revenue,
    ROUND(
        (SUM(s.quantity * p.unit_price) /
        SUM(SUM(s.quantity * p.unit_price)) OVER()) * 100,
        2
    ) AS revenue_share_percentage
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category;
