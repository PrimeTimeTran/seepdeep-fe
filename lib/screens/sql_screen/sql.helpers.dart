import 'package:app/all.dart';
import 'package:flutter/services.dart';

// select id, title, worldwide_gross from films order by worldwide_gross desc limit 25

// How to use union to compare the results of two queries;
const query = """
WITH NumberedRows AS (
    SELECT 
        id, 
        title, 
        worldwide_gross, 
        (SELECT COUNT(*) FROM films AS f2 WHERE f2.worldwide_gross >= f1.worldwide_gross) AS row_num
    FROM films AS f1
    ORDER BY worldwide_gross DESC
    LIMIT 25
)
SELECT 
    row_num,
    id,
    title,
    worldwide_gross 
FROM NumberedRows
UNION
WITH NumberedFilms AS (
    SELECT 
        id, 
        title, 
        worldwide_gross, 
        ROW_NUMBER() OVER (ORDER BY id) AS row_num
    FROM films
)
SELECT 
    row_num,
    id,
    title,
    worldwide_gross
FROM NumberedFilms
WHERE row_num <= 25;
""";

final lessonPromptMap = {
  '0.toc.md': [
    makePrompt(queryPrompt: 'Read Instructions'),
    makePrompt(queryPrompt: 'Checkout Tasks'),
    makePrompt(queryPrompt: 'Checkout Table(default query of Films table)'),
    makePrompt(queryPrompt: 'Select 10 films instead of 7'),
  ],
  '1.insert.md': [
    makePrompt(
      queryPrompt: 'Add a film to the films table',
      queryPromptFollowup: 'What fields should you consider adding?',
      answer: """

""",
    ),
    makePrompt(
      queryPrompt: 'Add an employee to the employees table',
      queryPromptFollowup:
          'What fields does it make sense for employees to have?',
      answer: """

""",
    ),
    makePrompt(
      queryPrompt:
          'Add another employee with name & surname fields to the employees table',
      answer: """

""",
    ),
  ],
  '2.select.md': [
    makePrompt(
      queryPrompt: 'Select titles of the records(films) from the films table.',
      answer: 'SELECT title from films;',
    ),
    makePrompt(
      queryPrompt:
          'Select titles of the records in the films table but limit the results to 25 records only.',
      answer: 'SELECT title FROM films LIMIT 25;',
      hint:
          'When we want to grab a subset of our data we can think of it as LIMITing our results.',
    ),
    makePrompt(
      queryPrompt:
          'Select titles, runtime, & release_year of the records from the films table.',
      answer: 'SELECT title, runtime, year FROM films;',
      hint:
          'Remember that when searching for data we\'re SELECTing it FROM a table. Also remember to LIMIT the results so your system doesn\'t slow down.',
    ),
    makePrompt(
      queryPrompt: 'Select name & surname from the employees table.',
      answer: 'SELECT name, surname FROM employees;',
      hint:
          'Grabbing data FROM the employees table is just like SELECTing from the films table, we just have to change a few arguments to our expressions.',
    ),
  ],
  '3.update.md': [
    makePrompt(
      queryPrompt:
          'The employee record with the id of 1, change it to have your data/information.',
      answer: """

""",
    ),
    makePrompt(
      queryPrompt:
          'Update all employees with an id greater than 1 to report to 1.',
      answer: """

""",
    ),
    makePrompt(
      queryPrompt:
          'Update the film with the id of 1 to your favorite film\'s information. Update all fields',
      answer: """

""",
    ),
  ],
  '4.delete.md': [
    makePrompt(
      queryPrompt:
          'After reviewing the films table, pick one you dont like and delete it.',
      answer: """

""",
    ),
    makePrompt(
      queryPrompt:
          'Find an employee from a city you\'ve never heard of in the employees table & delete that record from the db.',
      answer: """

""",
    ),
  ],
  '5.where.md': [
    makePrompt(
      queryPrompt:
          'Select id, title, worldwide_gross from films that have at least 1billion in worldwide_gross.',
      answer: """
SELECT id, title, worldwide_gross 
FROM films 
WHERE worldwide_gross >= 1000
""",
      hint:
          'The WHERE keyword is used to filter results for results we want to keep.',
    ),
    makePrompt(
      queryPrompt:
          'Select id, year, title, oscars_nominated from films that have been nominated for 5 or more Oscars.',
      answer: """
SELECT id, year, title, oscars_nominated
FROM films
WHERE oscars_nominated >= 5
""",
      hint: 'The films table has a column named oscars_nominated.',
    ),
    makePrompt(
      queryPrompt:
          'Select id, year, title, oscars_nominated, oscars_won, from films that have won 3 or more Oscars.',
      answer: """
SELECT id, year, title, oscars_nominated, oscars_won
FROM films
WHERE oscars_won >= 3
""",
      hint: 'The films table has a column named oscars_won.',
    ),
  ],
  '6.orderby.md': [
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, title, worldwide_gross from films order by worldwide in desc order. limit to 25 results',
      answer: """
SELECT id,
       title,
       worldwide_gross
FROM   films
ORDER  BY worldwide_gross DESC
LIMIT  5; 
""",
      hint:
          'With the keywords ORDER BY we can change the sequence of our results.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, name, surname, birth_date, age from employees ordered by age from youngest to oldest.',
      answer: """
SELECT id, name, surname, birth_date, age FROM employees ORDER BY age ASC;
""",
      hint: 'ORDER BY sorts in ascending order by default.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, name, surname, birth_date & age from employees ordered by age from oldest to youngest.',
      answer: """
SELECT id, name, surname, birth_date, age FROM employees ORDER BY age DESC;
""",
      hint: 'Try ORDER BY with the age column first.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, name, surname, birth_date & age from employees ordered by age from oldest to youngest. Then order by their ids in DESC order for each age subgroup.',
      answer: """
SELECT id, name, surname, birth_date, age FROM employees ORDER BY age DESC, id DESC;
""",
      hint:
          'We can ORDER BY on multiple columns just like we can SELECT multiple columns.',
    ),
    makePrompt(
      queryPrompt:
          'Select id, name, surname & salary from the top 25 highest paid employees',
      answer: """
SELECT id, name, surname, salary FROM employees ORDER BY salary DESC LIMIT 25;
""",
      hint:
          'If we\'re looking for the highest paid, should we ORDER BY ascending or descending?',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select the id, year, title & worldwide_gross of the top 50 highest grossing worldwide films of all time.',
      answer: """
SELECT id,
       year,
       title,
       worldwide_gross
FROM   films
ORDER  BY worldwide_gross DESC
LIMIT  50;
""",
      hint: 'We can place a LIMIT on our results.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, title, name & age from employees and group by title alphabetically.',
      answer: """
SELECT id, title, name, age
FROM employees
ORDER BY title;
""",
      hint: 'Is A-Z in alphabetical order or Z-A?',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, title, name & age from employees and group by title alphabetically then age oldest to youngest.',
      answer: """
SELECT id, title, name, age
FROM employees
ORDER BY title, age DESC;
""",
      hint:
          'We\'ve seen one similar to this. We just need to recall a previous query.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, year, title, oscars_nominated, oscars_won from the top 50 films by oscars nominated.',
      answer: """
SELECT id, year, title, oscars_nominated, oscars_won
FROM films 
ORDER BY oscars_nominated DESC
LIMIT 50;
""",
      hint:
          'This one is similar to a previous step. We just need to LIMIT our results.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, year, title, oscars_nominated & oscars_won from the top 50 films by oscars nominated.',
      answer: """
SELECT year, title, oscars_nominated, oscars_won 
FROM films 
ORDER BY oscars_nominated DESC
LIMIT 50;
""",
      hint: 'How might we LIMIT and ORDER BY columns in our query?',
    ),
    makePrompt(
      ordered: true,
      queryPrompt:
          'Select id, year, title, oscars_nominated & oscars_won from the top 50 films. Order by oscars_won & subsequently oscars_nominated.',
      answer: """
SELECT year, title, oscars_nominated, oscars_won 
FROM films 
ORDER BY oscars_won DESC, oscars_nominated DESC
LIMIT 50;
""",
      hint: 'How might we LIMIT and ORDER BY columns in our query?',
    ),
  ],
  '7.groupby.md': [
    makePrompt(
      queryPrompt:
          'List the number of employees from each state. Include the name of the state and the count.',
      answer: """
SELECT state,
       Count(*)
FROM   employees
GROUP  BY state; 
""",
      hint: 'We want to group records on their state column value.',
    ),
    makePrompt(
      queryPrompt:
          'List the number of films that have won at least 1 oscar. List the number they won as well.',
      answer: """
SELECT Count(*) AS oscar_winners,
       oscars_won
FROM   films
WHERE  oscars_won >= 1
GROUP  BY oscars_won; 
""",
      hint: 'Having more than 1 oscar could mean having 2... or 3... etc.',
    ),
  ],
  '8.having.md': [
    {'queryPrompt': 'Having'},
    makePrompt(
      queryPrompt: """
Select film titles that have been used more than once. Return the title and number of times it's been used as a title_use_count.
""",
      answer: """
SELECT title,
       Count(*) AS title_use_count
FROM   films
GROUP  BY title
HAVING Count(*) > 1; 
""",
      hint: 'Filtering aggregates of records requires a HAVING clause.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt: """
Select the film's id, title & year from films that have been used more than once. Order the title's names alphabetically.
""",
      answer: """
SELECT id,
       title,
       year
FROM   films
WHERE  title IN (SELECT title
                 FROM   films
                 GROUP  BY title
                 HAVING Count(*) > 1)
ORDER  BY title; 
""",
      hint: 'We can use ORDER BY with HAVING as well.',
    ),
  ],
  '9.aggregate.md': [
    {'queryPrompt': 'Aggregate'},
  ],
  '10.join.md': [
    makePrompt(
      queryPrompt:
          """Select employees id, name, surname and their department's name from all the employees""",
      answer: """
SELECT employees.id, employees.name, surname, departments.name as department_name
FROM employees
JOIN departments
ON employees.department_id = departments.id;
""",
      hint: 'We need to combine the results of multiple tables for this one.',
    ),
    makePrompt(
      queryPrompt:
          """Select employees id, name, surname and their department's name of all the employees. Rename the employee's id to employee_id, employees name to employee_name, employees surname to employee_surname and department's name to department_name""",
      answer: """
SELECT employees.id employee_id, employees.name employee_name, surname employee_surname, departments.name department_name
FROM employees
JOIN departments
ON employees.department_id = departments.id
""",
      hint: 'We need to combine the results of multiple tables for this one.',
    ),
    makePrompt(
      queryPrompt:
          """Select the film's title & studio's name from the films & studios tables.""",
      answer: """
SELECT title, name 
FROM films 
JOIN studios 
ON films.studio_id = studios.id;
""",
      hint:
          'We need to combine the results of multiple tables for this one. When we use JOIN we have to include an ON',
    ),
    makePrompt(
      queryPrompt: """
Select the title of the film & genre's names for all genres. Order by genre name in alphabetical order.
""",
      answer: """
SELECT title, 
       name 
FROM   films 
       JOIN genre_films 
         ON films.id = genre_films.film_id 
       JOIN genres 
         ON genre_films.genre_id = genres.id
ORDER BY name;
""",
      hint:
          'We need to combine the results of multiple tables for this one. When we use JOIN we have to include an ON',
    ),
    makePrompt(
      queryPrompt: """
Select all film titles and join it's genres into a single column which contains a list of the genre's it's categorized in.
""",
      answer: """
SELECT films.title, GROUP_CONCAT(genres.name) AS genres
  FROM films
  JOIN genre_films ON films.id = genre_films.film_id
  JOIN genres ON genre_films.genre_id = genres.id
  GROUP BY films.title;
""",
      hint:
          'We need to combine the results of multiple tables for this one. When we use JOIN we have to include an ON',
    ),
    makePrompt(
      queryPrompt: """Select films title and it's director's name.""",
      answer: """
SELECT title, 
       NAME 
FROM   directors 
       JOIN film_directors 
         ON directors.id = film_directors.director_id 
       JOIN films 
         ON films.id = film_directors.film_id;
""",
      hint:
          'We need to combine the results of multiple tables for this one. When we use JOIN we have to include an ON',
    ),
    makePrompt(
      queryPrompt:
          'Select all the unique directors Disney Studios has employed over the years. Rename directors name field to directors_name and studios as studio_name',
      answer: """
SELECT DISTINCT directors.name as directors_name, studios.name studio_name
FROM film_directors
JOIN films ON films.id = film_directors.film_id
JOIN directors ON directors.id = film_directors.director_id
JOIN studios on studios.id = films.studio_id
WHERE films.studio_id = 1;
""",
      hint:
          'We need to combine the results of multiple tables for this one. We can eliminate duplicates using DISTINCT',
    ),
    makePrompt(
        queryPrompt:
            'Collect the film genres that Disney produces. Include genre_id and genre_name.',
        answer: """
SELECT genres.id as genre_id,
       genres.name as genre_name
FROM   films 
       JOIN genre_films 
         ON films.id = genre_films.film_id 
       JOIN genres 
         ON genre_films.genre_id = genres.id 
       JOIN studios 
         ON studios.id = films.studio_id 
WHERE  studios.id = 1 
GROUP  BY genres.name; 
"""),
    makePrompt(
      queryPrompt: """
Select the film's id, title, and director's & from all films.
""",
      answer: """
SELECT films.id, 
       title, 
       directors.NAME 
FROM   directors 
       JOIN film_directors 
         ON film_directors.director_id = directors.id 
       JOIN films 
         ON films.id = film_directors.film_id 
""",
      hint: 'It\'s possible to JOIN multiple times.',
    ),
    makePrompt(
      queryPrompt:
          """Select the film's id, title, & director's name from all films. But collect the directors into a new column named directors""",
      answer: """
SELECT worldwide_gross, 
       title, 
       GROUP_CONCAT(directors.NAME) AS directors,
       studios.NAME AS studio_name 
FROM   directors 
       JOIN film_directors 
         ON directors.id = film_directors.director_id 
       JOIN films 
         ON films.id = film_directors.film_id 
       JOIN studios 
         ON studios.id = films.studio_id 
GROUP BY films.title;
""",
      hint: 'It\'s possible to JOIN multiple tables.',
    ),
    makePrompt(
      ordered: true,
      queryPrompt: """
Select the top 3 total grossing directors from each studio(grossing in terms of worldwide_gross in film's revenue worldwide) in descending order.
""",
      answer: """
WITH DirectorRanks AS (
              SELECT 
                  studios.name AS studio_name,
                  directors.name AS director_name, 
                  SUM(films.worldwide_gross) AS director_total_gross,
                  ROW_NUMBER() OVER(PARTITION BY studios.id ORDER BY SUM(films.worldwide_gross) DESC) AS rank
              FROM 
                  directors 
              JOIN 
                  film_directors ON directors.id = film_directors.director_id 
              JOIN 
                  films ON films.id = film_directors.film_id 
              JOIN 
                  studios ON studios.id = films.studio_id 
              GROUP BY 
                  studios.id, directors.id
          )
          SELECT 
              studio_name,
              director_name,
              director_total_gross
          FROM 
              DirectorRanks
          WHERE 
              rank <= 3
          ORDER BY 
              studio_name, rank;
""",
      hint:
          'This one is tricky. It\'s probably easiest accomplished with a WINDOW function.',
    ),
    makePrompt(
      queryPrompt: """
Select id, name and their department's name of all the employees. Rename the employee's id to employee_id, employees name column to employee_name and department's name to department_name
Include employees that don't belong to a department.
""",
      answer: """
SELECT employees.id as employee_id, employees.name employee_name, departments.name department_name
FROM employees
FULL JOIN departments
ON employees.department_id = departments.id
""",
      hint: 'There are multiple types of JOINs.',
    ),
  ],
  '11.union.md': [
    makePrompt(
      queryPrompt: """
Select the name & ages of employees in the development & product departments.
""",
      answer: """
SELECT name, age FROM employees WHERE department_id = 1;
UNION
SELECT name, age FROM employees WHERE department_id = 2;
""",
      hint:
          'With UNION we can combine multiple select statement results into one.',
    ),
  ],
  '12.window.md': [
    makePrompt(
      queryPrompt: """
Window
""",
      answer: """

""",
    ),
  ],
  '13.functions.md': [
    makePrompt(
      queryPrompt: """
Functions
""",
      answer: """

""",
    ),
  ],
  '14.table-management.md': [
    makePrompt(
      queryPrompt: """
Table Management
""",
      answer: """

""",
    ),
  ],
  '15.database-management.md': [
    makePrompt(
      queryPrompt: """
List the fields & data-types of the employees table;
""",
      answer: """
pragma table_info(employees)
""",
    ),
  ],
};

// Examples
// https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/?envType=study-plan-v2&envId=top-sql-50

// Example: Selecting same table twice with aliases
// https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50

// Example: Multiple ands
// https://leetcode.com/problems/average-time-of-process-per-machine/?envType=study-plan-v2&envId=top-sql-50

// Example: Multiple group bys
// https://leetcode.com/problems/students-and-examinations/?envType=study-plan-v2&envId=top-sql-50

// Good sub query
// https://leetcode.com/problems/managers-with-at-least-5-direct-reports/?envType=study-plan-v2&envId=top-sql-50

final lessons = [
  '0.toc.md',
  '1.insert.md',
  '2.select.md',
  '3.update.md',
  '4.delete.md',
  '5.where.md',
  '6.orderby.md',
  '7.groupby.md',
  '8.having.md',
  '9.aggregate.md',
  // inner, outer, left, right, full, cross
  '10.join.md',
  '11.union.md',
  '12.window.md',
  '13.functions.md',
  '14.table-management.md',
  '15.database-management.md',
];

Future<int> checkProgress() async {
  final lessonId = await Storage.instance.getSQLLesson();
  return lessonId ?? 0;
}

Future<String> loadData(lessonId) async {
  return await loadMarkdownContent(lessonId);
}

Future<String> loadMarkdownContent(int lessonId) async {
  try {
    String path = 'assets/lessons/sql/${lessons[lessonId]}';
    final data = await rootBundle.loadString(path);
    return data;
  } catch (e) {
    print("Error loading Markdown content: $e");
    return '';
  }
}

Map<String, dynamic> makePrompt({
  String? queryPrompt,
  String? queryPromptFollowup,
  String? answer,
  String? hint,
  String? followup,
  String? followupPrompt,
  bool? ordered,
}) {
  return {
    'hint': hint ?? '',
    'answer': answer ?? '',
    'followup': followup ?? '',
    'queryPrompt': queryPrompt ?? '',
    'followupPrompt': followupPrompt ?? '',
    'queryPromptFollowup': queryPromptFollowup ?? '',
    'ordered': ordered ?? false,
  };
}
