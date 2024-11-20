CREATE FUNCTION fn_get_volunteers_count_from_department(searched_volunteers_department VARCHAR(30))
RETURNS INT
AS $$
    DECLARE
    count_of_volunteers INT;
    BEGIN
        SELECT COUNT(*) INTO count_of_volunteers 
        FROM volunteers AS v
            JOIN volunteers_departments AS vd ON 
                v.department_id = vd.id
        WHERE vd.department_name = searched_volunteers_department;

        RETURN count_of_volunteers;
    END;
$$
language plpgsql;