CREATE PROCEDURE udp_awarded_production(production_title VARCHAR(70))
LANGUAGE plpgsql AS
$$
    DECLARE
        actor_id INT;

    BEGIN
        FOR actor_id IN (
            SELECT a.id
            FROM actors AS a
                JOIN productions_actors AS pa
                    ON a.id = pa.actor_id
                JOIN productions AS p
                    ON p.id = pa.production_id
            WHERE p.title = production_title
        )
        LOOP

            UPDATE actors
            SET awards = awards + 1
            WHERE id = actor_id;

        END LOOP;

    END;
$$;