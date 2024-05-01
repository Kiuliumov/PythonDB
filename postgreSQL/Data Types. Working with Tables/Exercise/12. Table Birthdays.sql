-- https://judge.softuni.org/Contests/Practice/Index/4101#11



CREATE TABLE minions_birthdays (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    age INTEGER NOT NULL DEFAULT 0,
    present VARCHAR(100),
    party TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);