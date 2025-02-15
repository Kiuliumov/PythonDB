SELECT i.name, CONCAT(UPPER(b.name), '/', LOWER(c.name)) AS promotion, CONCAT('On sale: ', COALESCE(i.description, '')) AS description, i.quantity
FROM items AS i
    LEFT JOIN orders_items AS ord_i
        ON i.id = ord_i.item_id
    JOIN classifications AS c
        ON i.classification_id = c.id
    JOIN brands AS b
        ON b.id = i.brand_id
WHERE ord_i.order_id IS NULL
ORDER BY quantity DESC, name