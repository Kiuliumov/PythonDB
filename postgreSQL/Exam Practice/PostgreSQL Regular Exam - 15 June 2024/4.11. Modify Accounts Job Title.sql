 CREATE PROCEDURE udp_modify_account(address_street VARCHAR(30), address_town VARCHAR(30))
 LANGUAGE plpgsql
 AS
 $$
    BEGIN
        UPDATE accounts SET job_title = CONCAT('(Remote) ', job_title)
        WHERE id = (SELECT account_id FROM addresses WHERE street = address_street AND town = address_town);
    END;
 $$;