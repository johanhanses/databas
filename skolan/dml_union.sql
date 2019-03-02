--
-- 'Union' in SQL in database skolan.
-- By johv18 for course databas.
-- 2019-01-25
--

--
-- Union
--
SELECT
    *,
    'after' AS origin FROM larare
UNION
SELECT
    *,
    'before' AS origin FROM larare_pre
ORDER BY akronym
;

SELECT
    lon.origin,
    akronym,
    fornamn,
    efternamn,
    kon,
    kompetens,
    lon
FROM
(
        SELECT
            *,
            'after' AS origin FROM larare
        UNION
        SELECT
            *,
            'before' AS origin FROM larare_pre
        ORDER BY akronym
) AS lon
WHERE
    akronym IN ('ala', 'dum')
ORDER BY akronym, origin
;
