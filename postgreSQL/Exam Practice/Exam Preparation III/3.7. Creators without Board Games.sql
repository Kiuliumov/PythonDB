SELECT c.id, CONCAT_WS(' ', c.first_name, c.last_name) as creator_name, c.email 
FROM creators AS c LEFT JOIN creators_board_games as cb ON c.id = cb.creator_id
WHERE cb.board_game_id IS NULL;