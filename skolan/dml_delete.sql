--
-- Delete from database skolan.
-- By johv18 for course databas.
-- 2019-01-17
--

--
-- Delete rows from table
--
DELETE FROM larare WHERE fornamn = 'Hagrid';
DELETE FROM larare WHERE avdelning = 'DIPT';
DELETE FROM larare WHERE lon IS NOT NULL LIMIT 2;
DELETE FROM larare;





SELECT * FROM larare;
