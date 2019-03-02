--
-- Aggregate in database skolan.
-- By johv18 for course databas.
-- 2019-01-24
--

SELECT
    SUM(lon)
FROM larare
;

SELECT
    MAX(lon)
FROM larare
;

SELECT
    MIN(lon)
FROM larare
;

SELECT
    AVG(kompetens)
FROM larare
;
-- Visa snittkompetens per avdelning
SELECT
    avdelning,
    AVG(kompetens)
FROM larare
GROUP BY avdelning
;

-- Hur många lärare jobbar på de olika avdelningarna?
SELECT
    avdelning,
    COUNT(akronym) AS antal_lärare
FROM larare
GROUP BY avdelning
;

-- Hur mycket betalar respektive avdelning ut i lön varje månad?
SELECT
    avdelning,
    SUM(lon) AS summa_lön
FROM larare
GROUP BY avdelning
;

-- Hur mycket är medellönen för de olika avdelningarna?
SELECT
    avdelning,
    ROUND(AVG(lon), 2) AS medellön
FROM larare
GROUP BY avdelning
;

-- Hur mycket är medellönen för kvinnor kontra män?
SELECT
    kon AS kön,
    ROUND(AVG(lon), 2) AS medellön
FROM larare
GROUP BY kon
;

-- Visa snittet på kompetensen för alla avdelningar, sortera på kompetens i sjunkande ordning och visa enbart den avdelning som har högst kompetens.
SELECT
    avdelning,
    AVG(kompetens) AS snittkompetens
FROM larare
GROUP BY avdelning
ORDER BY snittkompetens DESC
LIMIT 1
;

-- Visa den avrundade snittlönen (ROUND()) grupperad per avdelning och per kompetens, sortera enligt avdelning och snittlön.

SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon), 0) AS Snittlön
FROM larare
GROUP BY
    avdelning,
    kompetens
ORDER BY
    avdelning ASC,
    Snittlön DESC
;
-- Having delen av aggregerande sql

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(lon) AS Antal
FROM larare
-- WHERE kompetens = 1
GROUP BY avdelning
ORDER BY avdelning
;
-- visa vilka avdelningar som tjänar över 40000 i snitt

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(lon) AS Antal
FROM larare
GROUP BY avdelning
HAVING Snittlön > 40000
ORDER BY avdelning
;
-- variation

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlön,
    COUNT(lon) AS Antal
FROM larare
WHERE kompetens = 1
GROUP BY avdelning
HAVING Snittlön > 30000
ORDER BY avdelning
;
-- Visa per avdelning de kompetenser som finns och hur många anställda det finns per kompetens samt gruppens snittlön, men visa bara för kompetenser som är lägre än 7 och bara om gruppens snittlön är mellan 30 000 - 45 000. Sortera per kompetens i sjunkande ordning.

SELECT
    avdelning,
    kompetens,
    COUNT(kompetens) AS Antal,
    ROUND(AVG(lon), 0) AS Snittlön
FROM larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens < 7
    AND Snittlön >= 30000
    AND Snittlön <= 45000
ORDER BY
    kompetens DESC
;
