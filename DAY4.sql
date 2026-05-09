USE EXCELR;

/*GROUP BY - IT WILL WORK WITH AGGREGATED FUNCTIONS
EX:REGION WISE SALES*/

SELECT * FROM MYEMP;
#DEPARTMENT WISE TOTAL SALARIES

SELECT DEP_ID ,
			SUM(SALARY) AS TOTAL_SALARY 	
            FROM MYEMP 
            GROUP BY DEP_ID;
            
            
SELECT DEP_ID ,
			SUM(SALARY) AS TOTAL_SALARY 	
            FROM MYEMP 
            GROUP BY DEP_ID
            order by dep_id asc
            limit 5;
            
SELECT DEP_ID,
		SUM(SALARY) AS TOTAL_SALARY,
		MAX(SALARY) AS MAX_SALARY,
		MIN(SALARY) AS MIN_SALARY,
		AVG(SALARY) AS AVG_SALARY,
        count(*) as no_of_emp
FROM MYEMP
GROUP BY DEP_ID
ORDER BY DEP_ID ASC;#queries releated by taking dep_id as a refrence



SELECT 
		SUM(SALARY) AS TOTAL_SALARY,#total sales related to queries of myemp table
		MAX(SALARY) AS MAX_SALARY,
		MIN(SALARY) AS MIN_SALARY,
		AVG(SALARY) AS AVG_SALARY,
        count(*) as no_of_emp
FROM MYEMP;


#MULTIPLE GROUP BY
SELECT DEP_ID,MGR_ID,
		SUM(SALARY) AS TOTAL_SALARY,
		MAX(SALARY) AS MAX_SALARY,
		MIN(SALARY) AS MIN_SALARY,
		AVG(SALARY) AS AVG_SALARY
FROM MYEMP
GROUP BY 1,2;#DEP_ID,MGR_ID; 

/* HAVING =IT IS LIKE A FILTER AND IT WILL WORK ALNOG WITH THE GROUP BY ,
 THIS HAVING WILL execute AFETR THE GROUP BY.
 BOTH HAVING AND GROUPBY WILL WORK ON AGRIGATED FUNCTION*/

SELECT DEP_ID ,
			SUM(SALARY) AS TOTAL_SALARY 
            FROM MYEMP 
            GROUP BY DEP_ID
            HAVING DEP_ID IN(10,20,60)
            ORDER BY DEP_ID desc;

SELECT DEP_ID ,
			SUM(SALARY) AS TOTAL_SALARY 
            FROM MYEMP 
            GROUP BY DEP_ID
            HAVING total_salary>5000
            #HAVING total_salary>5000 AND dep_id in (10,20,30,50) #FOR MULTIPLE HAVING 
            ORDER BY DEP_ID desc;

#GROUP BY ,HAVING AND WHERE
select DEP_ID , 
		SUM(salary) AS TOTAL_SALARY
from myemp
where dep_id in (10,20,30,40,50) #using where clause
group by dep_id ;

select DEP_ID , 
		SUM(salary) AS TOTAL_SALARY
from myemp
group by dep_id # using having clause
having dep_id in (10,20,30,40,50)  ;

select DEP_ID , 
		SUM(salary) AS TOTAL_SALARY
from myemp
where dep_id in (10,20,30,40,50) #using where ,group by and having
group by dep_id 
having sum(salary)>3000;
		


#now i am using the sales database
select * from orders;


#category wise sales
select category ,sum(sales) as total_sales from orders
	group by category;

#region wise sales
select region ,sum(sales) as total_sales from orders
	group by region;
    
    
#central region wise sales
select region ,sum(sales) as total_sales from orders
	group by region
    having region="central";
select region ,sum(sales) as total_sales from orders
    where region="central"
	group by region;

#country wise sales
select country ,sum(sales) as total_sales from orders
	group by country;
  
select * from orders;
desc orders;

#year wise total sales
SELECT YEAR(`Order Date`) AS year,
       SUM(Sales) AS total_sales
FROM orders
GROUP BY 1;# or i can use this YEAR(`Order Date`);	

#category ,sub-category wise sales
select category ,`sub-category` ,sum(sales) as total_sales 
from orders
group by 1,2;#category,`sub-category` ;#here `` is used for column name 
#where as '' is used for the string

#country wise top5 sales
select country ,sum(sales) as total_sales from orders
	group by country
    order by SUM(sales) desc limit 5;

#quarter wise total sales in 2018
select quarter(`order date`) as quarter ,
		sum(sales) as total_sales 
		from orders
        where year(`order date`)=2018
    group by quarter(`order date`);
   
#country,state wise total profit
select country,state,sum(profit) as total_profit from orders
group by 1,2;# country,state;		

#germany,denmark,ital total sales
select country ,sum(sales) as total_sales from orders
	group by country
    having country in ('germany','denmark','italy');
    
SELECT COUNTRY,SUM(SALES) AS TOTAL_SALES
FROM ORDERS
WHERE COUNTRY IN ('GERMANY','DENMARK','ITALY')
GROUP BY 1;
	

#find furniture sales in germany
select country ,category, sum(sales) as total_sales from orders
	where category='furniture' and country = 'germany'
    group  by category,country ;

#FETCH STATES WISE SALES GREATER THAN 5000
SELECT STATE,
SUM(SALES) AS TOTAL_SALES
FROM ORDERS
GROUP BY 1
HAVING SUM(SALES)>5000;

SELECT SUM(Sales) AS total_sales,STATE
FROM orders
GROUP BY STATE
HAVING SUM(Sales) > 5000;

#SUB-CATOGROY WISE TOTAL SALES ,PROFIT,QUANTITY
SELECT `Sub-Category`,
       SUM(Sales) AS total_sales,
       SUM(Profit) AS total_profit,
       SUM(Quantity) AS total_quantity
FROM orders
WHERE YEAR(`Order Date`) = 2018
GROUP BY `Sub-Category`;
select * from orders;

#FIND THE TOTAL NUMBER OF ORDERS IN EACH COUNTRY IN 2020
SELECT Country,
       COUNT(order_id) AS total_number_of_orders
FROM orders
WHERE YEAR(`Order Date`) = 2020
GROUP BY Country;


