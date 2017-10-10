\pset null NULL

DROP TABLE IF EXISTS Pairs;
CREATE TABLE Pairs(x integer, y integer);
INSERT INTO Pairs(x, y)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (3, 3),
       (4, NULL),
       (5, NULL);

DROP TABLE IF EXISTS AllNull;
CREATE TABLE AllNull(x integer, y integer);
VALUES (1, NULL),
       (2, NULL),
       (3, NULL);

-- Queries only return tuples for which the WHERE clause evaluates to true. It
-- excludes tuples for which the WHERE clause evaluates to false or null.
SELECT *
FROM Pairs
WHERE y > 0;

-- What predicates evaluate to NULL?
SELECT (2 > 1) AS a; -- true
SELECT (0 > 1) AS b; -- false
SELECT (NULL > 1) AS c; -- NULL
SELECT (2 > NULL) AS d; -- NULL
SELECT (NULL > NULL) AS e; -- NULL
SELECT (NULL = NULL) AS f; -- NULL

SELECT b, (b AND true) AS t, (b AND false) AS f, (b AND NULL) AS NULL
FROM (VALUES (true), (false), (NULL)) AS Bools(b);

SELECT b, (b OR true) AS t, (b OR false) AS f, (b OR NULL) AS NULL
FROM (VALUES (true), (false), (NULL)) AS Bools(b);

SELECT b, (NOT b) AS "not b"
FROM (VALUES (true), (false), (NULL)) AS Bools(b);

SELECT (NULL + 0) AS g; -- NULL
SELECT (NULL * 0) AS h; -- NULL

-- Aggregates and nulls.
SELECT COUNT(y), MAX(y), MIN(y), SUM(y) FROM Pairs;
SELECT COUNT(y), MAX(y), MIN(y), SUM(y) FROM AllNull;

-- Distinct and nulls.
SELECT y FROM Pairs;
SELECT DISTINCT(y) FROM Pairs;

-- Group by null.
SELECT y, SUM(x)
FROM Pairs
GROUP BY y;

-- Joins and null.
SELECT *
FROM Pairs P1, Pairs P2
WHERE P1.y = P2.y;
