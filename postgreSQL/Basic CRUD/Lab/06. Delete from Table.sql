-- https://judge.softuni.org/Contests/Practice/Index/4102#5



DELETE FROM employees 
WHERE department_id = 1 
OR 
department_id = 2;

SELECT id,
first_name,
last_name,
job_title,
department_id,
salary 
FROM employees;