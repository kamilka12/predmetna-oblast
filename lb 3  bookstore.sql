CREATE TABLE IF NOT EXISTS `publisher` (
	`publisher_id` int AUTO_INCREMENT NOT NULL,
	`publisher_name` varchar(50) NOT NULL,
	`city` varchar(30) NOT NULL,
	`country` varchar(30) NOT NULL,
	PRIMARY KEY (`publisher_id`)
);
CREATE TABLE IF NOT EXISTS `author` (
	`author_id` int AUTO_INCREMENT NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`birth_date` date,
	`country` varchar(30),
	PRIMARY KEY (`author_id`)
);
CREATE TABLE IF NOT EXISTS `category` (
	`category_id` int AUTO_INCREMENT NOT NULL,
	`category_name` varchar(40) NOT NULL,
	`description` varchar(150),
	PRIMARY KEY (`category_id`)
);
CREATE TABLE IF NOT EXISTS `book` (
	`book_id` int AUTO_INCREMENT NOT NULL,
	`title` varchar(100) NOT NULL,
	`isbn` varchar(17) NOT NULL,
	`publisher_id` int NOT NULL,
	`category_id` int NOT NULL,
	`publication_year` int NOT NULL,
	`pages` int,
	`language` varchar(20) NOT NULL,
	`price` float NOT NULL,
	`stock_amount` int NOT NULL,
	PRIMARY KEY (`book_id`)
);
CREATE TABLE IF NOT EXISTS `book_author` (
	`book_author_id` int AUTO_INCREMENT NOT NULL,
	`book_id` int NOT NULL,
	`author_id` int NOT NULL,
	PRIMARY KEY (`book_author_id`)
);
CREATE TABLE IF NOT EXISTS `customer` (
	`customer_id` int AUTO_INCREMENT NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`phone_number` bigint NOT NULL,
	`email` varchar(50) NOT NULL,
	`discount` int,
	PRIMARY KEY (`customer_id`)
);
CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` int AUTO_INCREMENT NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`position` varchar(20) NOT NULL,
	`hire_date` date NOT NULL,
	`salary` float NOT NULL,
	PRIMARY KEY (`employee_id`)
);
CREATE TABLE IF NOT EXISTS `orders` (
	`order_id` int AUTO_INCREMENT NOT NULL,
	`customer_id` int NOT NULL,
	`employee_id` int NOT NULL,
	`order_date` datetime NOT NULL,
	`payment_method` varchar(20) NOT NULL,
	`status` varchar(15) NOT NULL,
	PRIMARY KEY (`order_id`)
);
CREATE TABLE IF NOT EXISTS `order_item` (
	`order_item_id` int AUTO_INCREMENT NOT NULL,
	`order_id` int NOT NULL,
	`book_id` int NOT NULL,
	`quantity` int NOT NULL,
	`unit_price` float NOT NULL,
	PRIMARY KEY (`order_item_id`)
);
ALTER TABLE `book` ADD CONSTRAINT `book_fk3` FOREIGN KEY (`publisher_id`) REFERENCES `publisher`(`publisher_id`);
ALTER TABLE `book` ADD CONSTRAINT `book_fk4` FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`);
ALTER TABLE `book_author` ADD CONSTRAINT `book_author_fk1` FOREIGN KEY (`book_id`) REFERENCES `book`(`book_id`);
ALTER TABLE `book_author` ADD CONSTRAINT `book_author_fk2` FOREIGN KEY (`author_id`) REFERENCES `author`(`author_id`);
ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);
ALTER TABLE `orders` ADD CONSTRAINT `orders_fk2` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);
ALTER TABLE `order_item` ADD CONSTRAINT `order_item_fk1` FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`);
ALTER TABLE `order_item` ADD CONSTRAINT `order_item_fk2` FOREIGN KEY (`book_id`) REFERENCES `book`(`book_id`);