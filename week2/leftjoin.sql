\pset null NULL

DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Kittens;
CREATE TABLE People(person text, cat text, PRIMARY KEY (person));
CREATE TABLE Kittens(cat text, kitten text, PRIMARY KEY (cat));
INSERT INTO People(person, cat)
VALUES ('michael', 'snowball'),
       ('joe', 'mittens'),
       ('sanjay', 'suki');
INSERT INTO Kittens(cat, kitten)
VALUES ('snowball', 'yeti'),
       ('mittens', 'socks');

SELECT P.person, K.kitten
FROM People P, Kittens K
WHERE P.cat = K.cat;

SELECT P.person, K.kitten
FROM People P LEFT OUTER JOIN Kittens K ON P.cat = K.cat;

SELECT P.person, K.kitten
FROM People P LEFT OUTER JOIN Kittens K ON (P.cat = K.cat AND K.kitten IS NULL);

SELECT P.person, K.kitten
FROM People P LEFT OUTER JOIN Kittens K ON P.cat = K.cat
WHERE K.kitten IS NULL;
