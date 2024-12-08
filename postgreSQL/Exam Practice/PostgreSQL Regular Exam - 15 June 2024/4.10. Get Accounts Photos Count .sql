CREATE FUNCTION udf_accounts_photos_count(account_username VARCHAR(30))
RETURNS INT AS
    $$
        DECLARE
            photo_count INT;
        BEGIN
             SELECT COUNT(ap.photo_id) INTO photo_count
             FROM accounts AS a
                JOIN accounts_photos AS ap
                    ON a.id = ap.account_id
             WHERE a.username = account_username;

            RETURN photo_count;
        END;
    $$
LANGUAGE plpgsql;