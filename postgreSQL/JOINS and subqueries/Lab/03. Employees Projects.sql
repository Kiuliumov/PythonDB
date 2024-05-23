-- https://judge.softuni.org/Contests/Practice/Index/4110#2


SELECT e.employee_id,
	CONCAT_WS(' ', e.first_name, e.last_name) as full_name,
	p.project_id,
	p.name as project_name
FROM employees as e
	JOIN employees_projects as ep ON e.employee_id = ep.employee_id
	JOIN projects as p ON ep.project_id = p.project_id
WHERE ep.project_id = 1;