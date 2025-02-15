SELECT i.name AS item_name, ROUND(AVG(r.rating), 2) AS average_rating, COUNT(r.rating) total_reviews, b.name, c.name
FROM items AS i
    JOIN reviews AS r
        ON i.id = r.item_id
    JOIN brands AS b
        ON i.brand_id = b.id
    JOIN classifications AS c
        ON i.classification_id = c.id
GROUP BY i.name, b.name, c.name
HAVING COUNT(r.rating) >= 3
ORDER BY AVG(r.rating) DESC,i.name
LIMIT 3;