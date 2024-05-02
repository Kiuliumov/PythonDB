-- https://judge.softuni.org/Contests/Practice/Index/4102#2



SELECT *
FROM employees 
WHERE salary >= 1000.00  AND department_id = 4
ORDER BY id;