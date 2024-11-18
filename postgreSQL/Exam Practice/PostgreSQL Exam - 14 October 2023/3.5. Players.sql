SELECT CONCAT_WS(' ', first_name, last_name) AS full_name, age, hire_date
FROM players
WHERE SUBSTRING(first_name, 1, 1) = 'M'
ORDER BY age DESC, full_name;