create database TP;
show databases;
use TP;


CREATE TABLE first_table (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

CREATE TABLE second_table (
    id INT,
    project VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO first_table VALUES
(1, 'Alice', 'IT', 60000),
(2, 'Bob', 'HR', 50000),
(3, 'Charlie', 'IT', 70000),
(4, 'David', 'Finance', 55000),
(5, 'Eve', 'IT', 65000);

INSERT INTO second_table VALUES
(1, 'Project A', 'Bangalore'),
(2, 'Project B', 'Hyderabad'),
(3, 'Project C', 'Chennai'),
(6, 'Project D', 'Pune');

select * from first_table;
select * from second_table;


#INNER JOIN
SELECT f.id, f.name, s.project
FROM first_table f
INNER JOIN second_table s
ON f.id = s.id;


#left join
SELECT f.id, f.name, s.project
FROM first_table f
LEFT JOIN second_table s
ON f.id = s.id;

#right join
SELECT f.id, f.name, s.project
FROM first_table f
RIGHT JOIN second_table s
ON f.id = s.id;

#full join or union
SELECT f.id, f.name, s.project
FROM first_table f
LEFT JOIN second_table s ON f.id = s.id

UNION

SELECT f.id, f.name, s.project
FROM first_table f
RIGHT JOIN second_table s ON f.id = s.id;


#window function

#row number
SELECT name, department, salary,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
FROM first_table;

#rank
SELECT name, department, salary,
RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_val
FROM first_table;

#dense rank
SELECT name, department, salary,
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dr
FROM first_table;

#sum over
SELECT name, department, salary,
SUM(salary) OVER (PARTITION BY department) AS total_salary
FROM first_table;

#avg over
SELECT name, department, salary,
AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM first_table;

select version();