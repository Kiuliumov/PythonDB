SELECT c.id AS car_id, c.make, c.mileage, COUNT(crs.id) AS count_of_courses, CAST(AVG(crs.bill) AS DECIMAL(10, 2)) AS average_bill
FROM cars AS c 
    LEFT JOIN courses AS crs 
        ON crs.car_id = c.id
GROUP BY c.id, c.make, c.mileage
HAVING COUNT(crs.id) != 2
ORDER BY count_of_courses DESC, car_id;