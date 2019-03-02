--
-- Alter from database skolan.
-- By johv18 for course databas.
-- 2019-01-17
--
-- Add column to TABLE
ALTER TABLE larare ADD COLUMN kompetens INT;
ALTER TABLE larare DROP COLUMN kompetens;
ALTER TABLE larare ADD COLUMN kompetens INT DEFAULT 1 NOT NULL;











SELECT * FROM larare;

SELECT akronym, fornamn, kompetens FROM larare;

SHOW COLUMNS FROM larare;
