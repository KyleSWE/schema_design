CREATE TABLE location (
  id serial PRIMARY KEY,
  city varchar,
  state varchar,
  country varchar
);

CREATE TABLE person (
  id serial PRIMARY KEY,
  firstName varchar,
  lastName varchar,
  age integer,
  location_id integer,
  FOREIGN KEY (location_id)
    REFERENCES location(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE interest (
  id serial PRIMARY KEY,
  title varchar
);

CREATE TABLE person_interest (
  person_id integer,
  interest_id integer,
  FOREIGN KEY (person_id)
    REFERENCES person(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (interest_id)
    REFERENCES interest(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO location (city, state, country) values
  ('Nashville', 'Tennessee', 'United States'),
  ('Memphis', 'Tennessee', 'United States'),
  ('Phoenix', 'Arizona', 'United States'),
  ('Denver', 'Colorado', 'United States');

INSERT INTO person (firstName, lastName, age, location_id) values
  ('Chickie',	'Ourtic',	21,	1),
  ('Hilton',	'O''Hanley',	37,	1),
  ('Barbe',	'Purver',	50,	3),
  ('Reeta',	'Sammons',	34,	2),
  ('Abbot',	'Fisbburne',	49,	1),
  ('Winne',	'Whines',	19,	4),
  ('Samantha',	'Leese',	35,	2),
  ('Edouard',	'Lorimer',	29,	1),
  ('Mattheus',	'Shaplin', 27,	3),
  ('Donnell',	'Corney',	25,	3),
  ('Wallis',	'Kauschke',	28,	3),
  ('Melva',	'Lanham',	20,	2),
  ('Amelina',	'McNirlan',	22,	4),
  ('Courtney',	'Holley',	22,	4),
  ('Sigismond',	'Vala',	21,	4),
  ('Jacquelynn',	'Halfacre',	24,	2),
  ('Alanna',	'Spino',	25,	3),
  ('Isa',	'Slight',	32,	1),
  ('Kakalina',	'Renne',	26,	3);

INSERT INTO interest (title) values
  ('Programming'),
  ('Gaming'),
  ('Computers'),
  ('Music'),
  ('Movies'),
  ('Cooking'),
  ('Sports');

INSERT INTO person_interest (person_id, interest_id) values
  (1, 1),
  (1, 2),
  (1, 6),
  (2, 1),
  (2, 7),
  (2, 4),
  (3, 1),
  (3, 3),
  (3, 4),
  (4, 1),
  (4, 2),
  (4, 7),
  (5, 6),
  (5, 3),
  (5, 4),
  (6, 2),
  (6, 7),
  (7, 1),
  (7, 3),
  (8, 2),
  (8, 4),
  (9, 5),
  (9, 6),
  (10, 7),
  (10, 5),
  (11, 1),
  (11, 2),
  (11, 5),
  (12, 1),
  (12, 4),
  (12, 5),
  (13, 2),
  (13, 7),
  (14, 2),
  (14, 4),
  (14, 6),
  (15, 1),
  (15, 5),
  (15, 7),
  (16, 2),
  (16, 3),
  (16, 4),
  (17, 1),
  (17, 3),
  (17, 5),
  (17, 7),
  (18, 2),
  (18, 4),
  (18, 6),
  (19, 1),
  (19, 2),
  (19, 3),
  (19, 4),
  (19, 5),
  (19, 6),
  (19, 7);

UPDATE person SET age = age + 1 WHERE
  firstName = 'Chickie' AND lastName = 'Ourtic' OR
  firstName = 'Winne' AND lastName = 'Whines' OR
  firstName = 'Edouard' AND lastName = 'Lorimer' OR
  firstName = 'Courtney' AND lastName = 'Holley' OR
  firstName = 'Melva' AND lastName = 'Lanham' OR
  firstName = 'Isa' AND lastName = 'Slight' OR
  firstName = 'Abbott' AND lastName = 'Fisbburne' OR
  firstName = 'Reeta' AND lastName = 'Sammons';

DELETE FROM person WHERE
  firstName = 'Hilton' AND lastName = 'O''Hanley' OR
  firstName = 'Alanna' AND lastName = 'Spino';

SELECT firstName, lastName FROM person;

SELECT firstName, lastName, city, state FROM person
  JOIN location ON location.id = person.location_id
  WHERE city = 'Nashville' AND state = 'Tennessee';

SELECT city, COUNT(city) as count FROM person
  JOIN location ON location.id = person.location_id
  GROUP BY location.city;

SELECT title, COUNT(title) as count FROM person
  JOIN person_interest ON person_interest.person_id = person.id
  JOIN interest ON interest.id = person_interest.interest_id
  GROUP BY title;

SELECT firstName, lastName, city, state, title FROM person
  JOIN location ON location.id = person.location_id
  JOIN person_interest ON person_interest.person_id = person.id
  JOIN interest ON interest.id = person_interest.interest_id
  WHERE city = 'Nashville' AND title = 'Programming';

SELECT range, COUNT(*) FROM
  (SELECT CASE
    WHEN age BETWEEN 20 AND 30 THEN '20-30'
    WHEN age BETWEEN 30 AND 40 THEN '30-40'
    WHEN age BETWEEN 40 AND 50 THEN '40-50'
    END as range
    FROM person)
  GROUP BY range;