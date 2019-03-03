--
-- Insert data into tables in database eshop
--
-- by johv18
--



--
-- insert into table product
--
DELETE FROM `product`;

LOAD DATA LOCAL INFILE './product.csv'
INTO TABLE `product`
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM `product`;

--
-- insert into table customer
--
DELETE FROM `customer`;

LOAD DATA LOCAL INFILE './customer.csv'
INTO TABLE `customer`
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM `customer`;

--
-- insert into table prod_cat
--
DELETE FROM `prod_cat`;

LOAD DATA LOCAL INFILE './prod_cat.csv'
INTO TABLE `prod_cat`
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM `prod_cat`;

--
-- insert into table warehouse_shelf
--
DELETE FROM `warehouse_shelf`;

LOAD DATA LOCAL INFILE './warehouse_shelf.csv'
INTO TABLE `warehouse_shelf`
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM `warehouse_shelf`;

--
-- insert into table producttocat
--
DELETE FROM `producttocat`;

INSERT INTO `producttocat`
    (`id`, `prod_id`, `cat_id`)
VALUES
    (1, 1, 1),
    (2, 2, 3),
    (3, 2, 5),
    (4, 3, 4),
    (5, 3, 3),
    (6, 4, 2),
    (7, 4, 5),
    (8, 5, 5)
;

SELECT * FROM `producttocat`;

--
-- insert into table warehouse
--
DELETE FROM `warehouse`;

INSERT INTO `warehouse`
    (`id`, `product_id`, `shelf_id`, `items`)
VALUES
    (1, 1, 1, 50),
    (2, 2, 2, 50),
    (3, 3, 3, 50),
    (4, 4, 4, 50),
    (5, 5, 5, 50)
;

SELECT * FROM `warehouse`;




-- --------------------------------------------
