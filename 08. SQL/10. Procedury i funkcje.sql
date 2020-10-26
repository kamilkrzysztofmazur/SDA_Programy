-- TWORZENIE I WYWOŁYWANIE
DROP PROCEDURE IF EXISTS HelloFromProcedure;
DELIMITER ##
CREATE PROCEDURE HelloFromProcedure()
BEGIN
	SELECT 'Hello from Procedure';
	SELECT 'Hello from Procedure';
END ##
DELIMITER ;
CALL HelloFromProcedure;

SET GLOBAL LOG_BIN_TRUST_FUNCTION_CREATORS = 1;

DROP FUNCTION IF EXISTS HelloFromFunction;
DELIMITER ##
CREATE FUNCTION HelloFromFunction()
RETURNS VARCHAR(30)
BEGIN
	DECLARE result VARCHAR(30);
    SET result = (SELECT 'Hello from Function');
	RETURN result;
END ##
DELIMITER ;
SELECT HelloFromFunction();

-- PARAMETRYZOWANIE
DROP PROCEDURE IF EXISTS ConvertToFahrenheitProcedure;
DELIMITER ##
CREATE PROCEDURE ConvertToFahrenheitProcedure(IN celsius FLOAT)
BEGIN
	SELECT celsius*1.8+32;
END ##
DELIMITER ;
CALL ConvertToFahrenheitProcedure(0);

DROP PROCEDURE IF EXISTS ConvertToFahrenheitOutProcedure;
DELIMITER ##
CREATE PROCEDURE ConvertToFahrenheitOutProcedure(IN celsius FLOAT, OUT fahrenheit FLOAT)
BEGIN
	SET fahrenheit = celsius*1.8+32;
END ##
DELIMITER ;

CALL ConvertToFahrenheitOutProcedure(15, @fahrenheit);
SELECT @fahrenheit;

DROP FUNCTION IF EXISTS ConvertToFahrenheitFunction;
DELIMITER //
CREATE FUNCTION ConvertToFahrenheitFunction(celsius FLOAT)
RETURNS FLOAT
BEGIN
	RETURN celsius*1.8+32;
END //
DELIMITER ;
SELECT ConvertToFahrenheitFunction(15);

-- PONOWNE UZYCIE

SELECT CONCAT(HelloFromFunction(), ', how are you?');

DROP PROCEDURE IF EXISTS GetHelloFromProcedure;
DELIMITER ##
CREATE PROCEDURE GetHelloFromProcedure(OUT result VARCHAR(20))
BEGIN
	SELECT 'Hello from Procedure' INTO result;
END ##
DELIMITER ;

CALL GetHelloFromProcedure(@message);
SELECT CONCAT(@message, ', how are you?');

DROP FUNCTION IF EXISTS ProcedureInsideFunction;
DELIMITER $$
CREATE FUNCTION ProcedureInsideFunction()
RETURNS VARCHAR(40)
BEGIN
	DECLARE message VARCHAR(20);
	CALL GetHelloFromProcedure(message);
	RETURN CONCAT(message, ' in Function');
END $$
DELIMITER ;
SELECT ProcedureInsideFunction();

DROP PROCEDURE IF EXISTS FunctionInsideProcedure;
DELIMITER $$
CREATE PROCEDURE FunctionInsideProcedure()
BEGIN
	SELECT HelloFromFunction();
    SELECT HelloFromFunction(), 'in Procedure';
	SELECT CONCAT(HelloFromFunction(), ' in Procedure');
END $$
DELIMITER ;
CALL FunctionInsideProcedure();

DROP FUNCTION IF EXISTS FunctionInsideFunction;
DELIMITER $$
CREATE FUNCTION FunctionInsideFunction()
RETURNS VARCHAR(40)
BEGIN
	RETURN CONCAT(HelloFromFunction(), ' in Function');
END $$
DELIMITER ;
SELECT FunctionInsideFunction();

DROP PROCEDURE IF EXISTS ProcedureInsideProcedure;
DELIMITER $$
CREATE PROCEDURE ProcedureInsideProcedure()
BEGIN
	DECLARE message VARCHAR(20);
	CALL GetHelloFromProcedure(message);
	SELECT CONCAT(message, ' in Procedure');
    CALL HelloFromProcedure();
END $$
DELIMITER ;
CALL ProcedureInsideProcedure();

--

DROP FUNCTION IF EXISTS AddAuthorFunction;
DELIMITER ##
CREATE FUNCTION AddAuthorFunction(firstName VARCHAR(15), lastName VARCHAR(15))
RETURNS INT
BEGIN
	INSERT INTO authors SET FirstName = firstName, LastName = lastName;
    RETURN LAST_INSERT_ID();
END ##
DELIMITER ;

DROP PROCEDURE IF EXISTS AddBookProcedure;
DELIMITER ##
CREATE PROCEDURE AddBookProcedure(IN authorFirstName VARCHAR(15), IN authorLastName VARCHAR(15), IN publisherName VARCHAR(20), IN publisherCountryCode VARCHAR(2), IN isbn BIGINT, IN title VARCHAR(20), IN price FLOAT)
BEGIN
	DECLARE authorId INT;
    SET authorId = AddAuthorFunction(authorFirstName, authorLastName);
    INSERT INTO publishers SET Name = publisherName, CountryCode = publisherCountryCode;
    INSERT INTO books VALUES (isbn, title, authorId, publisherName, price);
END ##
DELIMITER ;

CALL AddBookProcedure('Edward', 'Edwardowski', 'Twoja książka', 'PL', 1234567890234, 'Książka Edwarda', 35);
SELECT * FROM books;
-- CALL AddBookProcedure('Edward', 'Edwardowski', 'Twoja książka', 'PL', 1234567890235, 'Książka Edwarda cz.2', 55);

DROP PROCEDURE IF EXISTS AddBookExtendedProcedure;
DELIMITER ##
CREATE PROCEDURE AddBookExtendedProcedure(IN authorFirstName VARCHAR(15), IN authorLastName VARCHAR(15), IN publisherName VARCHAR(20), IN publisherCountryCode VARCHAR(2), IN isbn BIGINT, IN title VARCHAR(20), IN price FLOAT)
BEGIN
	DECLARE authorId INT;
    SELECT Id FROM authors WHERE FirstName = authorFirstName AND LastName = authorLastName INTO authorId;
    IF(authorId IS NULL) THEN
		SET authorId = AddAuthorFunction(authorFirstName, authorLastName);
	-- ELSE
	-- ELSEIF
	END IF;
    
    IF NOT EXISTS (SELECT 0 FROM publishers WHERE Name = publisherName) THEN
        INSERT INTO publishers SET Name = publisherName, CountryCode = publisherCountryCode;
	END IF;
        
    INSERT INTO books VALUES (isbn, title, authorId, publisherName, price);
END ##
DELIMITER ;
CALL AddBookExtendedProcedure('Edward', 'Edwardowski', 'Twoja książka', 'PL', 1234567890235, 'Książka Edwarda cz.2', 55);

START TRANSACTION;
CALL AddBookExtendedProcedure('Ewdard', 'Edwardowski', 'Twoja książka', 'PL', 1234567890235, 'Książka Edwarda cz.2', 55);
SELECT * FROM authors;
ROLLBACK;