INSERT INTO authors (FirstName, LastName) VALUES ('Adam', 'Adamski');
INSERT INTO authors (FirstName, LastName) VALUES ('Ewa', 'Ewowska');
INSERT INTO publishers (Name, CountryCode) VALUES
('PWN', 'PL'),
('Poligraf', 'PL'),
('Wilga', 'UK');
DESCRIBE authors;
INSERT INTO authors VALUES (50, 'Piotr', 'Piotrowski');
INSERT INTO authors SET LastName = 'Karolińska', FirstName = 'Karolina';
INSERT INTO authors VALUES (30, 'Michał', 'Michałowski');
INSERT INTO authors SET LastName = 'Jan', FirstName = 'Janowski';
SELECT * FROM authors;