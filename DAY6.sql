 /* JOINS-
   INNER JOIN-COMMON RECORDS B/W THE TABLES
   left outer join/LEFT JOIN-ALL RECORDS FROM LEFT TABLE AND COMMON RECORDS FROM RIGHT TABLE(LT-FACT TABLE)
   RIGHT outer join/right JOIN-ALL RECORDS FROM RIGHT TABLE AND COMMON RECORDS FROM LEFT TABLE
   FULL JOIN-ALL RECORDS FROM BOTH THE TABLES-combine tables data -union or union all
   CROSS JOIN-PRODUCT B/W TWO TABLES
   SELF JOIN-JOIN APPLIED ON A SINGLE TABLE
   NATURAL JOIN,
   LEFT ANTI JOIN-UNIQUE RECORDS FROM LEFT TABLE
   RIGHT ANTI JOIN-UNIQUE RECORDS FROM RIGHT TABLE
   
   
   performance wise inner > left >full
   most of the time we use left join
   we r bringing the common records from dimenstion table to fact table
   */
   select * from movies;#dimenstion table ,PK=id
   select * from members;#Fact table ,PK=memid ,FK=movieid
   
   #inner join
   select * from members inner join movies on members.movieid=movies.id;
   
select MEMID,MOVIEID,FIRST_NAME,TITLE,CATEGORY
	FROM members inner join movies on members.movieid=movies.id;
    
select MEMID,MOVIEID,FIRST_NAME,TITLE,CATEGORY
	FROM members AS A inner join movies AS B on A.movieid=B.id;#BY USING ALIAS 
    #LEFT JOIN
 select MEMID,MOVIEID,FIRST_NAME,TITLE,CATEGORY
	FROM members AS A LEFT join movies AS B on A.movieid=B.id;#BY USING ALIAS    
    
#right join
select MEMID,MOVIEID,FIRST_NAME,TITLE,CATEGORY
	FROM members AS A right join  movies AS B on A.movieid=B.id;#BY USING ALIAS 
    
#cross join
select * from meals;
select * from drinks;
select *
	FROM meals   cross join  drinks;#     
    select *,A.RATE+B.RATE AS TOTAL_PRICE FROM meals AS A cross join  drinks AS B;
    

#MULTIPLE JOINS
-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Create Products table
CREATE TABLE Productss (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create Orders table
CREATE TABLE Orderss (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Productss(product_id)
);

-- Insert data into Customers
INSERT INTO Customers (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Alice Brown', 'alice@example.com');

-- Insert data into Products
INSERT INTO Productss (product_id, product_name, price) VALUES
(501, 'Laptop', 1200),
(502, 'Smartphone', 800),
(503, 'Tablet', 600);

-- Insert data into Orders
INSERT INTO Orderss (customer_id, product_id, order_date) VALUES
(1, 501, '2023-10-01'),
(2, 502, '2023-10-02'),
(1, 503, '2023-10-03');

SELECT *FROM CUSTOMERS;
SELECT *FROM PRODUCTSS;
SELECT *FROM ORDERSS;

