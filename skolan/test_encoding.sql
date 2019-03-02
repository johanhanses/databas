--
-- 'encoding' in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-02-11
--

SET NAMES 'utf8';

-- Låt oss skapa en tabell som innehåller svenska och norska tecken i en kolumn.
DROP TABLE IF EXISTS person;
CREATE TABLE person
(
    fornamn VARCHAR(10)
);

INSERT INTO person VALUES
("Örjan"), ("Börje"), ("Bo"), ("Øjvind"),
("Åke"), ("Åkesson"), ("Arne"), ("Ängla"),
("Ægir")
;

SELECT * FROM person;

SELECT * FROM person ORDER BY fornamn;

SHOW CREATE TABLE person;

SHOW CHARSET LIKE 'utf8mb4';

SHOW CHARSET LIKE 'latin1';

SHOW COLLATION WHERE Charset = 'latin1';

SHOW CHARSET LIKE 'utf8';

SELECT HEX("©");

ALTER TABLE person CONVERT TO CHARSET utf8 COLLATE utf8_unicode_ci;

SELECT * FROM person ORDER BY fornamn;

SHOW COLLATION WHERE Charset = 'utf8';

ALTER TABLE person CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;

SELECT * FROM person ORDER BY fornamn;
