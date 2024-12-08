CREATE PROCEDURE sp_increase_salaries(department_name VARCHAR(45))
LANGUAGE plpgsql
AS 
$$
    BEGIN
        UPDATE employees
        SET salary = salary + salary * 0.05
        WHERE department_id IN (SELECT department_id FROM departments WHERE name = department_name);
    END;
$$;