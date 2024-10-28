SELECT CONCAT_WS(' ', c.first_name, c.last_name) AS full_name, c.email, MAX(bg.rating) AS rating
FROM creators as c
	JOIN creators_board_games AS cb
		ON c.id = cb.creator_id
			JOIN board_games as bg 
				ON cb.board_game_id = bg.id
WHERE email LIKE ('%.com')					
GROUP BY full_name, c.email
ORDER BY full_name;