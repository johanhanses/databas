--
-- create ddl for database eshop
--
SET NAMES 'utf8';
-- drop the tables if they exist
DROP TABLE IF EXISTS `event_log`;
DROP TABLE IF EXISTS `warehouse`;
DROP TABLE IF EXISTS `warehouse_shelf`;
DROP TABLE IF EXISTS `invoice_row`;
DROP TABLE IF EXISTS `invoice`;
DROP TABLE IF EXISTS `order_row`;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `producttocat`;
DROP TABLE IF EXISTS `prod_cat`;
DROP TABLE IF EXISTS `product`;


-- create product related tables
CREATE TABLE `product`
(
    `id` INT NOT NULL,
    `description` VARCHAR(40),
    `price` INT,

    PRIMARY KEY (`id`),
    -- FOREIGN KEY (`id`) REFERENCES `producttocat`(`prod_id`),
    -- FOREIGN KEY (`id`) REFERENCES `warehouse`(`product_id`),
    KEY `index_description` (`description`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `prod_cat`
(
    `id` INT NOT NULL,
    `category` VARCHAR(45),

    PRIMARY KEY (`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `producttocat`
(
    `id` INT NOT NULL,
    `prod_id` INT,
    `cat_id` INT,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`prod_id`) REFERENCES `product`(`id`),
    FOREIGN KEY (`cat_id`) REFERENCES `prod_cat`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create customer table
CREATE TABLE `customer`
(
    `id` INT NOT NULL,
    `first_name` CHAR(20),
    `last_name` CHAR(20),
    `address` VARCHAR(20),
    `zip_code` VARCHAR(8),
    `city` VARCHAR(20),
    `country` VARCHAR(20),
    `phone` VARCHAR(20),

    PRIMARY KEY (`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create order tables
CREATE TABLE `order`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `customer_id` INT,
    `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated` TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `deleted` TIMESTAMP DEFAULT NULL,
    `ordered` TIMESTAMP DEFAULT NULL,
    `shiped` TIMESTAMP DEFAULT NULL,


    PRIMARY KEY (`id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `order_row`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `order` INT,
    `product` INT,
    `items` INT,

    PRIMARY KEY (`id`)
    -- FOREIGN KEY (`order`) REFERENCES `order`(`id`),
    -- FOREIGN KEY (`product`) REFERENCES `product`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create invoice tables
CREATE TABLE `invoice`
(
    `id` INT NOT NULL,
    `order` INT,
    `customer` INT,
    `created` DATETIME,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`order`) REFERENCES `order`(`id`),
    FOREIGN KEY (`customer`) REFERENCES `customer`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `invoice_row`
(
    `id` INT NOT NULL,
    `invoice` INT,
    `product` INT,
    `items` INT,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`invoice`) REFERENCES `invoice`(`id`),
    FOREIGN KEY (`product`) REFERENCES `product`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create Warehouse tables
CREATE TABLE `warehouse_shelf`
(
    `shelf_id` INT NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(45),

    PRIMARY KEY (`shelf_id`),
    UNIQUE KEY `description_unique` (`description`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `warehouse`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `product_id` INT,
    `shelf_id` INT,
    `items` INT,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`product_id`) REFERENCES `product`(`id`),
    FOREIGN KEY (`shelf_id`) REFERENCES `warehouse_shelf`(`shelf_id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create event_log table
-- CREATE TABLE `event_log`
-- (
--     `id` INT NOT NULL,
--     `order_id` INT,
--     `order_row_id` INT,
--     `order_created` DATETIME,
--     `order_updated` DATETIME,
--     `order_deleted` DATETIME,
--
--     PRIMARY KEY (`id`),
--     FOREIGN KEY (`order_id`) REFERENCES `order`(`id`),
--     FOREIGN KEY (`order_row_id`) REFERENCES `order_row`(`id`)
-- )
-- ENGINE INNODB
-- CHARSET utf8
-- COLLATE utf8_swedish_ci;

-- create event_log table v.2
CREATE TABLE `event_log`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `when` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `event` VARCHAR(200),
    `what` INT,

    PRIMARY KEY(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;
;

-- create a trigger for when a product is being updated in the product table and log the event to table event_log
DROP TRIGGER IF EXISTS `log_product_update`;

CREATE TRIGGER `log_product_update`
AFTER UPDATE
ON `product` FOR EACH ROW
    INSERT INTO `event_log`
        (`event`, `what`)
    VALUES
        ("Detaljer har uppdaterats om produkt med id:", NEW.id)
    ;

-- create a trigger for when a product is being inserted in the product table and log the event to table event_log
DROP TRIGGER IF EXISTS `log_product_insert`;

CREATE TRIGGER `log_product_insert`
AFTER INSERT
ON `product` FOR EACH ROW
    INSERT INTO `event_log`
        (`event`, `what`)
    VALUES
        ("Ny produkt lades till med produkt id:", NEW.id)
    ;

-- create a trigger for when a product has been deleted in the product table and log the event to table event_log
DROP TRIGGER IF EXISTS `log_product_delete`;

CREATE TRIGGER `log_product_delete`
AFTER DELETE
ON `product` FOR EACH ROW
    INSERT INTO `event_log`
        (`event`, `what`)
    VALUES
        ("En produkt har raderats som hade id:", OLD.id)
    ;

-- --------------------------------------------------------
-- create view event_log
DROP VIEW IF EXISTS `v_picklist`;
CREATE VIEW `v_picklist`
AS
SELECT
    `o`.`id` AS `order_number`,
    `or`.`id` AS `order_row`,
    `p`.`description` AS `description`,
    `or`.`items` AS `items_ordered`,
    `ws`.`description` AS `shelf_location`,
    `w`.`items` AS `items_avaliable`
FROM `order` AS `o`
    INNER JOIN `order_row` AS `or`
        ON `o`.`id` = `or`.`order`
    INNER JOIN `product` AS `p`
        ON `or`.`product` = `p`.`id`
    INNER JOIN `warehouse` AS `w`
        ON `p`.`id` = `w`.`product_id`
    INNER JOIN `warehouse_shelf` AS `ws`
        ON `w`.`shelf_id` = `ws`.`shelf_id`
GROUP BY `order_row`, `ws`.`description`, `w`.`items`
;

-- SELECT * FROM v_picklist;

-- create a View
DROP VIEW IF EXISTS v_order;
CREATE VIEW v_order
AS
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

-- SELECT * from v_order;
