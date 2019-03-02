-- Skapa databas
-- CREATE DATABASE dbwebb;
CREATE DATABASE IF NOT EXISTS dbwebb;

-- Välj vilken databasdu vill använda
USE dbwebb;

-- Skapa användaren med en bakåtkompatibel lösenordsalgoritm.
CREATE USER IF NOT EXISTS 'user'@'%'
   IDENTIFIED WITH mysql_native_password
   BY 'pass'
;

-- Ge användaren alla rättigheter på en specifik databas.
GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'@'%'
;

GRANT ALL PRIVILEGES
    ON *.*
    TO 'user'@'%'
    WITH GRANT OPTION;
;

-- -- Skapa användaren "user" med
-- -- lösenordet "pass" och ge
-- -- fulla rättigheter till databasen "skolan"
-- -- när användaren loggar in från maskinen "localhost"
-- GRANT ALL ON skolan.* TO user@localhost IDENTIFIED BY 'pass';

-- Visa vad en användare kan göra mot vilken databas.
-- SHOW GRANTS FOR 'user'@'%';

-- -- Visa för nuvarande användaren
-- SHOW GRANTS FOR CURRENT_USER;


-- Check the status for users root, and user.
SELECT
    User,
    Host,
    Grant_priv,
    plugin
FROM mysql.user
WHERE
    User IN ('root', 'user')
ORDER BY User
;
