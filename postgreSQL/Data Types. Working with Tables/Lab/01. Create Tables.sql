CREATE TABLE employees(
id serial PRIMARY KEY not null,
first_name VARCHAR(30),
last_name VARCHAR(50),
hiring_date date default '2023-01-01',
salary numeric (10, 2),
devices_number int
);

CREATE TABLE departments(
id serial PRIMARY KEY not null,
name VARCHAR(50),
code CHAR(3),
description text
);

CREATE TABLE issues(
id serial PRIMARY KEY UNIQUE,
description VARCHAR(150),
"date" date,
start timestamp
);

