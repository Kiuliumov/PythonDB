CREATE TABLE countries(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    age INT NOT NULL CHECK (age > 0),
    phone_number CHAR(10) NOT NULL,
    country_id INT NOT NULL REFERENCES countries(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    description VARCHAR(250),
    recipe Text,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0)
);

CREATE TABLE feedbacks(
    id SERIAL PRIMARY KEY,
    description VARCHAR(255),
    rate NUMERIC(4, 2) CHECK (rate >= 0 AND rate <= 10),
    product_id INT NOT NULL REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE,
    customer_id INT NOT NULL REFERENCES customers(id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE distributors(
    id SERIAL PRIMARY KEY,
    name VARCHAR(25) UNIQUE NOT NULL,
    address VARCHAR(30) NOT NULL,
    summary VARCHAR(200) NOT NULL,
    country_id INT NOT NULL REFERENCES countries(id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE ingredients(
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    country_id INT NOT NULL REFERENCES countries(id) ON UPDATE CASCADE ON DELETE CASCADE,
    distributor_id INT NOT NULL REFERENCES distributors(id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE products_ingredients(
    product_id INT REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE,
    ingredient_id INT REFERENCES ingredients(id) ON UPDATE CASCADE ON DELETE CASCADE
);