-- https://judge.softuni.org/Contests/Practice/Index/4100#2

ALTER TABLE employees
ALTER COLUMN salary SET NOT NULL, 
ALTER COLUMN salary SET DEFAULT 0,
ALTER COLUMN hiring_date SET NOT NULL;