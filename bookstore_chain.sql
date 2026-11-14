CREATE DATABASE IF NOT EXISTS bookstore_chain;
USE bookstore_chain;

CREATE TABLE IF NOT EXISTS `store` (
    `store_id`    INT NOT NULL,
    `store_name`  VARCHAR(40) NOT NULL,
    `city`        VARCHAR(30) NOT NULL,
    `street`      VARCHAR(40) NOT NULL,
    `building_no` INT,
    PRIMARY KEY (`store_id`)
);

CREATE TABLE IF NOT EXISTS `employee` (
    `employee_id` INT NOT NULL,
    `first_name`  VARCHAR(30) NOT NULL,
    `last_name`   VARCHAR(30) NOT NULL,
    `position`    VARCHAR(30) NOT NULL,
    `hire_date`   DATE NOT NULL,
    `store_id`    INT NOT NULL,
    `manager_id`  INT,
    `salary`      FLOAT NOT NULL,
    PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
    `customer_id`  INT NOT NULL,
    `first_name`   VARCHAR(30) NOT NULL,
    `last_name`    VARCHAR(30) NOT NULL,
    `gender`       VARCHAR(1) NOT NULL,
    `birth_date`   DATE NOT NULL,
    `phone_number` BIGINT NOT NULL,
    `email`        VARCHAR(50) NOT NULL,
    `address`      VARCHAR(100),
    `discount`     INT,
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `book` (
    `book_id`          INT NOT NULL,
    `title`            VARCHAR(100) NOT NULL,
    `genre`            VARCHAR(30) NOT NULL,
    `publisher`        VARCHAR(50) NOT NULL,
    `publication_year` INT NOT NULL,
    `isbn`             VARCHAR(13) NOT NULL,
    `price`            FLOAT NOT NULL,
    PRIMARY KEY (`book_id`)
);

CREATE TABLE IF NOT EXISTS `author` (
    `author_id`  INT NOT NULL,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name`  VARCHAR(30) NOT NULL,
    `country`    VARCHAR(30) NOT NULL,
    PRIMARY KEY (`author_id`)
);

CREATE TABLE IF NOT EXISTS `book_author` (
    `book_id`   INT NOT NULL,
    `author_id` INT NOT NULL,
    PRIMARY KEY (`book_id`, `author_id`)
);

CREATE TABLE IF NOT EXISTS `stock` (
    `store_id` INT NOT NULL,
    `book_id`  INT NOT NULL,
    `quantity` INT NOT NULL,
    PRIMARY KEY (`store_id`, `book_id`)
);

CREATE TABLE IF NOT EXISTS `sale` (
    `sale_id`        INT NOT NULL,
    `employee_id`    INT NOT NULL,
    `customer_id`    INT,
    `sale_datetime`  DATETIME NOT NULL,
    `payment_method` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`sale_id`)
);

CREATE TABLE IF NOT EXISTS `sale_item` (
    `sale_id`    INT NOT NULL,
    `book_id`    INT NOT NULL,
    `quantity`   INT NOT NULL,
    `unit_price` FLOAT NOT NULL,
    PRIMARY KEY (`sale_id`, `book_id`)
);

ALTER TABLE `employee`    ADD CONSTRAINT `employee_fk0`    FOREIGN KEY (`store_id`)    REFERENCES `store`(`store_id`);
ALTER TABLE `employee`    ADD CONSTRAINT `employee_fk1`    FOREIGN KEY (`manager_id`)  REFERENCES `employee`(`employee_id`);
ALTER TABLE `book_author` ADD CONSTRAINT `book_author_fk0` FOREIGN KEY (`book_id`)     REFERENCES `book`(`book_id`);
ALTER TABLE `book_author` ADD CONSTRAINT `book_author_fk1` FOREIGN KEY (`author_id`)   REFERENCES `author`(`author_id`);
ALTER TABLE `stock`       ADD CONSTRAINT `stock_fk0`       FOREIGN KEY (`store_id`)    REFERENCES `store`(`store_id`);
ALTER TABLE `stock`       ADD CONSTRAINT `stock_fk1`       FOREIGN KEY (`book_id`)     REFERENCES `book`(`book_id`);
ALTER TABLE `sale`        ADD CONSTRAINT `sale_fk0`        FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);
ALTER TABLE `sale`        ADD CONSTRAINT `sale_fk1`        FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);
ALTER TABLE `sale_item`   ADD CONSTRAINT `sale_item_fk0`   FOREIGN KEY (`sale_id`)     REFERENCES `sale`(`sale_id`);
ALTER TABLE `sale_item`   ADD CONSTRAINT `sale_item_fk1`   FOREIGN KEY (`book_id`)     REFERENCES `book`(`book_id`);

ALTER TABLE `book`     ADD CONSTRAINT `uq_book_isbn`      UNIQUE (`isbn`);
ALTER TABLE `customer` ADD CONSTRAINT `uq_customer_email` UNIQUE (`email`);
ALTER TABLE `customer` ADD CONSTRAINT `uq_customer_phone` UNIQUE (`phone_number`);
ALTER TABLE `store`    ADD CONSTRAINT `uq_store_name`     UNIQUE (`store_name`);

ALTER TABLE `store`     ALTER `city`     SET DEFAULT 'Lviv';
ALTER TABLE `customer`  ALTER `discount` SET DEFAULT 0;
ALTER TABLE `stock`     ALTER `quantity` SET DEFAULT 0;
ALTER TABLE `sale_item` ALTER `quantity` SET DEFAULT 1;
ALTER TABLE `sale`      MODIFY `sale_datetime`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `sale`      MODIFY `payment_method` VARCHAR(10) NOT NULL DEFAULT 'cash';
