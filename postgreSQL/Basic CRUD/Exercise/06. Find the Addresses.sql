-- https://judge.softuni.org/Contests/Practice/Index/4103#5



SELECT id,
CONCAT(number , ' ', street) as addresses,
city_id
FROM addresses
WHERE id >= 20;