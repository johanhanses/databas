--
-- Gather all ddl in the database "skolan" to one file
--

SET NAMES 'utf8';
-- Drop tables in order to avoid FK constraint
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS larare_pre;
DROP TABLE IF EXISTS larare;
DROP TABLE IF EXISTS kurs;

-- create table larare
CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,

    PRIMARY KEY (akronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- Add column to larare
ALTER TABLE larare ADD COLUMN kompetens INT;
ALTER TABLE larare DROP COLUMN kompetens;
ALTER TABLE larare ADD COLUMN kompetens INT DEFAULT 1 NOT NULL;

-- DESCRIBE larare;

-- SHOW CREATE TABLE larare \G;

-- make a copy of larare and name it larare_pre
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

-- create table "kurs"
CREATE TABLE kurs
(
    kod CHAR(6) PRIMARY KEY NOT NULL,
    namn VARCHAR(40),
    poang FLOAT,
    niva CHAR(3)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- DESCRIBE kurs;

-- SHOW CREATE TABLE kurs \G;

-- create table "kurstillfalle"
CREATE TABLE kurstillfalle
(
    id INT AUTO_INCREMENT NOT NULL,
    kurskod CHAR(6) NOT NULL,
    kursansvarig CHAR(3) NOT NULL,
    lasperiod INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare(akronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- DESCRIBE kurstillfalle;

-- SHOW CREATE TABLE kurstillfalle \G;

-- skapa vyn "v_name_alder" från tabellen "larare"
DROP VIEW IF EXISTS v_name_alder;
CREATE VIEW v_name_alder
AS
SELECT
    CONCAT (fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS Namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM larare
;

-- Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare inklusive en ny kolumn med lärarens ålder.
DROP VIEW IF EXISTS v_larare;
CREATE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM larare
;

-- Gör en rapport som visar hur många % respektive lärare fick i löneökning.
DROP VIEW IF EXISTS v_lonerevision;
CREATE VIEW v_lonerevision
AS
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.lon AS pre,
    l.lon AS nu,
    SUM(l.lon - p.lon) AS diff,
    ROUND(SUM(l.lon - p.lon) * 100.0 / p.lon, 2) AS proc,
    IF(ROUND(SUM(l.lon - p.lon) * 100.0 / p.lon, 2) > 3, "ok", "nok") AS mini
FROM larare AS l
    JOIN larare_pre AS p
        ON
        l.akronym = p.akronym
GROUP BY akronym
ORDER BY proc DESC
;

-- kompetensen
DROP VIEW IF EXISTS Vlonerevision;
CREATE VIEW Vlonerevision
AS
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.kompetens AS prekomp,
    l.kompetens AS nukomp,
    SUM(l.kompetens - p.kompetens) AS diffkomp
FROM larare AS l
    JOIN larare_pre AS p
        ON
        l.akronym = p.akronym
GROUP BY akronym
ORDER BY nukomp DESC, diffkomp DESC
;
-- Join three tables
DROP VIEW IF EXISTS v_planering;
CREATE VIEW v_planering
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;

-- SELECT * FROM v_planering;
