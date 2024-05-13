import 'package:app/all.dart';
import 'package:flutter/services.dart';

import 'temp_lesson.dart';

final lessonPromptMap = {
  '0.toc.md': [
    {'prompt': 'Checkout the table in the top right'},
    {'prompt': 'Checkout the next & find buttons'},
    {'prompt': 'Checkout the results'},
  ],
  '1.insert.md': [
    {'prompt': 'Add an employee to the employees table'},
    {
      'prompt':
          'Add another employee with name & surname fields to the employees table'
    },
    {'prompt': 'Add a third employee to the employees table'},
  ],
  '2.select.md': [
    {'prompt': 'Select titles of the records in the films table.'},
    {
      'prompt':
          'Select titles, runtime, & year release_year of the records from the films table.'
    },
    {'prompt': 'Select name & surname from the employees table.'},
  ],
  '3.update.md': [
    {
      'prompt':
          'The employee record with the id of 1, change it to have your data/information.'
    },
    {
      'prompt': 'Update all employees with an id greater than 1 to report to 1.'
    },
    {
      'prompt':
          'Update the film with the id of 1 to your favorite film\'s information. Update all fields'
    },
  ],
  '4.delete.md': [
    {
      'prompt':
          'After reviewing the films table, pick one you dont like and delete it.'
    },
    {
      'prompt':
          'Find an employee from a city you\'ve never heard of in the employees table & delete that record from the db.'
    },
  ],
  '5.where.md': [
    {
      'prompt':
          'Select films that have made a worldwide_gross of over 1billion.'
    },
    {'prompt': 'Select films that have been nominated for 3 or more oscars'},
    {'prompt': 'Select films that have won 2 or more oscars'},
  ],
  '6.orderby.md': [
    {
      'prompt':
          'List the films ordered by their worldwide_gross in descending order'
    },
    {
      'prompt': 'List the employees ordered by their salary in descending order'
    },
    {'prompt': 'List the employees ordered from youngest to oldest'},
    {'prompt': 'List the employees ordered from oldest to youngest'},
    {
      'prompt': 'List employees but group them by title',
      'answer': """
SELECT title, id, name
FROM employees
ORDER BY title;
"""
    },
    {
      'prompt': 'List employees but group them by title then name',
      'answer': """
SELECT title, id, name
FROM employees
ORDER BY title, name;
"""
    },
    {
      'prompt': 'List employees but group them by title, name, then birth date',
      'answer': """
SELECT title, id, name
FROM employees
ORDER BY title, name, birth_date;
"""
    },
  ],
  '7.groupby.md': [
    {'prompt': 'List the number of employees from each state'},
    {'prompt': 'List the number of films that have won 1 oscar'},
    {
      'prompt':
          'Count the number of films that have won each sequential number of oscars(0, 1, 2,)'
    },
    {'prompt': 'Find all the unique number of oscars a film has won'},
  ],
  '8.aggregate.md': [
    {'prompt': 'Aggregate'},
  ],
  '9.join.md': [
    {
      'prompt':
          'Select title & it\'s studio\'s name from the films & studios tables.',
      'answer': """
SELECT title, name from films join studios on films.studio_id = studios.id;
"""
    },
    {
      'prompt':
          'Select employees name & their department\'s name from the employees & departments table.',
      'answer': """
SELECT employees.name as employee_name, departments.name as department_name from employees join departments on employees.department_id = departments.id;
"""
    },
    {
      'prompt':
          'Select employees name & their department\'s name from the employees & departments table.',
      'answer': """
SELECT employees.name as employee_name, departments.name as department_name from employees join departments on employees.department_id = departments.id;
"""
    },
    {
      'prompt': 'Select the titles & genre names of each of the films genres.',
      'answer': """
select title, name from films join genre_films on films.id = genre_films.film_id join genres on genre_films.genre_id = genres.id;
"""
    },
    {
      'prompt':
          'List all films. Include their title & their genres as a single column that contains a list(as opposed to duplicating film rows like in the previous query).',
      'answer': """
SELECT films.title, GROUP_CONCAT(genres.name) AS genres
  FROM films
  JOIN genre_films ON films.id = genre_films.film_id
  JOIN genres ON genre_films.genre_id = genres.id
  GROUP BY films.title;
"""
    },
    // 3 left join, 3 right join, 3 inner join, 3 outer join, 3 self join
    {
      'prompt':
          'Find the name of and the title of the films they\'ve directed of the directors',
      'answer': """
select title, name from directors join film_directors on directors.id = film_directors.director_id join films on films.id = film_directors.film_id
""",
    },
    {
      'prompt':
          'Select the films title, directors name, worldwide_gross and studios name from the db.',
      'answer': """
select worldwide_gross, title, directors.name, studios.name as studio_name from directors join film_directors on directors.id = film_directors.director_id join films on films.id = film_directors.film_id join studios on studios.id = films.studio_id
""",
    },
    {
      'prompt':
          'Select the top 3 directors from each studio(in terms of highest grossing total in films revenue) in descending order',
      'answer': """
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
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
    {
      'prompt': '',
      'answer': """

""",
    },
  ],
  '10.union.md': [
    {'prompt': 'Union'},
  ],
  '11.window.md': [
    {'prompt': 'Window'},
  ],
  '12.functions.md': [
    {'prompt': 'Functions'},
  ],
  '15.table-management.md': [
    {'prompt': 'Table Management'},
  ],
  '16.database-management.md': [
    {'prompt': 'Database Management'},
  ],
};

final lessons = [
  '0.toc.md',
  '1.insert.md',
  '2.select.md',
  '3.update.md',
  '4.delete.md',
  '5.where.md',
  '6.orderby.md',
  '7.groupby.md',
  '8.aggregate.md',
  '9.join.md',
  '10.union.md',
  '11.window.md',
  '12.functions.md',
  '15.table-management.md',
  '16.database-management.md',
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
