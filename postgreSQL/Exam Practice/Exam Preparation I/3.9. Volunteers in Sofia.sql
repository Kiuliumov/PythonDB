SELECT name AS volunteers, phone_number, SUBSTRING(address, POSITION('Sofia' IN address) + 7) AS address
FROM volunteers AS v
    JOIN volunteers_departments AS vd
        ON v.department_id = vd.id
WHERE 
department_name = 'Education program assistant'
AND address LIKE '%Sofia%'
ORDER BY volunteers;