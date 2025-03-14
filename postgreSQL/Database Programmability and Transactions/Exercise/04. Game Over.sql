CREATE FUNCTION fn_is_game_over(is_game_over BOOLEAN)
RETURNS TABLE(name VARCHAR(50), game_type_id INT, is_finished BOOLEAN) AS
$$
    BEGIN
        RETURN QUERY 
            SELECT g.name AS name, g.game_type_id AS game_type, g.is_finished AS is_finished FROM games AS g WHERE g.is_finished = is_game_over;
    END; 
$$
LANGUAGE plpgsql;