-- Skapa databas
-- CREATE DATABASE skolan;
CREATE DATABASE IF NOT EXISTS skolan;

-- Välj vilken databasdu vill använda
USE skolan;

-- -- Radera en databas med allt innehåll
-- DROP DATABASE skolan;
--

-- -- Visa vilka databaser som finns
-- SHOW DATABASES;

-- Visa vilka databaser som finns som heter något i stil med *skolan*
SHOW DATABASES LIKE "%skolan%";

-- -- Skapa en användare user med lösenordet pass och ge tillgång oavsett hostnamn.
-- CREATE USER IF NOT EXISTS 'user'@'%'
--     IDENTIFIED BY 'pass'
-- ;

-- Skapa användaren med en bakåtkompatibel lösenordsalgoritm.
CREATE USER IF NOT EXISTS 'user'@'%'
   IDENTIFIED WITH mysql_native_password
   BY 'pass'
;

-- -- Ta bort en användare
-- DROP USER 'user'@'%';
-- DROP USER IF EXISTS 'user'@'%';

-- Ge användaren alla rättigheter på en specifik databas.
GRANT ALL PRIVILEGES
    ON skolan.*
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

-- create a new user from root
DROP USER IF EXISTS 'dbwebb'@'%';

CREATE USER 'dbwebb'@'%'
IDENTIFIED
WITH mysql_native_password -- Only MySQL > 8.0.4
BY 'password'
;

GRANT ALL PRIVILEGES
ON *.*
TO 'dbwebb'@'%'
WITH GRANT OPTION;
;

SHOW VARIABLES LIKE "%version%";

-- Check the status for users root, dbwebb and user.

SELECT
    User,
    Host,
    Grant_priv,
    plugin
FROM mysql.user
WHERE
    User IN ('root', 'dbwebb', 'user')
ORDER BY User
;
