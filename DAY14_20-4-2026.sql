/*INDEX-CLUSTERED INDEX-PK and Unique Columns
       NOn-Clustered-other than the pk and unique columns*/
       
select *from myemp where salary>10000;
EXPLAIN select *from myemp where salary>10000;
SELECT *FROM MYEMP;
CREATE INDEX SAL ON MYEMP(SALARY);

SHOW INDEXES FROM MYEMP;#it will show the perfect output
#DROP OR ALTER FOR DELETEING INDEX

#INTERVIEW QUESTIONS
#RUNNING TOTAL,MOVING AVG
# DROP/ADD CONSTRAINTS FOR EXISTING TABLE ,DROP/ADD INDEXES 



#TCL

/*TCL COMMANDS-TRANSACTIONAL CONTROL LANGAUGE-COMMIT,ROLLBACK,SAVEPOINT
  TCL WILL WORK ALONG WITH DML COMMANDS-INSERT,UPDATE,DELETE*/
  
  truncate table TCL;
    CREATE TABLE TCL(FN VARCHAR(2));
  INSERT INTO TCL VALUES("A"),
                        ("B");
SELECT *FROM TCL;

START TRANSACTION;
   INSERT INTO TCL VALUES("C"),
                        ("D"),
                        ("E");
                        SELECT *FROM TCL;
  ROLLBACK;
  commit;
  
  
  
  #DELETE
 START TRANSACTION;
 
 DELETE FROM TCL WHERE FN="D";
 
 ROLLBACK;
  commit;

  SELECT *FROM TCL;
  
  
  
  #SAVEPOINT  [NOT IMP]
  
CREATE TABLE SP(NAME VARCHAR(2));
START TRANSACTION;
INSERT INTO SP VALUES("A"),
                     ("B");
SAVEPOINT AB;
INSERT INTO SP VALUES("C"),
                     ("D");
SAVEPOINT CD;	
INSERT INTO SP VALUES("E"),
                     ("F");
  SAVEPOINT EF;                   
INSERT INTO SP VALUES("G"),
                     ("H");a
SAVEPOINT JH;
	INSERT INTO SP VALUES("I"),
                     ("J");
SELECT *FROM SP;

ROLLBACK TO JH;
ROLLBACK TO EF;
ROLLBACK TO CD;
ROLLBACK TO AB;

COMMIT;


/* Here are the questions exactly as shown in your screenshot:

1. How to retrieve the second-highest salary of an employee?
2. How to get the nth highest salary?
3. How do you fetch all employees whose salary is greater than the average salary?
4. Write a query to display the current date and time.
5. How to find duplicate records in a table?
6. How can you delete duplicate rows?
7. How to get the common records from two tables?
8. How to retrieve the last 10 records from a table?
9. How can you find the employees who do not have a manager?
10. How to write a query to update the salary of all employees by 10%?
11. How to fetch the first and last record from a table?
*/