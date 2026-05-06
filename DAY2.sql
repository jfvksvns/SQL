select database() EXCELR;
SHOW databases;
USE EXCELR;


#OPERATORS
SELECT * FROM MYEMP;

#NUMBER OF RECORDS
SELECT COUNT(*) FROM MYEMP;

#TO SORT THE COLUMNS=ORDER BY ASCENDIGN AND DESCENDING
SELECT * FROM MYEMP ORDER BY SALARY ASC;
SELECT * FROM MYEMP ORDER BY SALARY DESC;

SELECT * FROM MYEMP ORDER BY FIRST_NAME ASC;
SELECT * FROM MYEMP ORDER BY LAST_NAME ASC;
SELECT * FROM MYEMP ORDER BY FIRST_NAME desc;

/*LIMIT = LIMITING THE NUMBER OF RECORDS from database AND TO FIND
 THE TOP 5/10/15 SALES/PROFIT/SALERIES ETC ...*/
select * from myemp;

/* here for example if we have 1lk of records means 
if i mentioned only 100 as a limit 
means i will get only that much record */
select * from myemp limit 100;
select * from myemp limit 10;

#top5/top10 salaries
select * from myemp order by salary  desc limit 5;
select * from myemp order by salary  desc limit 10;
#bottom 5 salary
select * from myemp order by salary  asc limit 5;


#distinct-to find know the unique records in a column
select distinct(dep_id) from myemp;
select * from myemp;
select distinct(job_id) from myemp;

select count(distinct(dep_id)) from myemp;
select count(distinct(job_id)) from myemp;
select count(distinct(email)) from myemp;

#I WANT TO KNOW THE EMPID 104 DETAILS
select * from myemp WHERE EMP_ID=104;
#FOR MULTIPLE DETAILS
select * from myemp WHERE EMP_ID IN (104,105,106,107);

# I WANT TO KNOW THE emp list belongs to st_clerk
select * from myemp where job_id ="st_clerk";

#fetch salary greater than 10000
select * from myemp where salary>10000;

#fetch salary less than 10000
select * from myemp where salary<10000;

#fetch salary between 10000 and 15000
select * from myemp where salary > 10000 and salary<15000;
select * from myemp where salary between 10000 and 15000;

#fetch salary equal to 10000
select * from myemp where salary=10000;


 #WILD CARDS %,_=LIKE OPERATOR=TO KNOW THE PRODUCT NAMES,EMP NAMES,CUSTOMER NAMES,YR ETC

SELECT * FROM MYEMP WHERE FIRST_NAME LIKE "A%";/*HERE IT WILL SELECT ONLY 
THE FIRST NAME THAT STRTS WITH THE A AND FURTHER CARRY WITH OTHER LETTERS*/

SELECT * FROM MYEMP WHERE FIRST_NAME LIKE "%A%";/*HERE IT WILL SELECT ONLY 
THE FIRST NAME THAT CONTAINS A IN IT AND FURTHER CARRY WITH OTHER LETTERS*/

SELECT * FROM MYEMP WHERE FIRST_NAME LIKE "%A";/*HERE IT WILL SELECT ONLY 
THE FIRST NAME THAT ENDS WITH THE A */

SELECT * FROM MYEMP WHERE SALARY LIKE "10%";
SELECT * FROM MYEMP WHERE HIRE_DATE LIKE "1987%";
SELECT * FROM MYEMP WHERE FIRST_NAME LIKE "N%A";

#DATE COLUMN
SELECT YEAR(HIRE_DATE),#here the year is extracted from the hire_date column
	QUARTER(HIRE_DATE),#here hire_date which is the table name is also printing on the output table
	MONTH(HIRE_DATE),
	MONTHNAME(HIRE_DATE) 
	FROM MYEMP;
    
    
SELECT YEAR(HIRE_DATE) as year,#here the year is extracted from the hire_date column
	QUARTER(HIRE_DATE) as quarter,#here  i am using the alias for avoiding to print the output table 
	MONTH(HIRE_DATE) as month,
	MONTHNAME(HIRE_DATE) as month_name ,
	concat(year(hire_date), "-", monthname(hire_Date) ,"-", quarter(hire_date),"-",month(hire_date)) as yr_mn_qq_month
	FROM MYEMP;
    
    #fetch the emp who joined in 1987 and in sep month 
select * from myemp where year(hire_date)=1987 and month(hire_date)=09; 
select * from myemp where year(hire_date) in (1987,1989) and month(hire_date) in (09, 06);#for multiple data

 
