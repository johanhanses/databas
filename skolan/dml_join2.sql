--
-- more joins in the database skolan
--
-- by Johan Hanses johv18
-- 2019-02-12
--

-- a crossjoin
SELECT *
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod;

-- join using JOIN..ON
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod;

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

-- I rapporten visar du lärarens akronym och namn följt av antalet kurstillfällen som hen är kursanvarig för. Sortera per antal tillfällen och därefter per akronym.

SELECT
    akronym as Akronym,
    CONCAT(fornamn, ' ', efternamn) AS Namn,
    COUNT(kursansvarig) AS Tillfallen
FROM v_planering
GROUP BY kursansvarig
ORDER BY Tillfallen DESC, akronym
;

-- Förslagsvis så börjar du att ta reda på vilka lärare som har högst ålder, bara för att kontrollera vilka lärare det skulle kunna handla om.

SELECT
    akronym,
    fornamn,
    efternamn,
    fodd,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS ålder
FROM larare
order by ålder DESC
LIMIT 3
;

-- SELECT * FROM v_planering;


-- Du behöver de tre äldsta lärarna som också undervisar på kurser.
SELECT
    CONCAT(namn, " (", kurskod, ")") as Kursnamn,
    CONCAT(fornamn, " ", efternamn, " (", akronym,")") as Larare,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Alder
FROM v_planering
HAVING Alder > 66
ORDER BY Alder DESC
;
