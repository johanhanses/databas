--
-- Create procedure for select * from category
--
DROP PROCEDURE IF EXISTS show_category;
DELIMITER ;;
CREATE PROCEDURE show_category()
BEGIN
    SELECT * FROM prod_cat;
END
;;
DELIMITER ;

-- CALL show_category();

--
-- Create procedure for select from product and other tables
-- prod_id, prod_ description, prod_price, warehouse_items, cat_description
--
DROP PROCEDURE IF EXISTS show_product;
DELIMITER ;;
CREATE PROCEDURE show_product()
BEGIN
    SELECT
        `p`.`id` AS `id`,
        `p`.`description` AS `article`,
        `p`.`price` AS `price`,
        GROUP_CONCAT(`c`.`category`) AS `category`,
        `w`.`items` AS `stock`
    FROM `product` AS `p`
        LEFT JOIN `producttocat` AS `p2c`
            ON `p`.`id` = `p2c`.`prod_id`
        LEFT JOIN `prod_cat` AS `c`
            ON `c`.`id`= `p2c`.`cat_id`
        LEFT JOIN `warehouse` AS `w`
            ON `p`.`id` = `w`.`product_id`
    GROUP BY `p`.`id`, `w`.`items`
    ;
END
;;
DELIMITER ;
-- CALL show_product();

--
-- create procedure for insert into account
--
DROP PROCEDURE IF EXISTS create_product;
DELIMITER ;;
CREATE PROCEDURE create_product (
    a_id INT,
    a_description VARCHAR(40),
    a_price INT
)
BEGIN
    INSERT INTO product VALUES (a_id, a_description, a_price);
END
;;
DELIMITER ;
-- CALL create_product(8, "PJH metal", 33);

--
-- Create procedure for select * from product
--
DROP PROCEDURE IF EXISTS show_productonly;
DELIMITER ;;
CREATE PROCEDURE show_productonly()
BEGIN
    SELECT * FROM product;
END
;;
DELIMITER ;

-- CALL show_productonly();

--
-- Create procedure for select from a specific product
--
DROP PROCEDURE IF EXISTS show_a_product;
DELIMITER ;;
CREATE PROCEDURE show_a_product(
    a_id INT
)
BEGIN
    SELECT * FROM product WHERE id = a_id;
END
;;
DELIMITER ;

-- CALL show_a_product(6);

--
-- Create procedure for edit product details
--
DROP PROCEDURE IF EXISTS edit_product;
DELIMITER ;;
CREATE PROCEDURE edit_product(
    a_id INT,
    a_description VARCHAR(40),
    a_price INT
)
BEGIN
    UPDATE product SET
        `description` = a_description,
        `price` = a_price
    WHERE
        `id` = a_id;
END
;;
DELIMITER ;

-- CALL edit_product();

--
-- Create procedure for deleting a specific product
--
DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(
    a_id INT
)
BEGIN
    DELETE FROM product WHERE id = a_id;
END
;;
DELIMITER ;

-- CALL delete_product(8);

--
-- View event_log at a specified number of entries.
--
DROP PROCEDURE IF EXISTS show_log;
DELIMITER ;;
CREATE PROCEDURE show_log(
    a_number INT
)
BEGIN
    SELECT
        id,
        `when`,
        CONCAT(event, what) AS what
    FROM event_log
    ORDER by id DESC
    LIMIT a_number
    ;
END
;;
DELIMITER ;

-- CALL show_log(8);

--
-- View shelves at the warehouse
--
DROP PROCEDURE IF EXISTS show_shelf;
DELIMITER ;;
CREATE PROCEDURE show_shelf()
BEGIN
    SELECT * FROM warehouse_shelf;
END
;;
DELIMITER ;

-- CALL show_shelf();

--
-- Create procedure for select from product and other tables
-- prod_id, prod_ description, warehouse_shelf_description, warehouse_items
--
DROP PROCEDURE IF EXISTS show_inventory;
DELIMITER ;;
CREATE PROCEDURE show_inventory()
BEGIN
    SELECT
        `p`.`id` AS `id`,
        `p`.`description` AS `article`,
        `ws`.`description` AS `shelf`,
        `w`.`items` AS `stock`
    FROM `product` AS `p`
        LEFT JOIN `warehouse` AS `w`
            ON `p`.`id` = `w`.`product_id`
        LEFT JOIN `warehouse_shelf` AS `ws`
            ON `ws`.`shelf_id` = `w`.`shelf_id`
    GROUP BY `p`.`id`, `ws`.`description`, `w`.`items`
    ;
END
;;
DELIMITER ;
-- CALL show_inventory();

-- create a view of the previous inner joins
DROP VIEW IF EXISTS v_inventory;
CREATE VIEW v_inventory
AS
SELECT
    `p`.`id` AS `id`,
    `p`.`description` AS `article`,
    `ws`.`description` AS `shelf`,
    `w`.`items` AS `stock`
FROM `product` AS `p`
    LEFT JOIN `warehouse` AS `w`
        ON `p`.`id` = `w`.`product_id`
    LEFT JOIN `warehouse_shelf` AS `ws`
        ON `ws`.`shelf_id` = `w`.`shelf_id`
GROUP BY `p`.`id`, `ws`.`description`, `w`.`items`
;
-- SELECT * FROM v_inventory;

--
-- Create procedure for select from v_inventory by searchstring
--
DROP PROCEDURE IF EXISTS search_product;
DELIMITER ;;
CREATE PROCEDURE search_product(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        `id`,
        `article`,
        `shelf`,
        `stock`
    FROM `v_inventory`
    WHERE
        `id` LIKE a_search
        OR `article` LIKE a_search
        OR `shelf` LIKE a_search
    ;
END
;;
DELIMITER ;

-- CALL search_product("%2%");

--
-- Create procedure to add to items in the warehouse
--
DROP PROCEDURE IF EXISTS add_to_shelf;
DELIMITER ;;
CREATE PROCEDURE add_to_shelf(
    a_id INT,
    a_shelf VARCHAR(5),
    a_stock INT
)
BEGIN
    DECLARE current_stock INT;
    DECLARE b_shelf VARCHAR(5);

    START TRANSACTION;

    SET current_stock = (SELECT items FROM warehouse WHERE product_id = a_id);

    SELECT current_stock;

    SET b_shelf = (SELECT shelf_id FROM warehouse_shelf WHERE description = a_shelf);

    IF current_stock IS NOT NULL THEN
        UPDATE warehouse
            SET
                items = items + a_stock
            WHERE
                product_id = a_id;
    ELSEIF current_stock IS NULL THEN
        INSERT INTO warehouse
            (product_id, shelf_id, items)
        VALUES
            (a_id, b_shelf, a_stock);
    END IF;

    COMMIT;

END
;;
DELIMITER ;

-- CALL add_to_shelf(6, "A:101", 100);
-- SELECT * FROM v_inventory;


--
-- Create procedure to subtract from items in the warehouse
--
DROP PROCEDURE IF EXISTS remove_from_shelf;
DELIMITER ;;
CREATE PROCEDURE remove_from_shelf(
    a_id INT,
    a_shelf VARCHAR(10),
    a_stock INT
)
BEGIN
    DECLARE current_stock INT;
    DECLARE b_shelf VARCHAR(5);

    START TRANSACTION;

    SET current_stock = (SELECT items FROM warehouse WHERE product_id = a_id);
    SELECT current_stock;

    SET b_shelf = (SELECT description FROM warehouse_shelf WHERE description = a_shelf);
    SELECT b_shelf;

    IF current_stock > 0 THEN
        UPDATE warehouse
            SET
                items = items - a_stock
            WHERE
                product_id = a_id
                AND b_shelf = a_shelf;
    ELSE
        ROLLBACK;
        SELECT "Can't remove stock from this product";

    END IF;

    COMMIT;

END
;;
DELIMITER ;

-- CALL remove_from_shelf(3, "C:101", 10);

--
-- Create procedure for select * from customer
--
DROP PROCEDURE IF EXISTS show_customer;
DELIMITER ;;
CREATE PROCEDURE show_customer()
BEGIN
    SELECT * FROM customer;
END
;;
DELIMITER ;

-- CALL show_customer();

--
-- create procedure for insert into order
--
DROP PROCEDURE IF EXISTS create_order;
DELIMITER ;;
CREATE PROCEDURE create_order (
    a_id INT
)
BEGIN
    INSERT INTO `order` (customer_id) VALUES (a_id);
END
;;
DELIMITER ;
-- CALL create_order();

--
-- Create procedure for select * from customer
--
DROP PROCEDURE IF EXISTS show_all_order;
DELIMITER ;;
CREATE PROCEDURE show_all_order()
BEGIN
    SELECT
        `o`.*,
        order_status(o.created, o.updated, o.deleted, o.ordered, o.shiped) AS `status`,
        COUNT(`or`.`id`) AS `number_of_rows`
    FROM `order` AS `o`
        LEFT JOIN `order_row` AS `or`
            ON `o`.`id` = `or`.`order`
    GROUP BY `o`.`id`;
END
;;
DELIMITER ;

-- CALL show_all_order();

--
-- Create procedure for select * from customer
--
DROP PROCEDURE IF EXISTS show_order_info;
DELIMITER ;;
CREATE PROCEDURE show_order_info(
    a_id INT
)
BEGIN
    SELECT
        `o`.`customer_id`,
        `o`.`id` AS `order_id`,
        `c`.*,
        `c`.`id` AS `c_id`,
        `or`.*,
        `or`.`id` AS `row_id`,
        `p`.`id` AS `p_id`,
        `p`.`description` AS `article`,
        `p`.`price`
    FROM `order` AS `o`
        LEFT JOIN `customer` AS `c`
            ON `c`.`id` = `o`.`customer_id`
        LEFT JOIN `order_row` AS `or`
            ON `or`.`order` = `o`.`id`
        LEFT JOIN `product` AS `p`
            ON `p`.`id` = `or`.`product`
    WHERE `o`.`id` = a_id;
END
;;
DELIMITER ;

-- CALL show_order_info();

--
-- Insert into order_row table
--
DROP PROCEDURE IF EXISTS create_order_row;
DELIMITER ;;
CREATE PROCEDURE create_order_row(
    a_order INT,
    a_product INT,
    a_items INT
)
BEGIN
    INSERT INTO order_row
        (`order`, `product`, `items`)
    VALUES
        (a_order, a_product, a_items);
END
;;
DELIMITER ;

-- CALL create_order_row(9, 9, 12);


-- create a View
DROP VIEW IF EXISTS v_order;
CREATE VIEW v_order
AS
SELECT
    `o`.*,
    order_status(o.created, o.updated, o.deleted, o.ordered, o.shiped) AS `status`,
    COUNT(`or`.`id`) AS `number_of_rows`
FROM `order` AS `o`
    LEFT JOIN `order_row` AS `or`
        ON `o`.`id` = `or`.`order`
GROUP BY `o`.`id`;

-- SELECT * from v_order;
--
-- create procedure for setting a timestamp to ordered column in order table
--
DROP PROCEDURE IF EXISTS send_order;
DELIMITER ;;
CREATE PROCEDURE send_order(
    a_id INT
)
BEGIN
    DECLARE a_rows INT;

    SET a_rows = (SELECT number_of_rows FROM v_order WHERE id = a_id);
    -- SELECT a_rows;

    IF a_rows > 0 THEN
    UPDATE `order`
        SET `ordered` = CURRENT_TIMESTAMP
    WHERE `id` = a_id;
    END IF;
END
;;
DELIMITER ;

-- CALL send_order(1);

--
-- Create procedure for showing order info in the terminal
--
DROP PROCEDURE IF EXISTS show_all_about_order;
DELIMITER ;;
CREATE PROCEDURE show_all_about_order()
BEGIN
    SELECT
        `o`.`id`,
        `o`.`created`,
        `o`.`customer_id`,
        order_status(o.created, o.updated, o.deleted, o.ordered, o.shiped) AS `status`,
        COUNT(`or`.`id`) AS `number_of_rows`
    FROM `order` AS `o`
        LEFT JOIN `order_row` AS `or`
            ON `o`.`id` = `or`.`order`
    GROUP BY `o`.`id`;
END
;;
DELIMITER ;

-- CALL show_all_about_order();
