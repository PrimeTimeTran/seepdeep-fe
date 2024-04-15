Database

https://www.sqlitetutorial.net/sqlite-sample-database/

- Select
  All customers

- Join

- Advanced selects

- Subqueries
  Select all managers who have at least 3 direct reports.

```sql
select * from employees where employeeId in (select reportsto from employees group by reportsto having count(*) >2);
```
