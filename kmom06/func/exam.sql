--
-- Create table exam
--

USE dbwebb;

DROP TABLE IF EXISTS exam;
CREATE TABLE exam
(
    `acronym` CHAR(4) PRIMARY KEY,
    `score` INT
);

INSERT INTO exam
VALUES
    ('adam', 77),
    ('ubbe', 52),
    ('june', 49),
    ('john', 63),
    ('meta', 97),
    ('siva', 88);

SELECT * FROM exam;
