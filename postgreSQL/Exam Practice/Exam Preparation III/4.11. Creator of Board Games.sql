CREATE OR REPLACE FUNCTION fn_creator_with_board_games(creator_first_name VARCHAR(30))
RETURNS INT
AS 
$$
    DECLARE
        count INT;
    BEGIN
        SELECT COUNT(bg.id) INTO count
            FROM creators AS c
            JOIN creators_board_games AS cb
                ON c.id = cb.creator_id
            JOIN board_games AS bg
                ON bg.id = cb.board_game_id
        WHERE c.first_name = creator_first_name;

        RETURN count;
    END;
$$
LANGUAGE plpgsql;