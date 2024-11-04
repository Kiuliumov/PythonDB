SELECT 
	CONCAT(a.first_name, ' ', a.last_name) AS full_name,
	CONCAT(
		LOWER(SUBSTRING(a.first_name, 1, 1)), 
		SUBSTRING(a.last_name, LENGTH(last_name) - 1, 2),
		LENGTH(last_name),
		'@sm-cast.com') AS email,
	awards
FROM actors AS a
	LEFT JOIN productions_actors AS prod_actors
		ON a.id = prod_actors.actor_id
WHERE prod_actors.production_id IS NULL
ORDER BY awards DESC, id ASC



