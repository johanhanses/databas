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
    `description` VARCHAR(20),

    PRIMARY KEY (`id`)
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

    PRIMARY KEY (`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create order tables
CREATE TABLE `order`
(
    `id` INT NOT NULL,
    `customer_id` INT,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `order_row`
(
    `id` INT NOT NULL,
    `order` INT,
    `product` INT,
    `items` INT,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`order`) REFERENCES `order`(`id`),
    FOREIGN KEY (`product`) REFERENCES `product`(`id`)
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
    `shelf_id` INT NOT NULL,
    `description` VARCHAR(45),

    PRIMARY KEY (`shelf_id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

CREATE TABLE `warehouse`
(
    `id` INT NOT NULL,
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
CREATE TABLE `event_log`
(
    `id` INT NOT NULL,
    `order_id` INT,
    `order_row_id` INT,
    `order_created` DATETIME,
    `order_updated` DATETIME,
    `order_deleted` DATETIME,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`order_id`) REFERENCES `order`(`id`),
    FOREIGN KEY (`order_row_id`) REFERENCES `order_row`(`id`)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci;

-- --------------------------------------------------------
-- create view event_log
DROP VIEW IF EXISTS `Vpick_list`;
CREATE VIEW `Vpick_list`
AS
SELECT
    `o`.`id` AS `order_number`,
    `or`.`id` AS `order_row`,
    `p`.`description` AS `description`,
    `or`.`items` AS `items_ordered`,
    `ws`.`shelf_id` AS `shelf`,
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
GROUP BY `order_row`
;
