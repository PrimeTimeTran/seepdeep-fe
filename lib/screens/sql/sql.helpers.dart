import 'package:app/all.dart';
import 'package:flutter/services.dart';

import 'temp_lesson.dart';

const duplicateTitles = """
// duplicateTitles
SELECT title, COUNT(*) AS count
FROM films
GROUP BY title
HAVING COUNT(*) > 1;

// duplicateTitles records, ordered by title
SELECT id, title, year
FROM films
  WHERE title IN (
      SELECT title
      FROM films
      GROUP BY title
      HAVING COUNT(*) > 1
  )
ORDER BY title;


# DELETE from a list of ids;
WHERE id IN ( 5686,
             5711,
             5714,
             1002,
             5641,
             5634,
             5788,
             5731,
             5710,
             5826,
             5809,
             34,
             5784,
             1048,
             1054,
             1064,
             5685,
             5779,
             1038,
             5820,
             5680,
             5695,
             5805,
             5706,
             5681,
             5662,
             5647,
             5688,
             5686,
             5677 );

SELECT id, year, title from films where id < 50
""";

final lessonPromptMap = {
  '0.toc.md': [
    makePrompt(queryPrompt: 'Checkout the table in the top right'),
    makePrompt(queryPrompt: 'Checkout the next & find buttons'),
    makePrompt(queryPrompt: 'Checkout the results'),
  ],
  '1.insert.md': [
    makePrompt(
      queryPrompt: 'Add a film to the films table',
      queryPromptFollowup: 'What fields should you consider adding?',
    ),
    makePrompt(queryPrompt: 'Add an employee to the employees table'),
    makePrompt(
        queryPrompt:
            'Add another employee with name & surname fields to the employees table'),
    makePrompt(queryPrompt: 'Add a third employee to the employees table'),
  ],
  '2.select.md': [
    makePrompt(
      queryPrompt: 'Select titles of the records(films) from the films table.',
      answer: 'SELECT title from films;',
    ),
    makePrompt(
      queryPrompt: 'Select titles of the records(films) from the films table.',
      answer: 'SELECT title FROM films;',
      followup:
          'You probably experienced some lag there. The reason you did was because your query returned a tremendous number of results. You can limit the number of results with the `LIMIT` clause.',
      followupPrompt: 'SELECT title FROM films LIMIT 25;',
      hint: 'Think of querying your database as SELECTing data from it',
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
      answer: 'SELECT title, runtime, release_year FROM films;',
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
    ),
    makePrompt(
      queryPrompt:
          'Update all employees with an id greater than 1 to report to 1.',
    ),
    makePrompt(
      queryPrompt:
          'Update the film with the id of 1 to your favorite film\'s information. Update all fields',
    ),
  ],
  '4.delete.md': [
    makePrompt(
        queryPrompt:
            'After reviewing the films table, pick one you dont like and delete it.'),
    makePrompt(
        queryPrompt:
            'Find an employee from a city you\'ve never heard of in the employees table & delete that record from the db.'),
  ],
  '5.where.md': [
    makePrompt(
      queryPrompt:
          'Select films that have made a worldwide_gross of over 1billion.',
    ),
    makePrompt(
        queryPrompt:
            'Select films that have been nominated for 3 or more oscars'),
    makePrompt(
      queryPrompt: 'Select films that have won 2 or more oscars',
    ),
  ],
  '6.orderby.md': [
    makePrompt(
      queryPrompt:
          'Select id, name, surname, birth_date, age from employees ordered by age from youngest to oldest.',
      answer: """
SELECT id, name, surname, birth_date, age FROM employees ORDER BY age ASC;
""",
    ),
    makePrompt(
      queryPrompt:
          'Select id, name, surname, birth_date & age from employees ordered by age from oldest to youngest.',
      answer: """
SELECT id, name, surname, birth_date, age FROM employees ORDER BY age DESC;
""",
    ),
    makePrompt(
      queryPrompt:
          'Select id, name, surname, birth_date & age from employees ordered by age from oldest to youngest. Then order by their ids in DESC order for each age subgroup.',
      answer: """
SELECT id, name, surname, birth_date, age FROM employees ORDER BY age DESC, id DESC;
""",
    ),
    makePrompt(
        queryPrompt:
            'Select id, name, surname & salary from the top 25 highest paid employees',
        answer: """
SELECT id, name, surname, salary FROM employees ORDER BY salary DESC LIMIT 25;
"""),
    makePrompt(
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
"""),
    makePrompt(
        queryPrompt:
            'Select id, title, name & age from employees and group by title alphabetically.',
        answer: """
SELECT id, title, name, age
FROM employees
ORDER BY title;
"""),
    makePrompt(
      queryPrompt:
          'Select id, title, name & age from employees and group by title alphabetically then age oldest to youngest.',
      answer: """
SELECT id, title, name, age
FROM employees
ORDER BY title, age DESC;
""",
    ),
    makePrompt(
      queryPrompt:
          'Select id, year, title, oscars_nominated, oscars_won from the top 50 films by oscars nominated.',
      answer: """
SELECT id, year, title, oscars_nominated, oscars_won
FROM films 
ORDER BY oscars_nominated DESC
LIMIT 50;
""",
    ),
    makePrompt(
      queryPrompt:
          'Select id, year, title, oscars_nominated, oscars_won from the top 50 films by oscars nominated. Order by oscars_nominated and then oscars_won if theres a tie.',
      answer: """
SELECT year, title, oscars_nominated, oscars_won 
FROM films 
ORDER BY oscars_nominated DESC, oscars_won DESC 
LIMIT 50;
""",
    ),
    makePrompt(
      queryPrompt:
          'Select id, year, title, oscars_nominated, oscars_won from the top 50 films by oscars nominated. Order by oscars_won and then oscars_nominated if theres a tie.',
      answer: """
SELECT year, title, oscars_nominated, oscars_won 
FROM films 
ORDER BY oscars_won DESC, oscars_nominated DESC
LIMIT 50;
""",
    ),
  ],
  '7.groupby.md': [
    makePrompt(
      queryPrompt:
          'List the number of employees from each state. Include the name of the state and the count.',
      answer: """
SELECT state, count(*) FROM employees GROUP BY state;
""",
    ),
    makePrompt(
      queryPrompt:
          'List the number of films that have won at least 1 oscar. List the number they won as well.',
      answer: """
SELECT count(*) as oscar_winners, oscars_won FROM films WHERE oscars_won >= 1 GROUP BY oscars_won;
""",
    ),
  ],
  '8.having.md': [
    {'queryPrompt': 'Having'},
    makePrompt(
      queryPrompt: """
Select film titles that have been used more than once. Return the title and number of times it's been used as a title_use_count.
""",
      answer: """
SELECT title, COUNT(*) AS title_use_count
FROM films
GROUP BY title
HAVING COUNT(*) > 1;
""",
    ),
    makePrompt(
      queryPrompt: """
Select the film's id, title & year from films that have been used more than once. Order the title's names alphabetically.
""",
      answer: """
SELECT id, title, year
FROM films
  WHERE title IN (
      SELECT title
      FROM films
      GROUP BY title
      HAVING COUNT(*) > 1
  )
ORDER BY title;
""",
    ),
  ],
  '9.aggregate.md': [
    {'queryPrompt': 'Aggregate'},
  ],
  // 3 left join, 3 right join, 3 inner join, 3 outer join, 3 self join
  '10.join.md': [
    makePrompt(
      queryPrompt:
          """Select id, name and their department's name of all the employees""",
      answer: """
SELECT employees.id, employees.name, departments.name
FROM employees
JOIN departments
ON employees.department_id = departments.id
""",
    ),
    makePrompt(
      queryPrompt:
          """Select id, name and their department's name of all the employees. Rename the employee's id to employee_id, employees name column to employee_name and department's name to department_name""",
      answer: """
SELECT employees.id as employee_id, employees.name employee_name, departments.name department_name
FROM employees
JOIN departments
ON employees.department_id = departments.id
""",
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
    ),
    makePrompt(
      queryPrompt: """
Select the title of the film & genre's names for all genres. Group by genre name in alphabetical order.
""",
      answer: """
SELECT title, 
       NAME 
FROM   films 
       JOIN genre_films 
         ON films.id = genre_films.film_id 
       JOIN genres 
         ON genre_films.genre_id = genres.id
ORDER BY name;
""",
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
    ),
    makePrompt(
      queryPrompt:
          'Select all the unique directors Disney Studios has employed over the years.',
      answer: """
SELECT DISTINCT directors.name, studios.name
FROM film_directors
JOIN films ON films.id = film_directors.film_id
JOIN directors ON directors.id = film_directors.director_id
JOIN studios on studios.id = films.studio_id
WHERE films.studio_id = 1;
""",
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
"""),
    makePrompt(
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
    ),
    makePrompt(
      queryPrompt: """""",
      answer: """""",
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

// Example: Selecting same table twice with aliases
// https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50

// Example: Multiple ands
// https://leetcode.com/problems/average-time-of-process-per-machine/?envType=study-plan-v2&envId=top-sql-50

// Example: Multiple group bys
// https://leetcode.com/problems/students-and-examinations/?envType=study-plan-v2&envId=top-sql-50

// Good subquery
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
  // Examples
  // https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/?envType=study-plan-v2&envId=top-sql-50
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
    String data = lesson;
    if (true) {
      String path = 'assets/lessons/sql/${lessons[lessonId]}';
      data = await rootBundle.loadString(path);
    }
    return data;
  } catch (e) {
    print("Error loading Markdown content: $e");
    return '';
  }
}

Map<String, String> makePrompt({
  String? queryPrompt,
  String? queryPromptFollowup,
  String? answer,
  String? hint,
  String? followup,
  String? followupPrompt,
}) {
  return {
    'hint': hint ?? '',
    'answer': answer ?? '',
    'followup': followup ?? '',
    'queryPrompt': queryPrompt ?? '',
    'followupPrompt': followupPrompt ?? '',
    'queryPromptFollowup': queryPromptFollowup ?? '',
  };
}
