-- https://judge.softuni.org/Contests/Practice/Index/4102#4


UPDATE employees
SET salary = salary + 100
WHERE job_title = 'Manager';

SELECT * FROM employees
WHERE job_title = 'Manager';
