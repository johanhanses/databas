--
-- 'Copy' in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-01-25
--

--
-- Make copy of table
--
DROP TABLE IF EXISTS larare_pre;
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

-- Check the content of the tables, for sanity checking
SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare
;

SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare_pre
;
