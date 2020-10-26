CREATE DATABASE cinema;
CREATE TABLE movies(
ID INTEGER PRIMARY KEY,
Name VARCHAR(50),
Rating TINYINT
);

CREATE TABLE seance(
ID INTEGER PRIMARY KEY AUTO_INCREMENT,
Movies_ID INTEGER,
Date_time DATETIME,
CONSTRAINT FK_1 FOREIGN KEY (Movies_ID) REFERENCES movies (ID)
);

ALTER TABLE movies MODIFY COLUMN Name VARCHAR(100);
ALTER TABLE movies ADD Room INTEGER AFTER Name;

SELECT * FROM reservations;
DESCRIBE books;

INSERT INTO books VALUES (8528528528521, 'Nowa książka', 3, 'Ravensburger', 20);

UPDATE books SET publishers_Name='Ravensburger' WHERE authors_Id = 1;

INSERT INTO customers VALUES
(1, 'Kamil', 'Zajebisty'),
(2, 'Kamil', 'Boski'),
(3, 'Kamil', 'Najlepszy');


INSERT INTO reservations VALUES
(20200101010101, 20200105050505, 8528528528521, 3),
(20200201010101, 20200205050505, 1234567890123, 2),
(20200301010101, 20200305050505, 1234567890124, 1),
(20200401010101, 20200405050505, 1234567890125, 2),
(20200501010101, 20200505050505, 1234567890123, 1);

-- Usunąć z tabeli reservations wpis z najstarszą datą wypożyczenia

DELETE FROM reservations WHERE Rent='20200101010101';

DELETE from reservations WHERE Rent = ( SELECT * FROM (SELECT MIN(Rent) FROM reservations) as x);

-- Wyświetlić książki, które zostały wypożyczone wraz z danymi o ich wypożyczeniu (INNER JOIN)

SELECT b.Title, r.Rent, r.Return, r.books_ISBN, r.customers_Id FROM books b
JOIN reservations r ON b.ISBN = r.books_ISBN;

-- Obliczyć średni czas rezerwacji książek. Zapewnić, że przynajmniej jedna rezerwacja ma podany znacznik czasu zwrotu.

SELECT unix_timestamp('Return')- unix_timestamp('Rent') 'Średni czas rezerwacji ksiązki' FROM reservations;

-- Wyświetlić ile książek wypożyczył każdy z klientów (operacja na tabeli reservations)

SELECT COUNT(*)'Liczba wypozyczonych książek', c.FirstName, c.LastName FROM reservations r
JOIN customers c ON c.Id = r.customers_Id 
GROUP BY customers_Id;



