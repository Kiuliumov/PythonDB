-- https://judge.softuni.org/Contests/Compete/Index/4111#10



SELECT country_code, COUNT(DISTINCT mountain_range) as mountain_range_count 
FROM mountains_countries as mc
	JOIN mountains as m ON m.id = mc.mountain_id
GROUP BY country_code
HAVING country_code IN('BG', 'RU', 'US')
ORDER BY mountain_range_count DESC;