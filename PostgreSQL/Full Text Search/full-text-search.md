# PostgreSQL Full-Text Search

## Topics

- [Introduction](#introduction)
- [Importing Data](#importing-data)
- [Vectors](#vectors)
- [Full-Text Queries](#full-text-query)
- [Ranking](#ranking)

<a name="introduction"></a>

## Introduction

I've been working with ElasticSearch for a short while at work. It can do some amazing things but it has its limitations. In particular, as a NoSQL (document) database, there are difficulties when it comes to working with multiple document types that relate to each other.

If you've got two entities, and you want to filter on the relationship between both of them, you'll quickly run into issues. There's no way to do proper joins in a non-relational database. You end up having to copy data from one entity to the other as a nested object to be able to apply filtering. This is where the power of the relational database comes in. The relational model excels at, well, relationships between entities. Hence its name!

ElasticSearch provides powerful full-text search capabilities, but it lacks relational filtering capabilities. PostgreSQL, however, does both of these functions. In most cases, PostgreSQL's full-text search is probably good enough for what most people need. We'll examine how to combine filtering on relations and full-text search.

<a name="importing-data"></a>

## Importing Data

First, we'll need some data. You can download a SQL file that will set up your PostgreSQL instance with all the data you need for this exercise:

- [authors.json](authors.json)
- [books.json](books.json)
- [load_data.sql](load_data.sql)

Download those files then run the `load_data.sql` file:

```shell
psql -f load_data.sql
```

<a name="vectors"></a>

## Vectors

<a name="full-text-query"></a>

## Full-Text Queries

<a name="ranking"></a>

## Ranking

```sql
SELECT
  id,
  title,
  first_name,
  last_name
FROM
  (
    SELECT
      books.id,
      books.title,
      authors.first_name,
      authors.last_name,
      ts_rank(to_tsvector(title), to_tsquery('hunger')) AS rank
    FROM books
    LEFT JOIN authors on authors.id = books.author_id
  ) ranked_books
  WHERE rank > 0
  ORDER BY rank desc;
```
