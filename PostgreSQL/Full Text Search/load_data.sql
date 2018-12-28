DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
  id          SERIAL PRIMARY KEY,
  first_name  TEXT   NOT NULL,
  last_name   TEXT   NOT NULL,
  birth_year  INT
);

CREATE TABLE books (
   id        SERIAL PRIMARY KEY,
   title     TEXT NOT NULL,
   author_id INT  NOT NULL references authors(id) 
);


INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (1,  'George',    'Orwell',     1903);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (2,  'Jane',      'Austen',     1775);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (3,  'Dan',       'Brown',      1964);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (4,  'Harper',    'Lee',        1926);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (5,  'J. D.',     'Salinger',   1919);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (6,  'F. Scott',  'Fitzgerald', 1896);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (7,  'Stephenie', 'Meyer',      1973);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (8,  'Suzanne',   'Collins',    1962);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (9,  'Khaled',    'Hosseini',   1965);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (10, 'Charlotte', 'Brontë',     1816);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (11, 'George',    'Orwell',     1903);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (12, 'Aldous',    'Huxley',     1894);
INSERT INTO authors (id, first_name, last_name, birth_year) VALUES (13, 'J. R. R.',  'Tolkien',    1916);

INSERT INTO books (id, title, author_id) VALUES (1,  '1984',                   1);
INSERT INTO books (id, title, author_id) VALUES (2,  'Pride and Prejudice',    2);
INSERT INTO books (id, title, author_id) VALUES (3,  'The Da Vinci Code',      3);
INSERT INTO books (id, title, author_id) VALUES (4,  'To Kill a Mockingbird',  4);
INSERT INTO books (id, title, author_id) VALUES (5,  'The Catcher in the Rye', 5);
INSERT INTO books (id, title, author_id) VALUES (6,  'The Great Gatsby',       6);
INSERT INTO books (id, title, author_id) VALUES (7,  'Twilight',               7);
INSERT INTO books (id, title, author_id) VALUES (8,  'The Hunger Games',       8);
INSERT INTO books (id, title, author_id) VALUES (9,  'Kite Runner',            9);
INSERT INTO books (id, title, author_id) VALUES (10, 'Jane Eyre',             10);
INSERT INTO books (id, title, author_id) VALUES (11, 'Animal Farm',           11);
INSERT INTO books (id, title, author_id) VALUES (12, 'Brave New World',       12);
INSERT INTO books (id, title, author_id) VALUES (13, 'The Lord of the Rings', 13);
