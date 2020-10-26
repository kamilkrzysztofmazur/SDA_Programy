SELECT * FROM authors;
SELECT * FROM books;

-- DELETE FROM authors WHERE Id = 51;

CREATE TRIGGER before_authors_delete
BEFORE DELETE
ON authors FOR EACH ROW
	DELETE FROM books WHERE OLD.Id = authors_Id;
    
-- DELETE FROM authors WHERE Id = 71;
DROP TRIGGER before_authors_delete;

ALTER TABLE books DROP FOREIGN KEY FK_authors_Id;
ALTER TABLE books ADD CONSTRAINT FK_authors_Id FOREIGN KEY (authors_Id) REFERENCES authors(Id) ON DELETE CASCADE;  
  
-- START TRANSACTION;
-- 	DELETE FROM authors WHERE Id = 54;
-- ROLLBACK;

CREATE TABLE logs (
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Action VARCHAR(50) NOT NULL,
    DateTime DATETIME NOT NULL,
    TableName VARCHAR(25),
    RowId VARCHAR(25));

CREATE TRIGGER after_authors_insert
AFTER INSERT
ON authors FOR EACH ROW
	INSERT INTO logs VALUES
    (NULL, 'insert', now(), 'authors', NEW.Id);
    
CREATE TRIGGER after_publishers_insert
AFTER INSERT
ON publishers FOR EACH ROW
	INSERT INTO logs VALUES
    (NULL, 'insert', now(), 'publishers', NEW.Name);

CREATE TRIGGER after_books_insert
AFTER INSERT
ON books FOR EACH ROW
	INSERT INTO logs VALUES
    (NULL, 'insert', now(), 'books', NEW.ISBN);

CALL AddBookExtendedProcedure('Edward', 'Edwardowski', 'Twoja książka', 'PL', 1234567890235, 'Książka Edwarda cz.2', 55);
SELECT * FROM logs;

CREATE TRIGGER after_books_delete
AFTER DELETE
ON books FOR EACH ROW
	INSERT INTO logs VALUES
    (NULL, 'delete', now(), 'books', OLD.ISBN);
    
DELETE FROM books WHERE ISBN = 1234567890235;
SELECT * FROM logs;