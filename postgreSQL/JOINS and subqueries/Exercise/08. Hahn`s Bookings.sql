-- https://judge.softuni.org/Contests/Compete/Index/4111#6


SELECT COUNT(*) FROM bookings JOIN customers USING(customer_id) WHERE customers.last_name = 'Hahn'