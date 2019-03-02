--
-- Outer joins in the database skolan
--
-- by Johan Hanses johv18
-- 2019-02-13
--

-- Vi tittar vilka lärare som ansvarar för minst ett kurstillfälle.
SELECT DISTINCT
    akronym AS Akronym,
    CONCAT(fornamn, " ", efternamn) AS Namn
FROM v_planering
ORDER BY akronym
;

--
-- Outer join, inkludera lärare utan undervisning
--
-- left outer join
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ",  l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS kurskod
FROM larare AS l
    LEFT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;
-- Right outer join
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ",  l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS kurskod
FROM larare AS l
    RIGHT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

-- kurser utan kurstillfällen
SELECT DISTINCT
    k.kod AS Kurskod,
    k.namn AS Namn,
    kt.lasperiod AS Läsperiod
FROM kurs AS k
    LEFT OUTER JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
WHERE kt.lasperiod IS NULL
;
