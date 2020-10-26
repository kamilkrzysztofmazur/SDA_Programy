CREATE DATABASE baza_testowa;
DROP DATABASE baza_testowa;

CREATE DATABASE IF NOT EXISTS library;
USE library;

CREATE USER Library IDENTIFIED BY 'libPass';
-- DROP USER Library;
RENAME USER Library TO Librarian;
SET PASSWORD FOR Librarian = 'libP@ss';
