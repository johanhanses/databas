--
-- Example transactions
--
DROP TABLE IF EXISTS account;
CREATE TABLE account
(
    `id` CHAR(4) PRIMARY KEY,
    `name` VARCHAR(8),
    `balance` DECIMAL(4, 2)
);

DELETE FROM account;
INSERT INTO account
VALUES
    ("1111", "Adam", 10.0),
    ("2222", "Eva", 7.0)
;

SELECT * FROM account;

--
-- Log table
--
DROP TABLE IF EXISTS account_log;
CREATE TABLE account_log
(
    `id` INT AUTO_INCREMENT,
    `when` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `what` VARCHAR(20),
    `account` CHAR(4),
    `balance` DECIMAL(4 ,2),
    `amount` DECIMAL(4 ,2),

    PRIMARY KEY (`id`)
);

--
-- Trigger for logging updating balance
--
DROP TRIGGER IF EXISTS log_balance_update;

CREATE TRIGGER log_balance_update
AFTER UPDATE
ON account FOR EACH ROW
    INSERT INTO account_log (`what`, `account`, `balance`, `amount`)
        VALUES ('trigger', NEW.id, NEW.balance, NEW.balance - OLD.balance);

--
-- Trigger with compound statement
--
DROP TRIGGER IF EXISTS trigger_test1;

DELIMITER ;;

CREATE TRIGGER trigger_test1
AFTER UPDATE
ON account FOR EACH ROW
BEGIN

END
;;

DELIMITER ;


--
-- Trigger with compound statement and user defined errors
--
DROP TRIGGER IF EXISTS trigger_test2;

DELIMITER ;;

CREATE TRIGGER trigger_test2
BEFORE UPDATE
ON account FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET message_text = 'My Error Message';
END
;;

DELIMITER ;

SHOW TRIGGERS;
SHOW TRIGGERS LIKE 'account' \G;
SHOW TRIGGERS FROM dbwebb \G;

DROP TRIGGER IF EXISTS trigger_test1;
DROP TRIGGER IF EXISTS trigger_test2;

SHOW CREATE TRIGGER log_balance_update \G;
