--
-- 'more tables' in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-02-11
--

SET NAMES 'utf8';

--
-- Update tabel larare and larare_pre to use same charset and collation.
--
ALTER TABLE larare CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;
ALTER TABLE larare_pre CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;


-- Drop tables in order to avoid FK constraint
DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;

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

DESCRIBE kurs;

SHOW CREATE TABLE kurs \G;

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

DESCRIBE kurstillfalle;

SHOW CREATE TABLE kurstillfalle \G;
