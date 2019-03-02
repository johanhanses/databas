--
-- 'View' in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-01-24
--
SELECT CONCAT(
        fornamn,
        ' ',
        efternamn,
        ' (',
        LOWER(avdelning),
        ')') AS Namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM larare
;

-- skapa vyn
DROP VIEW IF EXISTS v_name_alder;
CREATE VIEW v_name_alder
AS
SELECT
    CONCAT (fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS Namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM larare
;

-- Använd vyn
SELECT * FROM v_name_alder;

-- Begränsa vyn
SELECT * FROM v_name_alder
    WHERE Namn LIKE '%di%'
    ORDER BY Ålder DESC
    LIMIT 3
;

-- -- droppa vyn
-- DROP VIEW v_name_alder;

-- Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare inklusive en ny kolumn med lärarens ålder.
DROP VIEW IF EXISTS v_larare;
CREATE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM larare
;

-- Använd vyn
SELECT * FROM v_larare;

-- Gör en SELECT-sats mot vyn som beräknar medelåldern på respektive avdelning. Visa avdelningens namn och medelålder sorterad på medelåldern.
-- SINNESSJUKT ENKELT I JÄMNFÖRELSE MOT VAD JAG TRODDE FRÅN BÖRJAN!!
SELECT
    avdelning,
    ROUND(AVG(Ålder)) AS Snittålder
FROM v_larare
GROUP BY avdelning
ORDER BY Snittålder DESC
;
