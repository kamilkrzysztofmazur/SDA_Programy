INSERT INTO authors (FirstName, LastName) VALUES ('Adam', 'Adamski');
INSERT INTO authors VALUES (NULL, 'Ewa', 'Ewowska');

INSERT INTO publishers (Name, CountryCode) VALUES
('PWN', 'PL'),
('Poligraf', 'PL'),
('Wilga', 'UK');

DESCRIBE authors;
INSERT INTO authors VALUES (50, 'Piotr', 'Piotrowski');
INSERT INTO authors SET LastName = 'Karolińska', FirstName = 'Karolina';

INSERT INTO authors VALUES (30, 'Michał', 'Michałowski');
INSERT INTO authors SET LastName = 'Jan', FirstName = 'Janowski';

INSERT INTO books VALUES
(1234567890123, 'Tutuł tytułem', 1, 'PWN'),
(1234567890124, 'Książka książką', 2, 'Poligraf'),
(1234567890125, 'Okładka okładką', 1, 'PWN');

SELECT * FROM books;
SELECT ISBN, Title FROM books;

SELECT ISBN, Title FROM books ORDER BY ISBN DESC;
SELECT * FROM publishers ORDER BY CountryCode ASC, Name DESC;
SELECT ISBN AS 'Kod kreskowy', Title Tutuł FROM books ORDER BY Tutuł;

SELECT * FROM authors WHERE FirstName = 'Adam';
SELECT * FROM authors WHERE Id > 30;
SELECT * FROM authors WHERE Id < 30;
SELECT * FROM authors WHERE Id >= 30;
SELECT * FROM authors WHERE Id <= 30;
SELECT * FROM authors WHERE Id != 30;
SELECT * FROM authors WHERE FirstName != 'Adam';
SELECT * FROM authors WHERE FirstName <> 'Adam';

SELECT * FROM authors WHERE Id >= 2 AND Id <= 50;
SELECT * FROM authors WHERE Id BETWEEN 2 AND 50;

SELECT * FROM authors WHERE Id >= 2 AND FirstName = 'Karolina';

SELECT * FROM authors WHERE LastName LIKE '%ska';
SELECT * FROM authors WHERE LastName NOT LIKE '%ska';

SELECT * FROM publishers WHERE CountryCode IN ('US', 'UK');
SELECT * FROM publishers WHERE Name IN (SELECT DISTINCT publishers_Name FROM books);

SELECT * FROM authors WHERE FirstName LIKE '%ski' OR LastName LIKE '%ska';

SELECT * FROM authors LIMIT 1;
SELECT * FROM authors ORDER BY Id DESC LIMIT 1;
SELECT * FROM authors WHERE Id > 30 LIMIT 1;
SELECT * FROM authors WHERE Id > 30 LIMIT 1, 2;
SELECT * FROM authors LIMIT 2, 10;

UPDATE books SET ISBN=3210987654321 where Title = 'Tutuł tytułem';
UPDATE books SET ISBN=4210987654321 where ISBN = 1234567890124;
UPDATE books SET authors_Id = 50 WHERE publishers_Name = 'PWN';
SELECT * FROM books;

UPDATE authors SET FirstName='Jan', LastName='Janowski' WHERE Id = 52;
SELECT * FROM authors;

UPDATE books SET authors_Id = 1;

DELETE FROM books WHERE ISBN = 3210987654321;
-- DELETE FROM authors WHERE Id = 1;
DELETE FROM books;
DELETE FROM authors WHERE Id = 1;

INSERT INTO authors (FirstName, LastName) VALUES
('Adam', 'Adamski'),
('Alicja', 'Alicjowska');

INSERT INTO books VALUES
(1234567890130, 'Tytuł Tytułem', 54, 'PWN'),
(1234567890131, 'Zakładka', 54, 'PWN'),
(1234567890132, 'Okłądka', 2, 'Poligraf'),
(1234567890133, 'Tytuł Zakładką', 30, 'PWN'),
(1234567890134, 'Tytuł Okładką', 51, 'Poligraf'),
(1234567890135, 'Tytuł X', 51, 'Poligraf'),
(1234567890136, 'Tytuł XY', 51, 'PWN'),
(1234567890137, 'Tytuł XYZ', 2, 'Poligraf');


