--
-- Index
--
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`
(
    `code` CHAR(6),
    `nick` CHAR(12),
    `points` DECIMAL(3, 1),
    `name` VARCHAR(60)
);

DELETE FROM course;
INSERT INTO course
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;

SELECT * FROM course;

EXPLAIN course;

EXPLAIN SELECT * FROM course;

SELECT * FROM course WHERE code ='PA1444';

EXPLAIN SELECT * FROM course WHERE code ='PA1444';

ALTER TABLE course ADD PRIMARY KEY(code);

EXPLAIN SELECT * FROM course WHERE code ='PA1444';

EXPLAIN SELECT * FROM course WHERE nick = 'dbjs';

ALTER TABLE course ADD CONSTRAINT nick_unique UNIQUE (nick);

EXPLAIN SELECT * FROM course WHERE nick = 'dbjs';

EXPLAIN course;
-- now with primary key and unique
SHOW INDEX FROM course;
-- remove UNIQUE
DROP INDEX nick_unique ON course;

SHOW INDEX FROM course;
-- create unique again
CREATE UNIQUE INDEX nick_unique ON course (nick);

SHOW INDEX FROM course;

DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`
(
    `code` CHAR(6),
    `nick` CHAR(12),
    `points` DECIMAL(3, 1),
    `name` VARCHAR(60),

    PRIMARY KEY (`code`),
    UNIQUE KEY `nick_unique` (`nick`)
);

DELETE FROM course;
INSERT INTO course
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;

EXPLAIN course;

SHOW INDEX FROM course;

SELECT * FROM course WHERE name LIKE 'Webb%';

EXPLAIN SELECT * FROM course WHERE name LIKE 'Webb%';

CREATE INDEX index_name ON course(name);

EXPLAIN SELECT * FROM course WHERE name LIKE 'Webb%';

EXPLAIN course;

EXPLAIN SELECT * FROM course WHERE name LIKE '%prog%';

EXPLAIN SELECT * FROM course WHERE name LIKE '%Python%';

CREATE FULLTEXT INDEX full_name ON course(name);

SELECT
    name,
    MATCH(name) AGAINST ('Program* web' IN BOOLEAN MODE) AS score
FROM course
ORDER BY score DESC
;

SELECT * FROM course WHERE points > 7.5;

EXPLAIN SELECT * FROM course WHERE points > 7.5;

CREATE INDEX index_points ON course(points);

EXPLAIN SELECT * FROM course WHERE points > 7.5;

SHOW INDEX FROM course;

DROP INDEX full_name ON course;

EXPLAIN course;

SHOW CREATE TABLE course \G

DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`
(
    `code` CHAR(6) NOT NULL DEFAULT '',
    `nick` CHAR(12) DEFAULT NULL,
    `points` DECIMAL(3, 1) DEFAULT NULL,
    `name` VARCHAR(60) DEFAULT NULL,

    PRIMARY KEY (`code`),
    UNIQUE KEY `nick_unique` (`nick`),
    KEY `index_name` (`name`),
    KEY `index_points` (`points`),
    FULLTEXT KEY `full_name`(`name`)
);

DELETE FROM course;
INSERT INTO course
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;

EXPLAIN course;

SHOW INDEX FROM course;
-- profiling logga databasen, långsamma frågor
SET profiling = 1;

SELECT * FROM course WHERE nick ='dbjs';

SELECT * FROM course WHERE name LIKE 'Webb%';

SELECT
    name,
    MATCH(name) AGAINST ('Program* web' IN BOOLEAN MODE) AS score
FROM course
ORDER BY score DESC
;

SHOW PROFILES;

SHOW PROFILE FOR QUERY 56;
