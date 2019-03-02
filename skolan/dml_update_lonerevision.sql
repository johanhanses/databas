--
-- Update from database skolan.
-- By johv18 for course databas.
-- 2019-01-18
--
SELECT
    SUM(lon) AS Lönesumma,
    SUM(kompetens) AS Kompetens
FROM larare
;



SELECT
    SUM(lon) * 0.064 AS Lönesumma
FROM larare
;

UPDATE larare
    SET
        kompetens = 7,
        lon = 85000
    WHERE
        fornamn = 'Albus'
;

UPDATE larare
    SET
        lon = lon + 4000
    WHERE
        fornamn = 'Minerva'
;

UPDATE larare
    SET
        kompetens = 3,
        lon = lon + 2000
    WHERE
        fornamn = 'Argus'
;

UPDATE larare
    SET
        lon = lon - 3000
    WHERE
        fornamn IN ('Gyllenroy', 'Alastor')
;

UPDATE larare
    SET
        lon = lon * 1.02
    WHERE
        avdelning = 'DIDD'
;

UPDATE larare
    SET
        lon = lon * 1.03
    WHERE
        fornamn = 'Madam'
;

UPDATE larare
    SET
        kompetens = kompetens + 1,
        lon = lon + 5000
    WHERE
        fornamn IN ('Hagrid', 'Minerva', 'Severus')
;

UPDATE larare
    SET
        lon = lon * 1.022
    WHERE
        fornamn IN ('Alastor', 'Argus', 'Gyllenroy', 'Madam')
;

SELECT
    SUM(lon) AS Lönesumma
FROM larare
;

SELECT
    concat(round(( SUM(lon)/305000) * 100 -100 ,4),'%')
    AS Lönesumma_ökning_procent
FROM larare
;


SELECT
    SUM(kompetens) AS Kompetens
FROM larare
;

-- SELECT akronym, avdelning, fornamn, kon, lon, kompetens
-- FROM larare
-- ORDER BY lon DESC
-- ;
