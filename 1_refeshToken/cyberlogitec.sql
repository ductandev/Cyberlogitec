/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `refresh_token`;
CREATE TABLE `refresh_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_deleted` int DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_deleted` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `id_role` int DEFAULT NULL,
  `is_deleted` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_id_role_user` (`id_role`),
  CONSTRAINT `FK_id_role_user` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `refresh_token` (`id`, `is_deleted`, `refresh_token`) VALUES
(16, 0, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNzMzMzAxMzkyfQ.wJ85VjgIODeaWWiSfFE8TwgMFKG9n5Hr1QU3cRg93As');
INSERT INTO `refresh_token` (`id`, `is_deleted`, `refresh_token`) VALUES
(17, 0, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNzMzMzAxNTQ4fQ.SRl32JjIe2JEU3Mgu6Djdb5IO8u-ceBtoyC3tFSLq0w');
INSERT INTO `refresh_token` (`id`, `is_deleted`, `refresh_token`) VALUES
(18, 0, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNzMzNDA2ODM3fQ.tkDiuUUlHUbvCSLcWwE7mCvzcClOr72QJ8n1pFr13io');
INSERT INTO `refresh_token` (`id`, `is_deleted`, `refresh_token`) VALUES
(19, 0, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNzMzNDA2OTE3fQ.25gAujZ-56RQ-SH28KW4Isz8GTaRgI_czPNXtGBo-LY');

INSERT INTO `roles` (`id`, `name`, `is_deleted`) VALUES
(1, 'ROLE_ADMIN', 0);
INSERT INTO `roles` (`id`, `name`, `is_deleted`) VALUES
(2, 'ROLE_USER', 0);
INSERT INTO `roles` (`id`, `name`, `is_deleted`) VALUES
(3, 'ROLE_GUEST', 0);

INSERT INTO `user` (`id`, `email`, `password`, `full_name`, `id_role`, `is_deleted`) VALUES
(1, 'ductan@gmail.com', '$2a$12$cAepyj3VqwrPrFlXGlV3X.k3n7piAxh5mlumsY8ZZpTpZHjAV2Hf6', 'Nguyễn Đức Tấn', 1, 0);
INSERT INTO `user` (`id`, `email`, `password`, `full_name`, `id_role`, `is_deleted`) VALUES
(2, 'tan@gmail.com', '$2a$12$H8zr6W7EftfNf5N0.9qQAeTej.cF6L07VhRMy969tMsSu32MRdU8e', 'Nguyễn Văn B', 2, 0);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;