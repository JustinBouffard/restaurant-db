-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurant
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `restaurant`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `restaurant` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `restaurant`;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`address_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,1,'123 Main St','Quebec City','G1R 1A1','Apartment 201',1),(2,1,'456 Oak Ave','Quebec City','G1R 2B2','House with gate',0),(3,2,'789 Elm St','Quebec City','G1S 3C3',NULL,1),(4,3,'321 Pine Rd','Beaumont','G0R 1A0','Downtown building',1),(5,4,'654 Maple Dr','Quebec City','G1R 4D4','Leave at front door',0),(6,5,'987 Cedar Lane','Laval','H7A 1E1',NULL,1),(7,6,'147 Birch Blvd','Quebec City','G1R 5E5','Call upon arrival',1);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Appetizers','Starters and small plates'),(2,'Main Courses','Entrees and primary dishes'),(3,'Pasta','Italian pasta dishes'),(4,'Desserts','Sweet treats and pastries'),(5,'Beverages','Drinks and beverages');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Alice','Anderson','alice.anderson@email.com','555-1001','2024-01-10 10:30:00'),(2,'Bob','Bennett','bob.bennett@email.com','555-1002','2024-01-15 14:20:00'),(3,'Carol','Carter','carol.carter@email.com','555-1003','2024-02-01 09:15:00'),(4,'David','Duncan','david.duncan@email.com','555-1004','2024-02-10 18:45:00'),(5,'Elena','Evans','elena.evans@email.com','555-1005','2024-03-05 12:00:00'),(6,'Frank','Foster','frank.foster@email.com','555-1006','2024-03-15 15:30:00');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `delivery_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `assigned_time` datetime NOT NULL,
  `pickup_time` datetime DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL,
  `delivery_status` enum('ASSIGNED','PICKED_UP','OUT_FOR_DELIVERY','DELIVERED','FAILED') NOT NULL,
  PRIMARY KEY (`delivery_id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,1,4,'2024-11-20 18:35:00','2024-11-20 18:50:00','2024-11-20 19:15:00','DELIVERED'),(2,2,7,'2024-11-21 19:05:00','2024-11-21 19:20:00','2024-11-21 19:45:00','DELIVERED'),(3,3,4,'2024-11-22 12:20:00','2024-11-22 12:35:00','2024-11-22 13:00:00','DELIVERED'),(4,4,7,'2024-11-23 17:50:00','2024-11-23 18:05:00',NULL,'OUT_FOR_DELIVERY'),(5,7,3,'2025-12-06 16:32:02',NULL,NULL,'ASSIGNED'),(6,8,3,'2025-12-06 17:17:56',NULL,NULL,'ASSIGNED');
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `hire_date` date NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,1,'John','Smith','john.smith@restaurant.com','555-0101','2023-01-15',1),(2,2,'Sarah','Johnson','sarah.johnson@restaurant.com','555-0102','2023-02-20',1),(3,3,'Marco','Rossi','marco.rossi@restaurant.com','555-0103','2023-03-10',1),(4,4,'Michael','Brown','michael.brown@restaurant.com','555-0104','2023-04-05',1),(5,5,'Emily','Davis','emily.davis@restaurant.com','555-0105','2023-05-12',1),(6,2,'David','Wilson','david.wilson@restaurant.com','555-0106','2023-06-18',1),(7,4,'Jessica','Martinez','jessica.martinez@restaurant.com','555-0107','2023-07-22',1);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `current_quantity` decimal(10,2) NOT NULL,
  `reorder_level` decimal(10,2) NOT NULL,
  PRIMARY KEY (`inventory_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,'Tomatoes','kg',45.20,20.00),(2,'Garlic','bulbs',119.90,50.00),(3,'Olive Oil','liters',29.96,10.00),(4,'Salmon Fillet','kg',18.50,10.00),(5,'Ribeye Beef','kg',25.00,15.00),(6,'Chicken Breast','kg',40.00,20.00),(7,'All Purpose Flour','kg',50.00,25.00),(8,'Eggs','dozen',15.00,8.00),(9,'Pasta (Spaghetti)','kg',22.00,10.00),(10,'Mascarpone Cheese','kg',8.50,5.00),(11,'Parmesan Cheese','kg',12.00,8.00),(12,'Heavy Cream','liters',20.00,10.00),(13,'Butter','kg',15.00,8.00),(14,'Pancetta','kg',5.50,3.00);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_item_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(8,2) NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`menu_item_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Bruschetta','Toasted bread with tomatoes and garlic',7.99,1),(2,1,'Calamari Fritti','Fried squid with marinara sauce',9.99,0),(3,2,'Grilled Salmon','Fresh salmon fillet with lemon butter',18.05,1),(4,2,'Ribeye Steak','12oz premium cut with seasonal vegetables',25.28,1),(5,2,'Chicken Parmesan','Breaded chicken breast with mozzarella',13.72,1),(6,3,'Spaghetti Carbonara','Creamy egg sauce with pancetta',16.99,1),(7,3,'Fettuccine Alfredo','Fresh pasta with creamy Alfredo sauce',15.99,1),(8,4,'Tiramisu','Classic Italian layered dessert',7.99,1),(9,4,'Panna Cotta','Silky smooth Italian custard',6.99,0),(10,5,'House Wine','By the glass',8.99,1),(11,5,'Espresso','Single or double shot',3.99,1),(12,1,'Caesar Salad','Crisp romaine lettuce with Caesar dressing, croutons, and parmesan cheese.',9.99,1),(13,2,'Margherita Pizza','Classic pizza with fresh tomatoes, mozzarella cheese, basil, and olive oil.',10.83,1),(14,3,'Shrimp Alfredo','Creamy pasta with shrimp in Alfredo sauce.',12.99,1),(15,1,'Caesar Salad','Crisp romaine lettuce with Caesar dressing, croutons, and parmesan cheese.',9.99,1),(16,2,'Margherita Pizza','Classic pizza with fresh tomatoes, mozzarella cheese, basil, and olive oil.',12.74,1),(17,3,'Shrimp Alfredo','Creamy pasta with shrimp in Alfredo sauce.',12.99,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item_ingredient`
--

DROP TABLE IF EXISTS `menu_item_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_item_ingredient` (
  `menu_item_id` int NOT NULL,
  `inventory_item_id` int NOT NULL,
  `quantity_per_unit` decimal(10,2) NOT NULL,
  PRIMARY KEY (`menu_item_id`,`inventory_item_id`),
  KEY `inventory_item_id` (`inventory_item_id`),
  CONSTRAINT `menu_item_ingredient_ibfk_1` FOREIGN KEY (`menu_item_id`) REFERENCES `menu` (`menu_item_id`) ON DELETE CASCADE,
  CONSTRAINT `menu_item_ingredient_ibfk_2` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory` (`inventory_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item_ingredient`
--

LOCK TABLES `menu_item_ingredient` WRITE;
/*!40000 ALTER TABLE `menu_item_ingredient` DISABLE KEYS */;
INSERT INTO `menu_item_ingredient` VALUES (1,1,0.15),(1,2,0.05),(1,3,0.02),(3,5,0.25),(4,6,0.35),(5,7,0.15),(5,8,0.10),(5,11,0.08),(6,9,0.20),(6,13,0.03),(6,14,0.08),(7,9,0.20),(7,12,0.15),(7,13,0.04),(8,10,0.15),(9,12,0.12);
/*!40000 ALTER TABLE `menu_item_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_id` int NOT NULL,
  `menu_item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(8,2) NOT NULL,
  `line_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`menu_item_id`),
  KEY `menu_item_id` (`menu_item_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`menu_item_id`) REFERENCES `menu` (`menu_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,2,12.99,25.98),(1,3,2,24.99,49.98),(1,11,1,3.99,3.99),(2,6,2,16.99,33.98),(2,9,1,6.99,6.99),(2,10,1,8.99,8.99),(3,2,1,9.99,9.99),(3,5,2,18.99,37.98),(4,4,1,34.99,34.99),(4,8,2,7.99,15.98),(4,11,1,3.99,3.99),(6,1,1,7.99,7.99),(6,3,1,24.99,24.99),(7,12,1,9.99,9.99),(7,13,1,12.74,12.74),(7,14,1,12.99,12.99),(8,12,1,9.99,9.99),(8,13,1,10.83,10.83),(8,14,1,12.99,12.99);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_inventory_on_order` AFTER INSERT ON `order_item` FOR EACH ROW BEGIN
    -- Update inventory for each ingredient in the ordered menu item
    UPDATE inventory i
    JOIN menu_item_ingredient mii ON i.inventory_item_id = mii.inventory_item_id
    SET i.current_quantity = i.current_quantity - (NEW.quantity * mii.quantity_per_unit)
    WHERE mii.menu_item_id = NEW.menu_item_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order_status_history`
--

DROP TABLE IF EXISTS `order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `old_status` varchar(20) NOT NULL,
  `new_status` varchar(20) NOT NULL,
  `changed_by_employee_id` int NOT NULL,
  `changed_at` datetime NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `order_id` (`order_id`),
  KEY `changed_by_employee_id` (`changed_by_employee_id`),
  CONSTRAINT `order_status_history_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_status_history_ibfk_2` FOREIGN KEY (`changed_by_employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status_history`
--

LOCK TABLES `order_status_history` WRITE;
/*!40000 ALTER TABLE `order_status_history` DISABLE KEYS */;
INSERT INTO `order_status_history` VALUES (1,1,'PENDING','PREPARING',3,'2024-11-20 18:32:00'),(2,1,'PREPARING','OUT_FOR_DELIVERY',3,'2024-11-20 18:50:00'),(3,1,'OUT_FOR_DELIVERY','DELIVERED',1,'2024-11-20 19:15:00'),(4,2,'PENDING','PREPARING',3,'2024-11-21 19:02:00'),(5,2,'PREPARING','OUT_FOR_DELIVERY',3,'2024-11-21 19:20:00'),(6,2,'OUT_FOR_DELIVERY','DELIVERED',1,'2024-11-21 19:45:00'),(7,3,'PENDING','PREPARING',3,'2024-11-22 12:17:00'),(8,3,'PREPARING','OUT_FOR_DELIVERY',3,'2024-11-22 12:35:00'),(9,3,'OUT_FOR_DELIVERY','DELIVERED',1,'2024-11-22 13:00:00'),(10,4,'PENDING','PREPARING',3,'2024-11-23 17:47:00'),(11,4,'PREPARING','OUT_FOR_DELIVERY',3,'2024-11-23 18:05:00'),(13,6,'PENDING','PENDING',2,'2024-11-25 19:30:00');
/*!40000 ALTER TABLE `order_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `cashier_id` int NOT NULL,
  `delivery_address_id` int NOT NULL,
  `order_datetime` datetime NOT NULL,
  `status` enum('PENDING','PREPARING','OUT_FOR_DELIVERY','DELIVERED','CANCELLED') NOT NULL,
  `payment_method` enum('CASH','CARD','ONLINE') NOT NULL,
  `payment_status` enum('UNPAID','PAID','REFUNDED') NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `cashier_id` (`cashier_id`),
  KEY `delivery_address_id` (`delivery_address_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`cashier_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`delivery_address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,2,1,'2024-11-20 18:30:00','DELIVERED','CARD','PAID',53.97),(2,2,2,3,'2024-11-21 19:00:00','DELIVERED','CASH','PAID',49.96),(3,3,6,4,'2024-11-22 12:15:00','DELIVERED','ONLINE','PAID',47.97),(4,4,2,5,'2024-11-23 17:45:00','OUT_FOR_DELIVERY','CARD','PAID',54.96),(6,1,2,1,'2024-11-25 19:30:00','PENDING','CARD','UNPAID',32.98),(7,1,1,1,'2025-12-06 16:32:02','PREPARING','CARD','UNPAID',35.72),(8,1,1,1,'2025-12-06 17:17:56','PREPARING','CARD','UNPAID',33.81);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Manager','Restaurant manager'),(2,'Cashier','Cashier and order processing'),(3,'Chef','Kitchen staff'),(4,'Driver','Delivery driver'),(5,'Host','Front of house staff');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-06 17:20:02
