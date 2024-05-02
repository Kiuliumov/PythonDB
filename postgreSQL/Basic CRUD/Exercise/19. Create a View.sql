-- https://judge.softuni.org/Contests/Practice/Index/4103#18



CREATE VIEW view_company_chart AS 
SELECT "Full Name", "Job Title"
FROM company_chart
WHERE manager_id = 184;