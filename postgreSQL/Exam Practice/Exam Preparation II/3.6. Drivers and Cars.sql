SELECT d.first_name, d.last_name, c.make, c.model, c.mileage
FROM drivers AS d
    JOIN cars_drivers AS cd
        ON cd.driver_id = d.id
    JOIN cars AS c 
        ON c.id = cd.car_id
WHERE NOT (mileage IS NULL)
ORDER BY mileage DESC, first_name;
