-- https://judge.softuni.org/Contests/Practice/Index/4102#0

SELECT id, 
       CONCAT(first_name, ' ', last_name) AS Full_Name, 
       job_title AS Job_Title 
FROM employees;
