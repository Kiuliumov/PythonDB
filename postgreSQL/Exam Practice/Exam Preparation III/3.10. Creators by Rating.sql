SELECT c.last_name, CEIL(AVG(b.rating)) AS average_rating, p.name AS publisher_name
FROM creators AS c 
	JOIN creators_board_games AS cb ON c.id = cb.creator_id
	JOIN board_games AS b ON b.id = cb.board_game_id
	JOIN publishers AS p ON p.id = b.publisher_id
WHERE p.name = 'Stonemaier Games'
GROUP BY c.last_name, p.name
ORDER BY average_rating DESC;
