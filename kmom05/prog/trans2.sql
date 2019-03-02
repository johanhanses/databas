--
-- Procedure move_money()
--
DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;

CREATE PROCEDURE move_money(
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
MAIN:BEGIN
    DECLARE current_balance NUMERIC(4, 2);

    START TRANSACTION;

    SELECT balance INTO current_balance FROM account WHERE id = from_account;

    SELECT current_balance;

    IF current_balance - amount < 0 THEN
        ROLLBACK;
        SELECT 'The amount on the account is not enough to make transaction.' AS message;
        LEAVE MAIN;
    END IF;

    UPDATE account
        SET
            balance = balance + amount
        WHERE
            id = to_account;

    UPDATE account
        SET
            balance = balance - amount
        WHERE
            id = from_account;

    -- INSERT INTO
    --     account_log (what, account, amount)
    --     VALUES
    --         ('move_money from', from_account, - amount),
    --         ('move_money to', to_account, amount);

    COMMIT;
    SELECT * FROM account;
    SELECT * FROM account_log;

END
;;

DELIMITER ;

CALL move_money('1111', '2222', 1.5);

-- --------------------------------------

DROP PROCEDURE IF EXISTS get_money;

DELIMITER ;;

CREATE PROCEDURE get_money(
    IN a_account CHAR(4),
    OUT a_total NUMERIC(4, 2)
)
BEGIN
    SELECT balance INTO a_total FROM account WHERE id = a_account;
END
;;

DELIMITER ;

CALL get_money('1111', @sum);
SELECT @sum;

-- SHOW PROCEDURE STATUS LIKE '%money';
--
-- SHOW CREATE PROCEDURE move_money \G;
