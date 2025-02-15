CREATE TABLE brands(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE classifications(
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    address VARCHAR(150) NOT NULL,
    phone VARCHAR(30) NOT NULL UNIQUE,
    loyalty_card BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE items(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    price DECIMAL(12,2) NOT NULL CHECK (price > 0.00),
    description TEXT,
    brand_id INT NOT NULL REFERENCES brands(id) ON UPDATE CASCADE ON DELETE CASCADE,
    classification_id INT NOT NULL REFERENCES classifications(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    customer_id INT NOT NULL REFERENCES customers(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE reviews
(
    customer_id INT           NOT NULL REFERENCES customers (id) ON UPDATE CASCADE ON DELETE CASCADE,
    item_id     INT           NOT NULL REFERENCES items (id) ON UPDATE CASCADE ON DELETE CASCADE,
    created_at  TIMESTAMP     NOT NULL                      DEFAULT NOW(),
    rating      DECIMAL(3, 1) NOT NULL CHECK (rating <= 10.0) DEFAULT 0.0,
    PRIMARY KEY (customer_id, item_id)
);

CREATE TABLE orders_items(
    order_id INT NOT NULL REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(id) ON UPDATE CASCADE ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (order_id, item_id)
);