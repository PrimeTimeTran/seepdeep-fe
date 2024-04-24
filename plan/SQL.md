Database

https://www.sqlitetutorial.net/sqlite-sample-database/

- Select Intro
  Find all

- Select
  Find which Tracks are on the most play lists. Return results in desc order

```sql
SELECT tracks.*, COUNT(playlist_track.trackid) AS times_added
FROM tracks
JOIN playlist_track ON tracks.trackid = playlist_track.trackid
GROUP BY tracks.trackid
ORDER BY times_added DESC;
```

- Join

- Advanced selects

- Subqueries
  Select all managers who have at least 3 direct reports.

```sql
select * from employees where employeeId in (select reportsto from employees group by reportsto having count(*) >2);
```
