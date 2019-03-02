--
-- Insert values into tables in database skolan.
-- By johv18 for course databas.
-- 2019-02-12
--

--
-- inserts and updates into table larare
--

-- Delete if not empty
DELETE FROM larare;
-- Add column to TABLE
ALTER TABLE larare DROP COLUMN kompetens;
ALTER TABLE larare ADD COLUMN kompetens INT DEFAULT 1 NOT NULL;
-- Add teacher staff
INSERT INTO larare
    (akronym, avdelning, fornamn, efternamn, kon, lon, fodd)
VALUES
    ('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01'),
    ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01'),
    ('min', 'DIDD', 'Minerva', 'McGonagall', 'K', 40000, '1955-05-05'),
    ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', NULL, '1952-05-02'),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', NULL, '1943-04-03'),
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06'),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06'),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'K', 35000, '1948-04-08')
;
-- Update a column value
UPDATE larare SET lon = 30000 WHERE akronym = 'gyl';

UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym = 'gyl'
        OR akronym = 'ala'
;

UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym IN ('gyl', 'ala')
;

UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;
-- make a copy larare and call it larare_pre
DROP TABLE IF EXISTS larare_pre;
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

--
-- insert into kurs
--
DELETE FROM kurs;

LOAD DATA LOCAL INFILE './kurs.csv'
INTO TABLE kurs
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

-- SELECT * FROM kurs;

--
-- insert into kurstillfalle
--
DELETE FROM kurstillfalle;

LOAD DATA LOCAL INFILE './kurstillfalle.csv'
INTO TABLE kurstillfalle
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(kurskod, kursansvarig, lasperiod)
;

-- SELECT * FROM kurstillfalle;
