-- https://judge.softuni.org/Contests/Practice/Index/4108#2



SELECT start_point, end_point, c.id AS leader_id , CONCAT(first_name, ' ', last_name) AS leader_name
FROM routes as r JOIN campers as C ON r.leader_id = c.id;

