# SQL Lesson 1: SELECT queries 101

To retrieve data from a SQL database, we write SELECT statements, which are often referred to as **queries**.

A query in itself is a statement which declares what data we're looking for, where to find it in the database, and optionally, how to transform it before it is returned.

It has a specific syntax though, which is what we are going to learn in the following exercises.

It's helpful to think of a table in SQL as a specific type of entity. Each row is an instance of that entity. The columns would then represent properties of an entity.

For example on the right we have the table `Movies`. Each movie has the same properties, `title`, `director`, `year` etc, but their properties have different values, `Toy Story`, `A Bug's Life`, etc.

The syntax for selecting data from our table follows:

```sql
SELECT column, another_column, …
FROM mytable;
```

So if we wanted to select the title of all our movies in our database we would write

```sql
SELECT title
FROM movies;
```
