-- https://judge.softuni.org/Contests/Practice/Index/4103#15



UPDATE projects
SET end_date = start_date + INTERVAL '5 months'
WHERE end_date IS NULL;