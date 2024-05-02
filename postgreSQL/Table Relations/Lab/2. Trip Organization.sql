-- https://judge.softuni.org/Contests/Practice/Index/4108#1



SELECT driver_id, vehicle_type,
CONCAT(first_name, ' ', last_name) as full_name
FROM vehicles AS v
JOIN campers AS c ON v.driver_id = c.id;