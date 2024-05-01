-- https://judge.softuni.org/Contests/Practice/Index/4101#4

ALTER TABLE minions_info
ADD COLUMN email VARCHAR(20),
ADD COLUMN equipped BOOLEAN NOT NULL DEFAULT FALSE;