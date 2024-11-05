-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kyrsach
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bronirovanie`
--

DROP TABLE IF EXISTS `bronirovanie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bronirovanie` (
  `hotel_room_idhotel_room` int NOT NULL,
  `klient_idklient` int NOT NULL,
  `Date_arrival` date DEFAULT NULL,
  `Date_of_departure` date DEFAULT NULL,
  PRIMARY KEY (`hotel_room_idhotel_room`,`klient_idklient`),
  KEY `fk_hotel_room_has_klient_klient1_idx` (`klient_idklient`),
  KEY `fk_hotel_room_has_klient_hotel_room1_idx` (`hotel_room_idhotel_room`),
  CONSTRAINT `fk_hotel_room_has_klient_hotel_room1` FOREIGN KEY (`hotel_room_idhotel_room`) REFERENCES `hotel_room` (`idhotel_room`) ON DELETE CASCADE,
  CONSTRAINT `fk_hotel_room_has_klient_klient1` FOREIGN KEY (`klient_idklient`) REFERENCES `klient` (`idklient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bronirovanie`
--

LOCK TABLES `bronirovanie` WRITE;
/*!40000 ALTER TABLE `bronirovanie` DISABLE KEYS */;
INSERT INTO `bronirovanie` (`hotel_room_idhotel_room`, `klient_idklient`, `Date_arrival`, `Date_of_departure`) VALUES (1,3,'2023-11-22','2023-11-24');
/*!40000 ALTER TABLE `bronirovanie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bronirovanie_BEFORE_INSERT` BEFORE INSERT ON `bronirovanie` FOR EACH ROW BEGIN
 IF NEW.Date_arrival>new.Date_of_departure  THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Дата приезда не может быть больше даты уезда"';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `bronirovanie_BEFORE_DELETE` BEFORE DELETE ON `bronirovanie` FOR EACH ROW BEGIN
UPDATE hotel_room
    SET statys = 'Свободен'
    WHERE idhotel_room = OLD.hotel_room_idhotel_room;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hotel_room`
--

DROP TABLE IF EXISTS `hotel_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hotel_room` (
  `idhotel_room` int NOT NULL,
  `num_room` int DEFAULT NULL,
  `cost_for_day` int NOT NULL,
  `statys` varchar(200) DEFAULT NULL,
  `floor` int DEFAULT NULL,
  `photo` varchar(45) DEFAULT 'zz.jpg',
  PRIMARY KEY (`idhotel_room`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_room`
--

LOCK TABLES `hotel_room` WRITE;
/*!40000 ALTER TABLE `hotel_room` DISABLE KEYS */;
INSERT INTO `hotel_room` (`idhotel_room`, `num_room`, `cost_for_day`, `statys`, `floor`, `photo`) VALUES (1,132,800,'Занят',1,'room1.jpg'),(2,133,1000,'Свободен',1,'room2.jpg'),(3,134,1500,'Свободен',1,'room3.jpg'),(4,231,900,'Свободен',2,'room4.jpeg'),(5,234,4000,'Свободен',2,'room5.jpg'),(6,236,3000,'Свободен',2,'room6.jpg'),(7,346,1200,'Свободен',3,'room7.jpeg'),(8,324,700,'Свободен',3,'room8.jpg'),(9,321,800,'Свободен',3,'room9.jpg');
/*!40000 ALTER TABLE `hotel_room` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hotel_room_BEFORE_UPDATE` BEFORE UPDATE ON `hotel_room` FOR EACH ROW BEGIN
 IF NEW.statys != 'Свободен' AND NEW.statys != 'Занят' THEN
       SET NEW.statys = OLD.statys;
     END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `klient`
--

DROP TABLE IF EXISTS `klient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `klient` (
  `idklient` int NOT NULL AUTO_INCREMENT,
  `FIO` varchar(45) DEFAULT NULL,
  `Passport` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idklient`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klient`
--

LOCK TABLES `klient` WRITE;
/*!40000 ALTER TABLE `klient` DISABLE KEYS */;
INSERT INTO `klient` (`idklient`, `FIO`, `Passport`) VALUES (1,'Пряженцов михаил','2019 789534'),(2,'Поляшов Никита Михайлович','2211 089654'),(3,'Круглов Кирилл Александрович','1234 890765'),(7,'Лашков Максим','1234567898765'),(30,'Гутянская Е М','123456543');
/*!40000 ALTER TABLE `klient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `payment` (
  `hotel_room_idhotel_room` int NOT NULL,
  `klient_idklient` int NOT NULL,
  `cost_full` int DEFAULT NULL,
  `receipt_number` int DEFAULT NULL,
  PRIMARY KEY (`hotel_room_idhotel_room`,`klient_idklient`),
  KEY `fk_hotel_room_has_klient_klient2_idx` (`klient_idklient`),
  KEY `fk_hotel_room_has_klient_hotel_room2_idx` (`hotel_room_idhotel_room`),
  CONSTRAINT `fk_hotel_room_has_klient_hotel_room2` FOREIGN KEY (`hotel_room_idhotel_room`) REFERENCES `hotel_room` (`idhotel_room`) ON DELETE CASCADE,
  CONSTRAINT `fk_hotel_room_has_klient_klient2` FOREIGN KEY (`klient_idklient`) REFERENCES `klient` (`idklient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` (`hotel_room_idhotel_room`, `klient_idklient`, `cost_full`, `receipt_number`) VALUES (1,3,1600,5);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `payment_AFTER_INSERT` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
UPDATE hotel_room
SET statys = 'Занят'
WHERE idhotel_room = NEW.hotel_room_idhotel_room;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role` (
  `idrole` int NOT NULL,
  `name_role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idrole`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`idrole`, `name_role`) VALUES (1,'Administrator'),(2,'Person');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `name_user` varchar(45) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `role_idrole` int NOT NULL DEFAULT '2',
  PRIMARY KEY (`iduser`),
  KEY `fk_user_role_idx` (`role_idrole`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_idrole`) REFERENCES `role` (`idrole`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`iduser`, `name_user`, `login`, `password`, `role_idrole`) VALUES (1,'Орлов Дмитрий Андреевич','adm','123',1),(2,'Сокуров Александ Владимирович','per','12',2),(7,'grew','qwerty','21',2),(8,'Круглов Кирилл Александрович','st1','567',2),(9,'Кургузов','qwa','143',2),(10,'1','2','3',2),(11,'Травкина А. В.','trav','11052006',2),(12,'bhgf','bgvf','g',2),(18,'енг','per1','12',2),(19,'42','per12','tr',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'kyrsach'
--

--
-- Dumping routines for database 'kyrsach'
--
/*!50003 DROP PROCEDURE IF EXISTS `fullcost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fullcost`(IN b INT, IN c INT)
BEGIN
declare result int;
    SET result = b * c;
    select result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-24 19:58:06
