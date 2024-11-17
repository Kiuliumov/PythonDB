SELECT CONCAT(o.name, ' - ', a.name), o.phone_number, c.id
FROM owners AS o
	JOIN animals AS a
		ON a.owner_id = o.id
	JOIN animals_cages AS ac
		ON a.id = ac.animal_id
	JOIN animal_types AS at 
		ON a.animal_type_id = at.id
	JOIN cages AS c ON
		ac.cage_id = c.id
WHERE at.animal_type = 'Mammals'
ORDER BY o.name, a.name DESC