-- https://judge.softuni.org/Contests/Compete/Index/4111#3


SELECT b.booking_id, a.name AS apartment_owner,
a.apartment_id, CONCAT_WS(' ', c.first_name, c.last_name) AS customer_name
FROM bookings AS b 
	FULL JOIN apartments AS a USING(booking_id) 
	FULL JOIN customers AS c USING(customer_id)
ORDER BY booking_id, apartment_owner, customer_name ASC;
