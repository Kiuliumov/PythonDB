-- https://judge.softuni.org/Contests/Practice/Index/4103#24



SELECT name,
       start_date
FROM projects
WHERE name LIKE 'MOUNT%'
ORDER BY id;