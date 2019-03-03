--
-- Create functions
--

USE dbwebb;

DROP FUNCTION IF EXISTS grade;
DELIMITER ;;

CREATE FUNCTION grade(
    score INT
)
RETURNS INT
BEGIN
    RETURN score;
END
;;

DELIMITER ;

SELECT
    *,
    grade(score) AS 'grade'
FROM exam;
-- --------
DROP FUNCTION IF EXISTS grade;
DELIMITER ;;

CREATE FUNCTION grade(
    score INT
)
RETURNS CHAR(2)
DETERMINISTIC
BEGIN
    IF score >= 90 THEN
        RETURN 'A';
    ELSEIF score >= 80 THEN
        RETURN 'B';
    ELSEIF score >= 70 THEN
        RETURN 'C';
    ELSEIF score >= 60 THEN
        RETURN 'D';
    ELSEIF score >= 55 THEN
        RETURN 'E';
    ELSEIF score >= 50 THEN
        RETURN 'FX';
    END IF;
    RETURN 'F';
END
;;

DELIMITER ;

SELECT
    *,
    grade(score) AS 'grade'
FROM exam
ORDER BY grade;

-- ------------------
DROP FUNCTION IF EXISTS grade2;
DELIMITER ;;

CREATE FUNCTION grade2(
    score INT
)
RETURNS CHAR(1)
BEGIN
    IF score >= 90 THEN
        RETURN '5';
    ELSEIF score >= 70 THEN
        RETURN '4';
    ELSEIF score >=55 THEN
        RETURN '3';
    END IF;
    RETURN 'U';
END
;;

DELIMITER ;

SELECT
    *,
    grade(score) AS 'A-F, FX',
    grade2(score) AS 'U, 3-5'
FROM exam
ORDER BY score DESC;

-- ----------------------------
DROP FUNCTION IF EXISTS time_of_the_day;
DELIMITER ;;

CREATE FUNCTION time_of_the_day()
RETURNS DATETIME
NOT DETERMINISTIC NO SQL
BEGIN
    RETURN NOW();
END
;;

DELIMITER ;

SELECT time_of_the_day();

SHOW FUNCTION STATUS;
SHOW FUNCTION STATUS LIKE 'grade' \G;
SHOW FUNCTION STATUS WHERE Db = 'dbwebb';
SHOW CREATE FUNCTION grade \G
