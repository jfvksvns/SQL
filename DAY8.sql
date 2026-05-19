select * from customers;
select * from orders;
select * from movies;
select * from members;

#NATURAL JOIN        
#natural join: automatically joins two tablesbased on common column names.
select *from customers natural join orders;
SELECT FIRST_NAME,title
FROM MEMBERS
NATURAL JOIN MOVIES;


#left  anti join :returns rows from left table that do not exist right tables.alter
SELECT *
FROM MEMBERS AS mem LEFT JOIN MOVIES AS MV
ON mem.movieid=mv.id
WHERE mv.id IS NULL;
     
#RIGHT ANTI JOIN
SELECT *
FROM MEMBERS AS mem RIGHT JOIN MOVIES AS MV
ON mem.movieid=mv.id
WHERE mem.memid IS NULL;




#WINDOW FUNCTIONS
#AGGREGATED FUNCTIONS
SELECT emp_id,
       first_name,
       dep_id,
       sum(salary) as total_salary
	from myemp
    group by emp_id,first_name,dep_id;#grouping without window function
    
SELECT dep_id,#here used agrigated function and group by function 
       sum(salary) as total_salary
	from myemp
    group by dep_id;#no window function
 
 #window function is applied here
 /* here after exicuting this quiery and by comparing it with the above query we will let u know the differnce between each
 in this window function all agrigating,grouping and partition all together is applied */
  SELECT emp_id,
       first_name,
       dep_id,
       salary,
       sum(salary) over(partition by dep_id) as total_salary
from myemp;



 
 
 /*RANKING FUNCTIONS-RANK()-SKIP IN THE RANKS
                     DENSE_RANK() IS A CONTINUOUS RANKS
                     ROW_NUMBER() IS LIKE ASSIGNING THE ROW NUMBERS/SL NO/INDEX NOS
                     */
                     
	#RANK
    SELECT *,
          RANK() OVER(ORDER BY SALARY DESC) AS RNKS#in output ranks gets skip
          FROM MYEMP;
          
	   #DENSERANK 
     SELECT *,
          DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNKS#in output ranks is continious
          FROM MYEMP;
          
 SELECT EMP_ID,FIRST_NAME,SALARY,
         RANK() OVER(ORDER BY SALARY DESC) AS RNKS,#by this output we will get differnce of both
		 DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DENSERNKS
   FROM MYEMP;
   
   
   #DEP WISE RANKS
    SELECT EMP_ID,FIRST_NAME,DEP_ID,SALARY,
    DENSE_RANK() OVER(PARTITION BY DEP_ID ORDER BY SALARY DESC) AS DENSERNKS
     FROM MYEMP;
     
     
#FIND THE 3RD HIGHEST SALARY 
    #FIND THE DEP WISE 3,5,7 HIGHEST SALARIES
    
    #CTE-COMMON TABLE EXPRESSION-WITH CLAUSE IS USED TO WRITE A CTE FUNCTION
	#FIND THE 3RD HIGHEST SALARY 
WITH S AS(   SELECT *,
          DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNKS
          FROM MYEMP  )
        SELECT *FROM S WHERE RNKS=3;
        
        
WITH S AS(   SELECT *,
          DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RNKS
          FROM MYEMP  )
        SELECT *FROM S WHERE RNKS IN(3,5,7,8);    
        
#FIND THE DEP WISE 3,5,7 HIGHEST SALARIES
WITH S AS(   SELECT *,
          DENSE_RANK() OVER(PARTITION BY DEP_ID ORDER BY SALARY DESC) AS RNKS
          FROM MYEMP  )
        SELECT *FROM S WHERE RNKS=3; 
        
WITH S AS(   SELECT *,
          DENSE_RANK() OVER(PARTITION BY DEP_ID ORDER BY SALARY DESC) AS RNKS
          FROM MYEMP  )
        SELECT *FROM S WHERE RNKS IN(3,5,7); 
    
        #ROW NUMBER
SELECT *,
          ROW_NUMBER() OVER(PARTITION BY DEP_ID ) AS RNKS
		FROM MYEMP;
          
 SELECT *,
          ROW_NUMBER() OVER( ) AS RNKS
		FROM MYEMP;


