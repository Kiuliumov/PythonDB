CREATE FUNCTION udf_category_productions_count(category_name VARCHAR(50))
RETURNS VARCHAR
AS
$$
    DECLARE
        return_string VARCHAR(20);
    BEGIN
        SELECT CONCAT('Found ', COUNT(p.production_id)::VARCHAR, ' productions.') INTO return_string
        FROM
            categories AS c
                LEFT JOIN categories_productions AS p ON c.id = p.category_id
        WHERE c.name = category_name;

        RETURN return_string;
    END;
$$
LANGUAGE plpgsql;
