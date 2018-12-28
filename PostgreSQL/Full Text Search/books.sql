DROP DATABASE IF EXISTS books;
CREATE DATABASE books;

\c books

CREATE TEMPORARY TABLE temp_authors (
  data JSONB
);

COPY temp_authors (data) FROM '/Users/mattmoore/authors.json';

DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
    id           BIGSERIAL PRIMARY KEY
  , first_name   VARCHAR
  , last_name    VARCHAR
);

INSERT INTO authors (id, first_name, last_name)
SELECT
  (data->>'id')::INT,
  data->>'first_name',
  data->>'last_name'
FROM temp_authors;

CREATE TEMPORARY TABLE temp_books (
  data JSONB
);

COPY temp_books (data) from '/Users/mattmoore/books.json';

DROP TABLE IF EXISTS books;
CREATE TABLE books (
    id        BIGSERIAL PRIMARY KEY
  , title     VARCHAR
  , author_id INT
);

INSERT INTO books (id, title, author_id)
SELECT
  (data->>'id')::INT,
  data->>'title',
  (data->>'author_id')::INT
FROM temp_books;
