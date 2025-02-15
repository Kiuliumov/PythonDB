-- https://judge.softuni.org/Contests/Practice/Index/4103#19




CREATE VIEW view_addresses AS
SELECT concat_ws(' ', e.first_name, e.last_name) AS "full_name",
       department_id,
       concat_ws(' ', a.number, a.street)        AS "address"
FROM employees e
         JOIN addresses a on a.id = e.address_id
ORDER BY "address";