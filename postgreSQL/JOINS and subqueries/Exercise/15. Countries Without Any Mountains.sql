-- https://judge.softuni.org/Contests/Compete/Index/4111#13


SELECT COUNT(*) FROM (
	SELECT * FROM countries AS c 
	LEFT JOIN mountains_countries AS mc 
		ON c.country_code = mc.country_code
				WHERE mc.mountain_id IS NULL)
	AS countries_without_mountains;
