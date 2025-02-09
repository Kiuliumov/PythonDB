CREATE FUNCTION fn_difficulty_level(difficulty_level INT)
RETURNS VARCHAR 
AS 
$$ 
    DECLARE
        difficulty_level_ret VARCHAR;
    BEGIN
        IF difficulty_level <= 40 THEN difficulty_level_ret := 'Normal Difficulty';
        ELSIF difficulty_level <= 60 THEN difficulty_level_ret := 'Nightmare Difficulty';
        ELSE difficulty_level_ret := 'Hell Difficulty';
        END IF;

        RETURN difficulty_level_ret;
    END;
$$
LANGUAGE plpgsql;

SELECT user_id, level, cash, fn_difficulty_level(level) AS difficulty_level
FROM users_games
ORDER BY user_id;