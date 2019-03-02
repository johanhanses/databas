--
-- Select from database skolan.
-- By johv18 for course databas.
-- 2019-01-19
--
SELECT *
    FROM larare
    WHERE avdelning = 'DIDD'
;

SELECT *
    FROM larare
    WHERE akronym
    LIKE 'h%'
;

SELECT *
    FROM larare
    WHERE fornamn
    LIKE '%o%'
;

SELECT *
    FROM larare
    WHERE lon >= 30000
    AND lon <= 50000
;

SELECT *
    FROM larare
    WHERE kompetens < 7
    AND lon > 40000
;

SELECT *
    FROM larare
    WHERE akronym
    IN ('sna', 'dum', 'min')
;

SELECT *
    FROM larare
    WHERE lon > 80000
    OR kompetens = 2
    AND avdelning = 'ADM'
;

SELECT fornamn, efternamn, lon
    FROM larare
;

SELECT fornamn, efternamn, lon
    FROM larare
    ORDER BY efternamn DESC
;

SELECT fornamn, efternamn, lon
    FROM larare
    ORDER BY efternamn ASC
;

SELECT fornamn, efternamn, lon
    FROM larare
    ORDER BY lon ASC
;

SELECT fornamn, efternamn, lon
    FROM larare
    ORDER BY lon DESC
;

SELECT fornamn, efternamn, lon
    FROM larare
    ORDER BY lon DESC
    LIMIT 3
;

--
-- Change namn of a column
--
SELECT
    fornamn AS 'Lärare',
    lon AS 'Lön',
    avdelning AS 'Avdelning'
FROM larare;
