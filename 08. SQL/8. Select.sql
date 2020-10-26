SELECT COUNT(*) FROM books;
SELECT COUNT(*) 'Ilość książek' FROM books;
SELECT COUNT(*) 'Ilość książek' FROM books WHERE Title LIKE 'Tytuł%';

ALTER TABLE books ADD price FLOAT NOT NULL DEFAULT 0;
UPDATE books SET price=LENGTH(Title) * 0.5 + authors_Id;
SELECT * FROM books;

SELECT AVG(price) FROM books;
SELECT AVG(price) FROM books WHERE Title NOT LIKE '% %';

SELECT MIN(price) FROM books;
SELECT MAX(price) FROM books;

SELECT MIN(price), MAX(price) FROM books;
SELECT MIN(price) 'Cena minimalna', MAX(price) 'Cena maksymalna' FROM books;
SELECT MIN(LENGTH(Title)) 'Minimalna długość tytułu', MAX(LENGTH(Title)) 'Maksymalna długość tytułu' FROM books;

SELECT SUM(price) FROM books;
SELECT SUM(price) FROM books WHERE authors_Id = 51;
SELECT SUM(price) FROM books AS BOOK WHERE (SELECT COUNT(*) FROM publishers WHERE BOOK.publishers_Name = Name AND CountryCode = 'PL') > 0;

SELECT COUNT(*), publishers_Name FROM books GROUP BY publishers_Name;
SELECT COUNT(*), authors_Id FROM books GROUP BY authors_Id;

SELECT COUNT(*) as count, authors_Id FROM books GROUP BY authors_Id ORDER BY count;
SELECT COUNT(*) as count, authors_Id FROM books GROUP BY authors_Id ORDER BY count, authors_Id DESC;

SELECT COUNT(*) as count, authors_Id FROM books GROUP BY authors_Id HAVING count > 2;
-- SELECT COUNT(*) as count, authors_Id FROM books WHERE count > 2 GROUP BY authors_Id;
SELECT COUNT(*) as count, authors_Id FROM books WHERE price > 55 GROUP BY authors_Id HAVING count > 1; 
