CREATE TABLE countries(
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL UNIQUE, 
    continent VARCHAR(40) NOT NULL,
    currency VARCHAR(5)
);

CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE actors(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    height INT,
    awards INT NOT NULL DEFAULT 0 CHECK (awards >= 0),
    country_id INT 
        NOT NULL
            REFERENCES countries(id)
                ON DELETE CASCADE
                ON UPDATE CASCADE
);

CREATE TABLE productions_info(
    id SERIAL PRIMARY KEY,
    rating DECIMAL(4, 2) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0),
    budget DECIMAL(10, 2),
    release_date DATE NOT NULL,
    has_subtitles BOOLEAN NOT NULL DEFAULT FALSE,
    synopsis TEXT
);

CREATE TABLE productions(
    id SERIAL PRIMARY KEY,
    title VARCHAR(70) NOT NULL UNIQUE,
    country_id INT 
        NOT NULL 
            REFERENCES countries(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    production_info_id INT 
        NOT NULL UNIQUE 
            REFERENCES productions_info(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE productions_actors(
    production_id INT 
    NOT NULL 
        REFERENCES productions(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    actor_id INT
        NOT NULL
            REFERENCES actors(id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    
    PRIMARY KEY (production_id, actor_id)
);

CREATE TABLE categories_productions(
    category_id INT 
        NOT NULL
            REFERENCES categories(id)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
    
    production_id INT 
        NOT NULL
            REFERENCES productions(id)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
    
    PRIMARY KEY (category_id, production_id)
);