show databases;
use sales;
select * from orders;
desc orders;


/*Create a reusable, clean intermediate result (sub-category-wise sales) that you can use for further analysis.*/

 SELECT `SUB-CATEGORY`,
                         SUM(SALES) AS SALES
                         FROM ORDERS
                        GROUP BY `SUB-CATEGORY`;
                        
#SUB CAT WISE TOTAL SALES WITH PERCENTAGE calCULATION

WITH SUBCATSALES_CTE AS (#here this will store in the same query , it will  not carry further 	
    SELECT 
        `Sub-Category`,
        SUM(Sales) AS Sales
    FROM Orders
    GROUP BY `Sub-Category`
)
SELECT  
    `Sub-Category`,
    Sales,
    SUM(Sales) OVER() AS Total_Sales,
    CONCAT(ROUND(Sales / SUM(Sales) OVER() * 100, 2), "%") AS Per_Contribution
FROM SUBCATSALES_CTE;



show tables;

  create table SALES_ORDERS(
prod varchar(5),
SDate date,
Sales int,
primary key(prod,SDate,Sales) 
);

insert into SALES_ORDERS values
('A','2022-03-01',250),
('B','2021-10-17',550),
('A','2022-04-01',400),
('C','2021-02-15',850),
('A','2022-05-01',650),
('B','2021-09-17',500),
('A','2022-06-01',550),
('C','2021-03-15',1050),
('C','2021-04-15',900),
('A','2022-07-01',900),
('B','2021-11-17',750),
('C','2021-05-15',1000),
('B','2021-12-17',650);  




SELECT *FROM  SALES_ORDERS;

/*ANALYTICAL FUNCTIONS
LEAD-NEXT YEAR,MONTH,QUARTER,DAY
LAG-PREV YEAR,MONTH,QUARTER,DAY
*/
#LEAD
SELECT *,LEAD(SALES,1) OVER(partition by PROD) AS NXT_MON_SALES FROM  SALES_ORDERS; 
SELECT *,LEAD(SALES,1) OVER(partition by PROD) AS NXT_MON_SALES,
SALES-LEAD(SALES,1) OVER(partition by PROD) AS DIFF
FROM  SALES_ORDERS;



#MOM GROWTH PERCENTAGE

SELECT *,
  LAG(SALES,1,"-") OVER(partition by PROD) AS PREV_MON_SALES ,
  IFNULL(SALES-LAG(SALES,1) OVER(partition by PROD),"-") AS DIFF,
  
  IFNULL(CONCAT(ROUND((SALES-LAG(SALES,1) OVER(partition by PROD))/
  LAG(SALES,1) OVER(partition by PROD)*100,2),"%"),"-")AS SALES_GROWTH
  
FROM  SALES_ORDERS;
#LAG
SELECT *,LAG(SALES,1) OVER(partition by PROD) AS PREV_MON_SALES FROM  SALES_ORDERS;
 SELECT *,LAG(SALES,1) OVER(partition by PROD) AS PREV_MON_SALES,
 SALES-LAG(SALES,1) OVER(partition by PROD) AS DIFF
FROM  SALES_ORDERS;


select * from trains;

#FIND THE  NEXT STATION TIME
SELECT *,LEAD(TIME,1) OVER(PARTITION BY TRAIN_ID) AS NXT_STN_TIME FROM TRAINS;

#FIND THE PREVIOUS STATION TIME
SELECT *,LAG(TIME,1) OVER(PARTITION BY TRAIN_ID) AS PREV_STN_TIME FROM TRAINS;

SELECT *,LEAD(TIME,1) OVER(PARTITION BY TRAIN_ID) AS NXT_STN_TIME,
          LAG(TIME,1) OVER(PARTITION BY TRAIN_ID) AS PREV_STN_TIME
 FROM TRAINS;
 
SELECT *FROM SALES;
SELECT *,DENSE_RANK() OVER(PARTITION BY FISCAL_YEAR ORDER BY SALE) AS RNKS FROM SALES;



/*UNION -IT WILL NOT ALLOW DUPLICATES
  UNION ALL-IT WILL ALLOW DUPLICATES
  APPEND IN POWER bi
  FULL JOIN
  WHEN YOU WANT TO COMBINE THE TABLES 
  WITH SAME TABLE STRUCTURE AND SAME COLUMN HEADERS,DATA TYPES*/
  
  CREATE TABLE S1(SALARY INT);
  CREATE TABLE S2(SALARY INT);
  
  INSERT INTO S1 VALUES(2000),
                       (3000),
                       (4000);
	SELECT *FROM S1;
  
  INSERT INTO S2 VALUES(5000),
                       (3000),
                       (6000);
	SELECT *FROM S2;
    
    SELECT SALARY FROM S1
    UNION
SELECT SALARY FROM S2;

SELECT SALARY FROM S1
    UNION ALL
SELECT SALARY FROM S2;

select * FROM SALES;
SELECT 'MAX' AS type, MAX(sale) AS value FROM sales
UNION
SELECT 'MIN' AS type, MIN(sale) FROM sales;


select * from orders;
desc orders;

ALTER TABLE offices ADD COLUMN sales DECIMAL(10,2);

#TOP5 AND BOTTOM5
select * FROM sales;

#running total 
#moving average


	/*(SELECT COUNTRY,
		  SUM(SALES) AS SALES,
		  CONCAT("TOP",DENSE_RANK() OVER(ORDER BY SUM(SALES) DESC)) AS RNKS
		  FROM offices
		  GROUP BY COUNTRY
		  ORDER BY SALES DESC
		  LIMIT 5)				#output is wrong 
	UNION
	(SELECT COUNTRY,
		  SUM(SALES) AS SALES,
		  CONCAT("BOTTOM",DENSE_RANK() OVER(ORDER BY SUM(SALES) ASC)) AS RNKS
		  FROM offices
		  GROUP BY COUNTRY
		  ORDER BY SALES ASC
		  LIMIT 5) ;
		*/
    
    
