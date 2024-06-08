-- https://judge.softuni.org/Contests/Practice/Index/4106#4


SELECT department_id, MIN(salary) as min_salary 
FROM employees 
GROUP BY department_id 
ORDER BY department_id;