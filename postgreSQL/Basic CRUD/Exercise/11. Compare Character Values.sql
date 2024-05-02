-- https://judge.softuni.org/Contests/Practice/Index/4103#10



SELECT name, start_date 
FROM projects
WHERE name in ('Mountain', 'Road', 'Touring')
LIMIT 20;