-- Drop tables if they exist
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS people;

-- Movies table
CREATE TABLE movies (
    movie_id   SERIAL PRIMARY KEY,
    title      VARCHAR(100) NOT NULL,
    year       INT NOT NULL
);

-- People table
CREATE TABLE people (
    person_id  SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL
);

-- Reviews table
CREATE TABLE reviews (
    review_id  SERIAL PRIMARY KEY,
    movie_id   INT REFERENCES movies(movie_id),
    person_id  INT REFERENCES people(person_id),
    score      NUMERIC(2,1) CHECK (score >= 0 AND score <= 5),
    UNIQUE (movie_id, person_id)
);

-- movies
INSERT INTO movies (title, year) VALUES
    ('Spiderman: Brand New Day', 2026),
    ('The Oddesey', 2026),
    ('Coyote Vs Acme', 2026),
    ('Obesession', 2025),
    ('Disclosure Day', 2025),
    ('Toy Story 5', 2026);
	
-- Insert 5 people
INSERT INTO people (name) VALUES
    ('Me'),
    ('Samantha'),
    ('Ethan'),
    ('Ryan'),
    ('Claire');
	
-- Insert reviews (not every person reviewed every movie -> missing rows = N/A)
INSERT INTO reviews (movie_id, person_id, score) VALUES
    (1, 2, 3),
    (1, 4, 4),
    (1, 5, 5),

    (2, 1, 5),
    (2, 2, 5),
    (2, 3, 4),
	(2, 4, 5),
	(2, 5, 3),

    (3, 1, 3),
    (3, 2, 5),
    (3, 5, 4),

    (4, 1, 4),
    (4, 2, 4),
	(4, 4, 3),
	(4, 5, 5),

    (5, 1, 1),
    (5, 2, 3),
    (5, 3, 3),

    (6, 3, 4),
    (6, 4, 4),
    (6, 5, 5);


SELECT
    p.name,
    m.title,
    COALESCE(r.score::TEXT, 'N/A') AS score
FROM people p
CROSS JOIN movies m
LEFT JOIN reviews r
    ON r.person_id = p.person_id AND r.movie_id = m.movie_id
ORDER BY p.name, m.title;