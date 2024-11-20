SELECT a.name AS animal, EXTRACT(YEAR FROM a.birthdate) AS birth_year, at.animal_type
FROM animals AS a 
    JOIN animal_types AS at ON
        a.animal_type_id = at.id
WHERE a.owner_id IS NULL AND at.animal_type != 'Birds' AND birthdate > '01-01-2017'
ORDER BY animal;