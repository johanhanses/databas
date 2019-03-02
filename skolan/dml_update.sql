--
-- Update from database skolan.
-- By johv18 for course databas.
-- 2019-01-17
--

--
-- Update a column value
--
UPDATE larare SET lon = 30000 WHERE akronym = 'gyl';

UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym = 'gyl'
        OR akronym = 'ala'
;

UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym IN ('gyl', 'ala')
;

UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;

SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC;



-- SELECT * FROM larare;
