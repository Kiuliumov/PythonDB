CREATE TABLE search_results(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    release_year INT,
    rating FLOAT,
    category_name VARCHAR(50),
    publisher_name VARCHAR(50),
    min_players VARCHAR(50),
    max_players VARCHAR(50)
);


CREATE PROCEDURE usp_search_by_category(category VARCHAR(50))
LANGUAGE plpgsql AS
$$
    BEGIN
        INSERT INTO search_results(name, release_year, rating, category_name,
                                   publisher_name, min_players, max_players)
        SELECT
             bg.name,
             bg.release_year,
             bg.rating,
             c.name,
             p.name,
             CONCAT(prange.min_players::VARCHAR, ' people'),
             CONCAT(prange.max_players::VARCHAR, ' people')
        FROM
            board_games AS bg
                JOIN categories AS c
                    ON c.id = bg.category_id
                JOIN players_ranges AS prange ON
                    prange.id = bg.players_range_id
                JOIN publishers AS p ON
                    p.id = bg.publisher_id
        WHERE c.name = category
        ORDER BY p.name, release_year DESC;
    END;
$$;