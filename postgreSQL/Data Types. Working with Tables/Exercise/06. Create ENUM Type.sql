-- https://judge.softuni.org/Contests/Practice/Index/4101#5

CREATE TYPE type_mood AS ENUM ('happy', 'relaxed', 'stressed', 'sad');

ALTER TABLE minions_info
ADD COLUMN mood type_mood;