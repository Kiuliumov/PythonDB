SELECT b.id, b.name, b.release_year, c.name AS category_name
FROM board_games AS b LEFT JOIN categories AS c ON b.category_id = c.id 
WHERE c.name = 'Strategy Games' OR c.name = 'Wargames'
ORDER BY release_year DESC;