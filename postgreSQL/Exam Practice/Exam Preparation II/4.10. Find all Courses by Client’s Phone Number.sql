CREATE FUNCTION fn_courses_by_client(phone_num VARCHAR(20))
RETURNS INT AS
$$
DECLARE
    number_of_coureses INT;
BEGIN
    SELECT COUNT(id) INTO number_of_coureses
    FROM courses
    WHERE client_id IN (SELECT id FROM clients WHERE phone_number = phone_num);

    RETURN number_of_coureses;
END;
$$

LANGUAGE plpgsql;