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
