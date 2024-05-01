-- https://judge.softuni.org/Contests/Practice/Index/4101#2

ALTER TABLE minions_info
ADD COLUMN code char(4),
ADD COLUMN task text,
ADD COLUMN salary numeric (8, 3);
