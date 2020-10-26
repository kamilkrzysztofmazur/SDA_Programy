SELECT * FROM books, authors;
SELECT b.Title Tytuł, a.LastName AS 'Nazwisko autora' FROM books AS b, authors a;
SELECT * FROM books, authors, publishers;

SELECT * FROM books FULL JOIN authors, publishers; 

SELECT * FROM authors LEFT OUTER JOIN books ON authors_Id = Id;
SELECT * FROM authors LEFT OUTER JOIN books ON authors_Id = Id WHERE ISBN IS NULL;

SELECT * FROM authors RIGHT JOIN books ON authors_Id = Id;
SELECT * FROM authors RIGHT JOIN books ON authors_Id = Id WHERE Id IS NULL;

SELECT * FROM authors INNER JOIN books ON authors_Id = Id;
SELECT * FROM authors JOIN books ON authors_Id = Id;

-- FULL OUTER JOIN
SELECT * FROM books LEFT JOIN authors ON authors_Id = Id
UNION
SELECT * FROM books RIGHT JOIN authors ON authors_Id = Id;

-- (LEFT JOIN IF NULL) UNION (RIGHT JOIN IF NULL)
SELECT * FROM books LEFT JOIN authors ON authors_Id = Id WHERE Id is NULL
UNION
SELECT * FROM books RIGHT JOIN authors ON authors_Id = Id WHERE authors_Id IS NULL;

SELECT * FROM publishers LEFT JOIN books ON publishers_Name = Name WHERE Title LIKE 'Tytuł%';