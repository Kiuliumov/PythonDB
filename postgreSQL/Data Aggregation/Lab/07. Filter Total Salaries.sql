-- https://judge.softuni.org/Contests/Practice/Index/4106#6



SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) < 4200
ORDER BY department_id;