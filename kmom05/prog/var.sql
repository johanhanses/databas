--
-- Define and use local variable
--
SET @answer = 42;
SELECT @answer;

-- Set local variable from a resultset
SET @answer = (SELECT 42);
SELECT @answer;

-- SELECT mulltiple into variable

SELECT 1, 2 INTO @a, @b;
SELECT @a, @b;
