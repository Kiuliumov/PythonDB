-- https://judge.softuni.org/Contests/Practice/Index/4110#3


SELECT COUNT(*) 
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);