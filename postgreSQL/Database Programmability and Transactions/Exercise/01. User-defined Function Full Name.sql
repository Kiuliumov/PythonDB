CREATE FUNCTION fn_full_name(first_name VARCHAR, last_name VARCHAR)
RETURNS VARCHAR
AS
$$
    DECLARE
        change_first_name VARCHAR(50);
        change_last_name VARCHAR(50);
    BEGIN
        change_first_name := INITCAP(first_name);
        change_last_name := INITCAP(last_name);

        IF first_name IS NULL AND last_name IS NULL
           THEN RETURN NULL;
        ELSIF first_name IS NULL
           THEN RETURN change_last_name;
        ELSIF last_name IS NULL
              THEN RETURN change_first_name;
        ELSE
        RETURN CONCAT(change_first_name, ' ', change_last_name);
        END IF;
    END;
$$
LANGUAGE plpgsql;