SELECT CONCAT(LEFT(description, 10), '...'), TO_CHAR(capture_date, 'DD.MM HH24:MI' ) AS date
FROM photos
WHERE TO_CHAR(capture_date, 'DD.MM') LIKE '10%'
ORDER BY capture_date DESC;