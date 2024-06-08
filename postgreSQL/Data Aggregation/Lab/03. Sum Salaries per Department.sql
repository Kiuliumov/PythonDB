-- https://judge.softuni.org/Contests/Practice/Index/4106#2


SELECT department_id, SUM(salary) 
FROM employees 
GROUP BY department_id 
ORDER BY department_id;