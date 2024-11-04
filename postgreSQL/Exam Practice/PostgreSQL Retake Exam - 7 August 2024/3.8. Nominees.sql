SELECT 
	c.name AS country_name, 
	COUNT(p.id) AS production_count, 
	COALESCE(AVG(prod_info.budget), 0) AS avg_budget
FROM countries AS c
	JOIN productions AS p
		ON c.id = p.country_id
			JOIN productions_info AS prod_info
				ON prod_info.id = p.production_info_id
GROUP BY c.name
HAVING COUNT(p.id) >= 1
ORDER BY production_count DESC, country_name ASC
