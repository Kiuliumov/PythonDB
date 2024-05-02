--https://judge.softuni.org/Contests/Practice/Index/4103#6



SELECT CONCAT(number, ' ', street) as addresses,
city_id
FROM addresses
WHERE city_id > 0 and city_id % 2 = 0
ORDER by city_id;
