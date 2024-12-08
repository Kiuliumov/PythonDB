CREATE PROCEDURE sp_increase_salary_by_id(id INT)
LANGUAGE plpgsql 
AS 
$$
    BEGIN
        UPDATE employees SET salary = salary + salary * 0.05 WHERE employee_id = id;

        IF id IN (SELECT employee_id FROM employees) THEN 
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
    END;
$$;