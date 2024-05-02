-- https://judge.softuni.org/Contests/Practice/Index/4109#11



SELECT COUNT(*) AS countries_without_rivers
FROM countries as c 
LEFT JOIN 
countries_rivers as cr 
ON cr.country_code = c.country_code
WHERE cr.country_code IS NULL;