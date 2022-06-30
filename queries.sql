-- write your queries here

\d owners; 
-- id
-- first_name
-- last_name
\d vehicles;
-- id
-- make
-- model
-- year
-- price
-- owner_id


-- Join the two tables so that every column and record appears, regardless of if there is not an owner_id. 
SELECT * FROM owners o
FULL OUTER JOIN vehicles v
ON o.id = v.owner_id;

-- Count the number of cars for each owner. Display the owners first_name, last_name and count of vehicles. The first_name should be ordered in ascending order. 

SELECT o.first_name, o.last_name, COUNT(*)
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
ORDER BY o.first_name;

-- Count the number of cars for each owner and display the average price for each of the cars as integers. Display the owners first_name, last_name, average price and count of vehicles. The first_name should be ordered in descending order. Only display results with more than one vehicle and an average price greater than 10000.

SELECT first_name, last_name, ROUND(AVG(price)) AS average_price, COUNT(owner_id)
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY first_name, last_name
HAVING AVG(price) > 10000
ORDER BY first_name DESC;

-- SQL Zoo #6
SELECT matchid, player FROM goal 
  WHERE teamid='GER';

SELECT id,stadium,team1,team2
  FROM game
  WHERE id=1012;

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER';

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%';

SELECT player, teamid, coach, gtime
  FROM goal 
  JOIN eteam
  ON teamid=id
  WHERE gtime<=10;

SELECT mdate, eteam.teamname
FROM game
JOIN eteam
ON (team1=eteam.id)
WHERE eteam.coach = 'Fernando Santos'

SELECT player 
FROM goal
JOIN game
ON game.id=goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

SELECT player
FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER') AND (goal.teamid !='GER')
GROUP BY player
ORDER BY player;

SELECT teamname, COUNT(*)
  FROM eteam 
  JOIN goal 
  ON eteam.id=goal.teamid
  GROUP BY teamname
  ORDER BY teamname;

SELECT stadium, COUNT(*)
FROM game
JOIN goal
ON id=matchid
GROUP BY stadium;

SELECT matchid,mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal ON matchid = id 
WHERE (teamid= 'GER')
GROUP BY matchid, mdate;

SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate, matchid,team1,team2
    ORDER BY mdate, matchid, team1, team2;

-- SQL Zoo #7

SELECT id, title
 FROM movie
 WHERE yr=1962;

SELECT yr
FROM movie
WHERE title='Citizen Kane';

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%';

SELECT id
FROM casting
JOIN actor
ON actorid=id
WHERE name = 'Glenn Close'
GROUP BY id;

SELECT id 
FROM movie
WHERE title='Casablanca';

SELECT name FROM actor a
JOIN casting c
ON a.id = actorid
JOIN movie m
ON m.id=movieid
WHERE movieid=27;

SELECT name FROM actor a
JOIN casting c
ON a.id = actorid
JOIN movie m
ON m.id=movieid
WHERE title='Alien';

SELECT title FROM movie m
JOIN casting c
ON m.id = movieid
JOIN actor a
ON a.id=actorid
WHERE name='Harrison Ford';

SELECT title FROM movie m
JOIN casting c
ON m.id = movieid
JOIN actor a
ON a.id=actorid
WHERE name='Harrison Ford' AND ord!=1;

SELECT title, name FROM movie m
JOIN casting c
ON m.id = movieid
JOIN actor a
ON a.id=actorid
WHERE ord=1 AND yr=1962;

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1;

SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews');

SELECT title, name FROM movie
JOIN casting 
ON movie.id = movieid
JOIN actor 
ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews');

SELECT name
FROM actor
JOIN casting 
ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>=15)
GROUP BY name;

SELECT title, COUNT(*)
FROM movie
JOIN casting
ON id=movieid
WHERE yr=1978
GROUP BY title
ORDER BY COUNT(*) DESC, title;

SELECT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name;


