INSERT INTO authors SET FirstName = 'Zbigniew', LastName = 'Zbigniewski';
SELECT Id FROM authors WHERE FirstName = 'Zbigniew' AND LastName = 'Zbigniewski';

SELECT LAST_INSERT_ID();

INSERT INTO authors VALUES
(NULL, 'Halina', 'Halinowska'),
(NULL, 'Wanda', 'Wandowska');
SELECT LAST_INSERT_ID();
SELECT * FROM authors;



INSERT INTO authors SET FirstName = 'Maja', LastName = 'Majewska';
SET @authorId = LAST_INSERT_ID();
SELECT @authorId;
INSERT INTO publishers SET Name = 'Publicysta', CountryCode = 'PL';
INSERT INTO books VALUES (1234567890543, 'Tytuł książki', @authorId, 'Publicysta', 15);

DELETE FROM books WHERE ISBN = 1234567890543;
DELETE FROM publishers WHERE Name = 'Publicysta';
DELETE FROM authors WHERE Id = @authorId;

-- SET AUTOCOMMIT = 0;
START TRANSACTION;
	INSERT INTO authors SET FirstName = 'Maja', LastName = 'Majewska';
	SET @authorId = LAST_INSERT_ID();
	SELECT @authorId;
	INSERT INTO publishers SET Name = 'Publicysta', CountryCode = 'PL';
	INSERT INTO books VALUES (1234567890543, 'Tytuł książki', @authorId, 'Publicysta', 15);
	SELECT * FROM books;
-- ROLLBACK;
COMMIT;
-- SET AUTOCOMMIT = 1;

SELECT * FROM books;
SELECT * FROM publishers;
SELECT * FROM authors;