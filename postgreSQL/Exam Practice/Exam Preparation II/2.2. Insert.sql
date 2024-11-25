INSERT INTO clients (full_name, phone_number)
SELECT 
    CONCAT_WS(' ', first_name, last_name), 
    CONCAT('(088) 9999', (d.id * 2)::VARCHAR)
FROM drivers AS d
WHERE d.id BETWEEN 10 AND 20;