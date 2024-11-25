SELECT c.full_name, COUNT(DISTINCT crs.car_id) AS count_of_cars, SUM(COALESCE (crs.bill, 0)) AS total_sum
FROM clients AS c
    JOIN courses AS crs
        ON c.id = crs.client_id
WHERE SUBSTRING(c.full_name, 2, 1) = 'a'
GROUP BY c.id, c.full_name
HAVING COUNT(DISTINCT crs.car_id) > 1
ORDER BY full_name;
