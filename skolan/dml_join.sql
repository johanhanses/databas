--
-- 'Join' in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-01-25
--

--
-- Join
--
SELECT
    l.akronym,
    l.lon,
    l.kompetens,
    p.lon AS "pre-lon",
    p.kompetens AS "pre-kompetens"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY akronym
;

-- Visa de lärare som inte har fått en löneökning om minst 3%.
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
-- Kör
SELECT * FROM v_lonerevision;

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
-- Kör
SELECT * FROM Vlonerevision;

-- HURRA!
