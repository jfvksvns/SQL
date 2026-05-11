#CASE STATEMENT = IT IS SAME AS IF STATEMENT 
#SALARY CATEGORY
SELECT *,
	CASE WHEN SALARY >20000 THEN "HIGH SALARY"
	WHEN SALARY BETWEEN 10000 AND 20000 THEN "MIDUM SALAY"
	ELSE "LOW SALARY"
	END as salary_category#this is the column name
	FROM MYEMP;
    
    select EMP_ID ,
			salary,
            FIRST_NAME,
	case when EMP_ID=104 THEN 0.3*SALARY+SALARY#BEFORE CASE STATEMENT ALWAYS USE CAMMA
        WHEN FIRST_NAME='DEN' THEN 0.2*SALARY+SALARY
        WHEN JOB_ID='FI_ACCOUNT' THEN 0.1*SALARY+SALARY
        ELSE SALARY
        END AS BONUS,
	case when EMP_ID=104 THEN 0.3*SALARY+SALARY
        WHEN FIRST_NAME='DEN' THEN 0.2*SALARY+SALARY
        WHEN JOB_ID='FI_ACCOUNT' THEN 0.1*SALARY+SALARY
        ELSE SALARY
        END-SALARY AS BONUS_AMOUNT
        FROM MYEMP;
        SELECT * FROM MYEMP;
        
        
	select EMP_ID ,
			salary,
            FIRST_NAME,
	case when EMP_ID=104 THEN 0.3*SALARY+SALARY#BEFORE CASE STATEMENT ALWAYS USE CAMMA
        WHEN FIRST_NAME='DEN' THEN 0.2*SALARY+SALARY
        WHEN JOB_ID='FI_ACCOUNT' THEN 0.1*SALARY+SALARY
        ELSE SALARY
        END AS BONUS,
	case when EMP_ID=104 THEN 0.3*SALARY+SALARY
        WHEN FIRST_NAME='DEN' THEN 0.2*SALARY+SALARY
        WHEN JOB_ID='FI_ACCOUNT' THEN 0.1*SALARY+SALARY
        ELSE SALARY
        END-SALARY AS BONUS_AMOUNT
        FROM MYEMP
		where EMP_ID=104 or FIRST_NAME='DEN' or JOB_ID='FI_ACCOUNT';
        
        #usig sales database
        select * from orders;
        desc orders;
        
#region wise sales classification
select region,sum(sales) as total_sales,
case
when sum(sales) >50000 then 'HIGH SALES'
when sum(sales) BETWEEN 20000 AND 50000 then 'MEDIUM'
ELSE 'LOW SALES'
END AS REION_WISE_SALES
FROM ORDERS
GROUP BY REGION;

#state-wise profit bucket(high/medium/loss)
SELECT State,
       SUM(Profit) AS total_profit,
       CASE 
           WHEN SUM(Profit) > 5000 THEN 'High Profit'
           WHEN SUM(Profit) between  1000 and 5000 THEN 'Medium Profit'
           ELSE 'Loss'
       END AS profit_bucket
FROM orders
GROUP BY State;

#customer category(platinum/gold/silver)
SELECT `Customer Name`,
       SUM(Sales) AS total_sales,
       CASE 
           WHEN SUM(Sales) > 500 THEN 'Platinum'
           WHEN SUM(Sales) between 100 and 500 THEN 'Gold'
           ELSE 'Silver'
       END AS customer_category
FROM orders
GROUP BY `Customer Name`;

#manager target achievement classification(achieved/not achieved)
SELECT Manager,
       SUM(Sales) AS total_sales,
       SUM(Target) AS total_target,
       CASE 
           WHEN SUM(Sales) >= SUM(Target) THEN 'Achieved'
           ELSE 'Not Achieved'
       END AS target_status
FROM orders
GROUP BY Manager;

#quarter wise sales using case statement
        SELECT 
       CASE 
           WHEN MONTH(`Order Date`) BETWEEN 1 AND 3 THEN 'Q1'
           WHEN MONTH(`Order Date`) BETWEEN 4 AND 6 THEN 'Q2'
           WHEN MONTH(`Order Date`) BETWEEN 7 AND 9 THEN 'Q3'
           ELSE 'Q4'
       END AS quarter,
       SUM(Sales) AS total_sales
FROM orders
where year(`order date`)=2018
GROUP BY quarter;


#COALESCE=IT WILL PICK FIRST NON NULL VALUE IN THE TABLE
CREATE TABLE CL(FN VARCHAR(2),MN VARCHAR(2),LN VARCHAR(2));
INSERT INTO CL VALUES('A',NULL,NULL),
			(NULL,'B',NULL),
			(NULL,NULL,'C'),
			(NULL,NULL,'D'),
			('E','F','G');
SELECT * FROM CL;
SELECT coalesce(FN,MN,LN) AS NAMES FROM CL;