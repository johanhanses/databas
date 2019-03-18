--
-- functions for database eshop
--
DROP FUNCTION IF EXISTS order_status;
DELIMITER ;;
CREATE FUNCTION order_status(
    a_created DATETIME,
    a_updated DATETIME,
    a_deleted DATETIME,
    a_ordered DATETIME,
    a_shiped DATETIME
)
RETURNS CHAR(10)
DETERMINISTIC
-- RETURNS VARCHAR(30)
BEGIN
    IF a_shiped IS NOT NULL THEN
        RETURN "skickad";
    ELSEIF a_deleted IS NOT NULL THEN
        RETURN "raderad";
    ELSEIF a_ordered IS NOT NULL THEN
        RETURN "beställd";
    ELSEIF a_updated IS NOT NULL THEN
        RETURN "updaterad";
    ELSEIF a_created IS NOT NULL THEN
        RETURN "skapad";
    END IF;
END
;;

DELIMITER ;

-- SELECT id, order_status(created, updated, deleted, ordered, shiped) FROM `order`;
