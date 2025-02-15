SELECT c.id AS customer_id, CONCAT_WS(' ', c.first_name, c.last_name) AS full_name, COUNT(ord.id) AS total_orders,
       CASE
           WHEN c.loyalty_card = TRUE THEN 'Loyal Customer'
           ELSE 'Regular Customer'
       END AS loyalty_status
FROM customers AS c
    JOIN orders AS ord
        ON c.id = ord.customer_id
WHERE NOT (c.id IN (SELECT customer_id FROM reviews))
GROUP BY c.id, c.first_name, c.last_name, c.loyalty_card
ORDER BY COUNT(ord.id) DESC, customer_id 