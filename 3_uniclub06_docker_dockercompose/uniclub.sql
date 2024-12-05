/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `billing_details`;
CREATE TABLE `billing_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company_name` varchar(50) DEFAULT NULL,
  `id_country` int DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip_code` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_id_country_billing_details` (`id_country`),
  CONSTRAINT `FK_id_country_billing_details` FOREIGN KEY (`id_country`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `color`;
CREATE TABLE `color` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `id_post` int DEFAULT NULL,
  `id_reply` int DEFAULT NULL,
  `content` text,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_id_user_comment` (`id_user`),
  KEY `FK_id_post_comment` (`id_post`),
  KEY `FK_id_reply_comment` (`id_reply`),
  CONSTRAINT `FK_id_post_comment` FOREIGN KEY (`id_post`) REFERENCES `post` (`id`),
  CONSTRAINT `FK_id_reply_comment` FOREIGN KEY (`id_reply`) REFERENCES `post` (`id`),
  CONSTRAINT `FK_id_user_comment` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `order_variant`;
CREATE TABLE `order_variant` (
  `id_order` int NOT NULL,
  `sku_variant` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id_order`,`sku_variant`),
  KEY `FK_sku_variant_order_variant` (`sku_variant`),
  CONSTRAINT `FK_id_order_order_variant` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`),
  CONSTRAINT `FK_sku_variant_order_variant` FOREIGN KEY (`sku_variant`) REFERENCES `variant` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` double DEFAULT NULL,
  `note` text,
  `id_payment` int DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_id_payment_order` (`id_payment`),
  KEY `FK_id_user_order` (`id_user`),
  CONSTRAINT `FK_id_payment_order` FOREIGN KEY (`id_payment`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `FK_id_user_order` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `payment_method`;
CREATE TABLE `payment_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `post_category`;
CREATE TABLE `post_category` (
  `id_category` int NOT NULL,
  `id_post` int NOT NULL,
  PRIMARY KEY (`id_category`,`id_post`),
  KEY `FK_id_post_post_category` (`id_post`),
  CONSTRAINT `FK_id_category_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_id_post_post_category` FOREIGN KEY (`id_post`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `information` text,
  `price` double DEFAULT NULL,
  `id_brand` int DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_id_brand_product` (`id_brand`),
  CONSTRAINT `FK_id_brand_product` FOREIGN KEY (`id_brand`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `product_brand`;
CREATE TABLE `product_brand` (
  `id_brand` int NOT NULL,
  `id_product` int NOT NULL,
  PRIMARY KEY (`id_brand`,`id_product`),
  KEY `FK_id_product_product_brand` (`id_product`),
  CONSTRAINT `FK_id_brand_product_brand` FOREIGN KEY (`id_brand`) REFERENCES `brand` (`id`),
  CONSTRAINT `FK_id_product_product_brand` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `id_category` int NOT NULL,
  `id_product` int NOT NULL,
  PRIMARY KEY (`id_category`,`id_product`),
  KEY `FK_id_product_product_category` (`id_product`),
  CONSTRAINT `FK_id_category_product_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_id_product_product_category` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag` (
  `id_tag` int NOT NULL,
  `id_product` int NOT NULL,
  PRIMARY KEY (`id_tag`,`id_product`),
  KEY `FK_id_product_product_tag` (`id_product`),
  CONSTRAINT `FK_id_category_product_tag` FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id`),
  CONSTRAINT `FK_id_product_product_tag` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `refresh_token`;
CREATE TABLE `refresh_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `expired_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_product` int DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `star` int DEFAULT NULL,
  `content` text,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `images` text,
  PRIMARY KEY (`id`),
  KEY `FK_id_product_review` (`id_product`),
  KEY `FK_id_user_review` (`id_user`),
  CONSTRAINT `FK_id_product_review` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_id_user_review` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `size`;
CREATE TABLE `size` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `full_name` varchar(255) DEFAULT NULL,
  `id_role` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_id_role_user` (`id_role`),
  CONSTRAINT `FK_id_role_user` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `variant`;
CREATE TABLE `variant` (
  `sku` int NOT NULL AUTO_INCREMENT,
  `id_product` int DEFAULT NULL,
  `id_color` int DEFAULT NULL,
  `id_size` int DEFAULT NULL,
  `images` text,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sku`),
  KEY `FK_id_product_variant` (`id_product`),
  KEY `FK_id_color_variant` (`id_color`),
  KEY `FK_id_size_variant` (`id_size`),
  CONSTRAINT `FK_id_color_variant` FOREIGN KEY (`id_color`) REFERENCES `color` (`id`),
  CONSTRAINT `FK_id_product_variant` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_id_size_variant` FOREIGN KEY (`id_size`) REFERENCES `size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist` (
  `id_product` int NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id_product`,`id_user`),
  KEY `FK_id_user_wishlist` (`id_user`),
  CONSTRAINT `FK_id_product_wishlist` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_id_user_wishlist` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



INSERT INTO `brand` (`id`, `name`) VALUES
(1, 'Chanel');
INSERT INTO `brand` (`id`, `name`) VALUES
(2, 'Adidas');
INSERT INTO `brand` (`id`, `name`) VALUES
(3, 'Nike');

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Hoodies');
INSERT INTO `category` (`id`, `name`) VALUES
(2, 'T-shirt');


INSERT INTO `color` (`id`, `name`) VALUES
(1, 'Xanh');
INSERT INTO `color` (`id`, `name`) VALUES
(2, 'Xanh biển');
INSERT INTO `color` (`id`, `name`) VALUES
(3, 'White');
INSERT INTO `color` (`id`, `name`) VALUES
(4, 'Black');















INSERT INTO `product` (`id`, `name`, `description`, `information`, `price`, `id_brand`, `create_date`) VALUES
(1, 'Áo Polo nam', 'Justo, cum feugiat imperdiet nulla molestie ac vulputate scelerisque amet. Bibendum adipiscing platea blandit sit sed quam semper rhoncus. Diam ultrices maecenas consequat eu tortor orci, cras lectus mauris, cras egestas quam venenatis neque.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.\r\n\r\nDonec nec justo eget felis facilisis fermentum.\r\nSuspendisse urna viverra non, semper suscipit pede.\r\nAliquam porttitor mauris sit amet orci.\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.', 2000, 1, '2024-09-09 17:05:14');
INSERT INTO `product` (`id`, `name`, `description`, `information`, `price`, `id_brand`, `create_date`) VALUES
(2, 'Áo Polo nam', 'Justo, cum feugiat imperdiet nulla molestie ac vulputate scelerisque amet. Bibendum adipiscing platea blandit sit sed quam semper rhoncus. Diam ultrices maecenas consequat eu tortor orci, cras lectus mauris, cras egestas quam venenatis neque.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.\r\n\r\nDonec nec justo eget felis facilisis fermentum.\r\nSuspendisse urna viverra non, semper suscipit pede.\r\nAliquam porttitor mauris sit amet orci.\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.', 2000, 1, '2024-09-09 17:05:14');
INSERT INTO `product` (`id`, `name`, `description`, `information`, `price`, `id_brand`, `create_date`) VALUES
(3, 'Áo Polo nam', 'Justo, cum feugiat imperdiet nulla molestie ac vulputate scelerisque amet. Bibendum adipiscing platea blandit sit sed quam semper rhoncus. Diam ultrices maecenas consequat eu tortor orci, cras lectus mauris, cras egestas quam venenatis neque.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.\r\n\r\nDonec nec justo eget felis facilisis fermentum.\r\nSuspendisse urna viverra non, semper suscipit pede.\r\nAliquam porttitor mauris sit amet orci.\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.', 2000, 1, '2024-09-09 17:05:14');
INSERT INTO `product` (`id`, `name`, `description`, `information`, `price`, `id_brand`, `create_date`) VALUES
(4, 'Áo Polo nam', 'Justo, cum feugiat imperdiet nulla molestie ac vulputate scelerisque amet. Bibendum adipiscing platea blandit sit sed quam semper rhoncus. Diam ultrices maecenas consequat eu tortor orci, cras lectus mauris, cras egestas quam venenatis neque.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.\r\n\r\nDonec nec justo eget felis facilisis fermentum.\r\nSuspendisse urna viverra non, semper suscipit pede.\r\nAliquam porttitor mauris sit amet orci.\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna viverra non, semper suscipit, posuere a, pede. Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean dignissim pellentesque felis. Phasellus ultrices nulla quis nibh. Quisque a lectus. Donec consectetuer ligula vulputate sem tristique cursus.', 2000, 1, '2024-09-09 17:05:14');



INSERT INTO `product_category` (`id_category`, `id_product`) VALUES
(1, 1);
INSERT INTO `product_category` (`id_category`, `id_product`) VALUES
(2, 2);




INSERT INTO `refresh_token` (`id`, `username`, `refresh_token`, `expired_time`) VALUES
(10, 'ductan@gmail.com', 'e8f38bd6-2e0c-4216-9e54-6cdbcde683ae', '2024-11-06 08:12:56');
INSERT INTO `refresh_token` (`id`, `username`, `refresh_token`, `expired_time`) VALUES
(12, 'ductan@gmail.com', 'df47b46b-27b1-41e9-a2e9-5431376fbebb', '2024-11-14 08:14:31');
INSERT INTO `refresh_token` (`id`, `username`, `refresh_token`, `expired_time`) VALUES
(13, 'ductan@gmail.com', '6f5f2569-85f2-45d4-9cf1-c357701fa02f', '2024-11-14 08:15:00');
INSERT INTO `refresh_token` (`id`, `username`, `refresh_token`, `expired_time`) VALUES
(14, 'ductan@gmail.com', '85aca32f-0c19-4882-8501-44ed4051209e', '2024-11-14 08:15:31'),
(15, 'ductan@gmail.com', '109c5f99-546a-45dd-9991-a3923c6d45f4', '2024-11-14 08:16:11'),
(16, 'ductan@gmail.com', 'ce1001b1-c02a-469b-a38c-f791a7b370db', '2024-11-14 08:16:50'),
(17, 'ductan@gmail.com', '7deda30c-7560-4b61-8dfe-4ee04c11be86', '2024-11-14 08:17:27'),
(19, 'ductan@gmail.com', '55e84e16-2fd8-435f-8007-f93f85d21c75', '2024-11-14 08:57:05'),
(20, 'ductan@gmail.com', '3861fa03-2b80-48a4-b227-404218d91ef6', '2024-11-14 11:58:33');



INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ROLE_ADMIN');
INSERT INTO `roles` (`id`, `name`) VALUES
(2, 'ROLE_USER');
INSERT INTO `roles` (`id`, `name`) VALUES
(3, 'ROLE_GUEST');

INSERT INTO `size` (`id`, `name`) VALUES
(1, 'S');
INSERT INTO `size` (`id`, `name`) VALUES
(2, 'M');




INSERT INTO `user` (`id`, `email`, `password`, `full_name`, `id_role`) VALUES
(1, 'ductan@gmail.com', '$2a$12$H8zr6W7EftfNf5N0.9qQAeTej.cF6L07VhRMy969tMsSu32MRdU8e', 'Nguyễn Văn A', 1);
INSERT INTO `user` (`id`, `email`, `password`, `full_name`, `id_role`) VALUES
(2, 'tan@gmail.com', '$2a$12$H8zr6W7EftfNf5N0.9qQAeTej.cF6L07VhRMy969tMsSu32MRdU8e', 'Nguyễn Văn B', 2);


INSERT INTO `variant` (`sku`, `id_product`, `id_color`, `id_size`, `images`, `quantity`, `price`, `create_date`) VALUES
(1, 2, 1, 1, 'item-lg2.jpg', 8, '2500', '2024-09-09 17:05:21');





/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;