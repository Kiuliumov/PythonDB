CREATE PROCEDURE sp_animals_with_owners_or_not(IN animal_name VARCHAR(30), OUT return_value VARCHAR(50))
language plpgsql
AS $$
    BEGIN
        SELECT 
        CASE
            WHEN o.name IS NULL THEN 'For adoption'
            ELSE o.name
        END  
        INTO return_value 
        FROM owners AS o
            RIGHT JOIN animals AS a
                On o.id = a.owner_id
        WHERE a.name = animal_name;
    END;
$$;