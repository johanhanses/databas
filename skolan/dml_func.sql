--
-- Functions in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-01-24
--

-- Skriv en SELECT-sats som skriver ut förnamn + efternamn + avdelning i samma kolumn enligt följande struktur: förnamn efternamn (avdelning).
SELECT
    CONCAT(fornamn, " ", efternamn, " ", "(", avdelning, ")") AS NamnAvdelning
FROM larare
;

-- Gör om samma sak men skriv ut avdelningens namn med små bokstäver och begränsa utskriften till 3 rader.
SELECT
    CONCAT(fornamn, " ", efternamn, " ", "(", LOWER(avdelning), ")") AS NamnAvdelning
FROM larare
LIMIT 3
;

-- Skriv en SELECT-sats som endast visar dagens datum.

SELECT
    CURDATE()
    AS 'Dagens datum'
;

-- Gör en SELECT-sats som visar samtliga lärare, deras födelseår samt dagens datum och klockslag.
SELECT
    fornamn,
    fodd,
    CURDATE() AS 'Dagens datum',
    CURTIME() AS Klockslag
FROM larare;

-- Skriv en SELECT-sats som beräknar lärarens ålder, sortera rapporten för att visa vem som är äldst och yngst.
SELECT
    fornamn,
    fodd,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder
FROM larare
ORDER BY Ålder DESC
;

-- Filtrera per del av datum

SELECT
    fornamn,
    fodd,
    MONTHNAME(fodd) AS Månad
FROM larare
;

SELECT
    fornamn,
    fodd,
    MONTHNAME(fodd) AS Månad
FROM larare
WHERE MONTH(fodd) = 5
;

-- Visa de lärare som är födda på 40-talet.

SELECT
    fornamn,
    fodd,
    YEAR(fodd) AS År
FROM larare
WHERE YEAR(fodd) LIKE '194%'
;
