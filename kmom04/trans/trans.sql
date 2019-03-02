--
-- Move the money, with a transactions
--
START TRANSACTION;

UPDATE account
SET
    balance = balance + 1.5
WHERE
    id = "2222";

UPDATE account
SET
    balance = balance - 1.5

WHERE
    id = "1111";

COMMIT;

SELECT * FROM account;
