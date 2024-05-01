-- https://judge.softuni.org/Contests/Practice/Index/4101#7

ALTER TABLE minions_info
ADD CONSTRAINT unique_content UNIQUE (id, email),
ADD CONSTRAINT banana_check CHECK (banana > 0);