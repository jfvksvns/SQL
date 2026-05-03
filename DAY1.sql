#27/3/2026
CREATE database EXCELR;#TO CREATE DATABASE
USE EXCELR;#TO select DATABASE
SHOW databases;
USE EXCELR;#TO select DATABASE

#NEW TABLE
CREATE TABLE STUDENTS(SID INT ,
				SNAME char(30) ,	
                AGE INT , 
                COURSE CHAR(30));
                
                SHOW tables;#THIS WILL SHOW THE TABLE

#INSERT INTO TABLES
INSERT INTO STUDENTS values(1, "GURU" , 22 , 	"MYSQL");

SELECT * FROM STUDENTS;#TO VIEW THE CONTENT IN THE TABLE
#ABOVE * MEANS IT WILL select COMPLETE TABLE , ALL COLUMNS

select SID,SNAME,AGE FROM STUDENTS	;#THIS IS MANUALLY SELECTING THE COLUMNS

#30/3/2026
use excelr ;
SELECT * FROM STUDENTS;#TO VIEW THE CONTENT IN THE TABLE

#how to insert multiple records
insert INTO STUDENTS VALUES(2,"URUU",23,"PBI");
insert INTO STUDENTS VALUES(3,"DURUU",25,"JNRPBI"),(4,"RHVDF",29,"EXCEL"),(5,"ERDTH",30,"BERTGBR"),(6,"CTRWER",66,"WECGV");

#inserting into for only sepecific coloum that we want- here i am going to insert into only for sid ,sname and course

insert into students (sid , sname ,course) values(7,"serfg","jnrassignsent");

#deleting the specific rows by using the where clause
delete from students where SID=1;#single row will delete
delete from students where SID in (1,2,3);#multiple row will delete

#deleting complete content in the table ,remains only structure of the table 
truncate table students ;

#deleting the complete table form the database
drop table students;

#to know the table struture we use describe key word
desc students;
describe students;

#ALTER -ADD COLUMN , DROP COLUMN ,CHANGE AND MODIFY COLUMN
ALTER table STUDENTS ADD column MARKS INT;#ADDING COLUMN
ALTER table STUDENTS DROP column AGE;#DROPING COLUMN
ALTER table STUDENTS CHANGE SID SI_ID INT;#CHANGING THE SID TO SI_ID
ALTER table STUDENTS modify COLUMN SNAME varchar(30);#CHANGING COLUMN DATA TYPE

#RENAMING THE TABLE NAME
RENAME TABLE STUDENTS TO STUDENTS_REPORT;#HERE I HAD CHANGED THE TABLE TO STUDENTS_REPORT

SELECT * FROM STUDENTS_REPORT;
describe STUDENTS_REPORT;

INSERT INTO STUDENTS_REPORT values(1, "GURU" ,"MYSQL",22 );
insert INTO STUDENTS_REPORT VALUES(2,"URUU","PBI",35);
insert INTO STUDENTS_REPORT VALUES(3,"DURUU","JNRPBI",30),(4,"RHVDF","EXCEL",29),(5,"ERDTH","BERTGBR",30),(6,"CTRWER","WECGV",66);

set sql_safe_updates=0;#this query need to executive before update and delete command
#UPDATING THE DATA FIELDS
UPDATE STUDENTS_REPORT SET MARKS=50 WHERE SI_ID=3;

#updateing the student name and course by using the student_id
update students_report set sname="Ramesh",course="ds" where SI_ID=4;

#DEAL NULL WITH IS NULL OR NOT NULL
UPDATE students_report SET MARKS=90 WHERE MARKS IS NULL; 

#delete  = deleting the specific rows based on where clause
delete from students_report where SI_ID=5;
delete from students_report where SI_ID in (1,2);


#truncate = deleting all records and table structure is remains
TRUNCATE TABLE STUDENTS_REPORT;

#DROP = PERMANENT DELETEION OF TABLE FROM THE DATABASE
DROP TABLE STUDENTS_REPORT;

SELECT * FROM STUDENTS_REPORT;
describe STUDENTS_REPORT;





