DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;

CREATE TABLE IF NOT EXISTS books(
	ISBN BIGINT,
    Title VARCHAR(20)
    );
-- SHOW COLUMNS FROM books;
-- SHOW COLUMNS FROM books LIKE '%i%';
DESCRIBE books;

CREATE TABLE authors(
	Id INTEGER PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(15),
    LastName VARCHAR(15) NOT NULL
    );
DESCRIBE authors;

CREATE TABLE publishers(
	Name VARCHAR(20),
    CountryCode VARCHAR(2) NOT NULL DEFAULT('XX'),
    PRIMARY KEY(Name)
    );
DESCRIBE publishers;

CREATE TABLE customers LIKE authors;
DESCRIBE customers;

CREATE INDEX Index_Title ON books (Title);
DESCRIBE books;
SHOW indexes FROM books;

CREATE TABLE orders(
	Rent TIMESTAMP NOT NULL,
    `Return` TIMESTAMP,
    books_ISBN BIGINT NOT NULL,
    customers_Id INTEGER NOT NULL,
    PRIMARY KEY (Rent, books_ISBN),
    UNIQUE INDEX IX_books_ISBN_Return (books_ISBN, `Return`),
    INDEX IX_customers_Id (customers_Id)
);

DESCRIBE orders;
SHOW indexes FROM orders;

ALTER TABLE books ADD COLUMN publisher_Name VARCHAR(10);
ALTER TABLE books ADD authors_Id INTEGER AFTER Title;
-- ALTER TABLE books DROP authors_Id;

ALTER TABLE books RENAME COLUMN publisher_Name TO publishers_Name;
ALTER TABLE orders RENAME reservations;

ALTER TABLE books MODIFY COLUMN publishers_Name VARCHAR(20);
ALTER TABLE books MODIFY COLUMN ISBN BIGINT UNSIGNED;

ALTER TABLE books ADD PRIMARY KEY (ISBN);

ALTER TABLE publishers ALTER COLUMN CountryCode SET DEFAULT 'XY';
ALTER TABLE publishers ALTER COLUMN CountryCode DROP DEFAULT;
describe publishers;

ALTER TABLE books DROP INDEX Index_Title;
ALTER TABLE books ADD INDEX IX_Title (Title);
ALTER TABLE authors ADD UNIQUE INDEX IX_FirstName_LastName (FirstName, LastName);
SHOW INDEX FROM authors;

DROP TABLE IF EXISTS SomeTable;
TRUNCATE TABLE books;

ALTER TABLE books ADD CONSTRAINT FK_publishers_Name FOREIGN KEY (publishers_Name) REFERENCES publishers(Name);
ALTER TABLE books ADD CONSTRAINT FK_authors_Id FOREIGN KEY (authors_Id) REFERENCES authors(Id);
SHOW INDEX FROM books;
DESCRIBE books;

ALTER TABLE reservations MODIFY COLUMN books_ISBN BIGINT UNSIGNED;
ALTER TABLE reservations ADD CONSTRAINT FK_books_ISBN FOREIGN KEY (books_ISBN) REFERENCES books(ISBN);
ALTER TABLE reservations ADD CONSTRAINT FK_customers_Id FOREIGN KEY (customers_Id) REFERENCES customers(Id);

