--
-- Create database eshop and set a user
--
-- Johan Hanses johv18
--
DROP DATABASE eshop;

CREATE DATABASE IF NOT EXISTS eshop;

USE eshop;

SHOW DATABASES;

-- Create user "user" with password "pass" using a backwards compatible method
CREATE USER IF NOT EXISTS 'user'@'%'
   IDENTIFIED WITH mysql_native_password
   BY 'pass'
;

-- Give user "user" all rights on the database "eshop".
GRANT ALL PRIVILEGES
ON *.*
TO 'user'@'%'
WITH
GRANT OPTION
;

-- View rights.
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
