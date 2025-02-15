CREATE OR REPLACE PROCEDURE udp_update_loyalty_status(min_orders INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE customers
    SET loyalty_card = TRUE
    WHERE id IN (
        SELECT customer_id
        FROM orders
        GROUP BY customer_id
        HAVING COUNT(id) >= min_orders
    );
END;
$$;
