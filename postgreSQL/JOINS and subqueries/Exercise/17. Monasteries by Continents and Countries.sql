-- https://judge.softuni.org/Contests/Compete/Index/4111#15


UPDATE countries SET country_name = 'Burma' WHERE country_name = 'Myanmar';


INSERT INTO monasteries (monastery_name, country_code)
VALUES ('Hanga Abbey', (SELECT country_code FROM countries WHERE country_name = 'Tanzania')),
       ('Myin-Tin-Daik', (SELECT country_code FROM countries WHERE country_name = 'Myanmar'));
SELECT 
    ct.continent_name, 
    c.country_name, 
    COUNT(m.id) AS monasteries_count
FROM 
    countries AS c 
LEFT JOIN continents AS ct 
    ON c.continent_code = ct.continent_code
LEFT JOIN monasteries AS m 
    ON c.country_code = m.country_code
WHERE NOT three_rivers
GROUP BY 
   c.country_name,
   continent_name
ORDER BY 
    monasteries_count DESC, 
    c.country_name;
