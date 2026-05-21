

#important for interview

#subqueries-query inside the query with multiple  select statements 

select * from myemp;

#FIND THE MAX SALARY OF EMP ALONG WITH ALL OTHER DETAILS
select max(salary) from myemp;
select * from myemp where SALARY =24000;#this both queries r by not using sub queries

select * from myemp where salary =(select max(salary) from myemp) ;#this query is by using the sub query

#FIND THE EMP SAL GREATER THAN AVG SAL
select avg(salary) from myemp;
select * from myemp where salary > (select avg(salary) from myemp) ;


#FIND THE DEP WISE EMP SAL,WHOSE SAL IS GREATER THAN AVG SAL
SELECT DEP_ID,AVG(SALARY) FROM MYEMP GROUP BY DEP_ID;
SELECT * FROM MYEMP AS E WHERE SALARY>(SELECT AVG(SALARY) FROM MYEMP WHERE DEP_ID=E.DEP_ID);
/*TAKING THE HELP OF OUTER QUERY COLUMN INTO INNER QUERY COLUMN CALLED AS CO-RELATED SUBQUERY*/

#find the dep wise max sal 
select MAX(SALARY) FROM MYEMP  ;
SELECT * FROM MYEMP AS E WHERE SALARY=(SELECT MAX(SALARY) FROM MYEMP WHERE DEP_ID=E.DEP_ID);

SELECT EMP_ID,
DEP_ID,
FIRST_NAME,
SALARY FROM MYEMP AS E WHERE SALARY=(SELECT MAX(SALARY) FROM MYEMP WHERE DEP_ID=E.DEP_ID);


#IMP   FIND THE EMP SALARYS WHO IS GETTING GREATER THAN THER MANAGERS[1:00]
SELECT * FROM MYEMP AS E WHERE SALARY>(SELECT MAX(SALARY) FROM MYEMP WHERE Emp_ID=E.mgr_ID);
#here the basic intent is few employess are working under few manger where they are getting more salary than him 
select * from myemp where emp_id in (148,149);

#FIND THE EMPS BELONGS TO USA ONLY

select * from employees;
select * from offices;


# This query uses JOIN to get employees working in USA offices
SELECT A.employeeNumber,
       A.firstName,
       B.country
FROM employees AS A
INNER JOIN offices AS B
ON A.officeCode = B.officeCode
WHERE B.country = 'USA';#performance wise always use the joins over all others


# This query uses a subquery to filter employees in USA offices
SELECT employeeNumber,
       firstName
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM offices
    WHERE country = 'USA');
    
    

/*
VIEW - VIRTUAL TABLE , IT WILL NOT STORE PHYSICALLY IN DATABSE
WHEN YOU WANT EXECUTE QUERY FREQUENTLY TO KNOW DATA ,
IF U WANT TO STORE THE LENGTY QUERY 
IF U WANT TO GIVE SOME SECURITY TO YOUR QUERY WITHOUT DISCLOSING THE ENTIRE SCENIRIO
*/

USE EXCELR;

CREATE VIEW DEP50 AS(SELECT * FROM MYEMP WHERE DEP_ID =50);
#HERE DEP50 IS THE VIEW NAME AND WE R PUSHING ALL THE RECORDS OF DEP_ID =50 TO THIS PERTICULAR VIEW 

select * FROM DEP50;

USE SALES ;
# Create a view for orders from Germany
CREATE VIEW GermanySales AS
SELECT *
FROM orders
WHERE country = 'Germany';

# View the data
SELECT * FROM GermanySales;


# Create a view to calculate total sales and growth percentage
desc ORDERS;
# Create a view to calculate total sales and growth percentage
CREATE VIEW Cat_SalesGrowth AS
SELECT `Order Date`,
       `Category`,
       `Segment`,
       `Country`,
       `Sales`,
       SUM(`Sales`) OVER() AS total_sales,
       ROUND(`Sales` / SUM(`Sales`) OVER() * 100, 2) AS growth,
       FLOOR(`Sales` / SUM(`Sales`) OVER() * 100) AS growth_floor
FROM orders;

# View the data
SELECT * FROM Cat_SalesGrowth;


/* STORED PROCEDURE = IT IS USED TO STORE THE QUERY PHYSICALLY IN THE DATABASE

BIG SCENARIOS ARE STORES UNDER STORED PROCEDURE
IN SP-PARAMETERS,LOOPS,ERROR HANDLING ,CURSOR,TRIGGERS

SP ARE USED TO RUN TO GENERATE DAILY,WEEKLY,MONTHLY,QUARTERLY,YEARLY ETC REPORTS */

#MAINLY FOR EXPRENCEIED NOT PREFERED FOR THE FRESHERS 




