String lesson = """
# 2.0 Where

## Filtering rows with WHERE

The `WHERE` clause is the primary way to filter rows in SQL.

It allows you to specify a condition that the data must meet to be included in the result set. 

For example, `SELECT` firstname `FROM` employees `WHERE` age > 30 filters employees older than 30.

## Combining Conditions with `AND` `AND` OR:

You can combine multiple conditions using logical operators such as `AND` `AND` OR. `AND` requires all conditions to be true for a row to be included, while OR requires any one condition to be true. For example, `SELECT` firstname `FROM` employees `WHERE` age > 30 `AND` department = 'Sales' filters employees who are over 30 `AND` work in Sales.

## Using Comparison Operators:

SQL offers several comparison operators for filtering data, such as =, <>, >, <, >=, `AND` <=. These allow you to filter rows based on relationships between columns `AND` values. For example, `SELECT` firstname `FROM` employees `WHERE` salary >= 50000 retrieves employees with a salary of at least 50,000.

## Pattern Matching with LIKE:

The LIKE operator is useful for filtering string data based on patterns. It uses wildcards (%) to represent any sequence of characters `AND` (_) to represent a single character. For example, `SELECT` firstname `FROM` employees `WHERE` firstname LIKE 'J%' retrieves employees whose firstnames start with 'J'.

## Filtering NULL Values:

When dealing with nullable columns, you can use `IS NULL` or `IS NOT NULL` to filter rows based on whether a column contains a NULL value. For example, `SELECT` firstname `FROM` employees `WHERE` manager_id `IS NULL` retrieves employees who do not have a manager.

# Conclusion

By understanding `AND` using these aspects of filtering in SQL, you can effectively retrieve the data you need based on specific criteria.
""";
