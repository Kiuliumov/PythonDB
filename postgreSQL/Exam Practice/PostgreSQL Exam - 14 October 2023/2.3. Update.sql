UPDATE coaches
SET salary =  salary * coach_level
WHERE SUBSTRING(first_name, 1, 1) = 'C'