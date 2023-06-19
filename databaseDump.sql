-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `motherboards`
--

DROP TABLE IF EXISTS `motherboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motherboards` (
  `motherboardname` varchar(50) NOT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `chipset` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`motherboardname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motherboards`
--

LOCK TABLES `motherboards` WRITE;
/*!40000 ALTER TABLE `motherboards` DISABLE KEYS */;
INSERT INTO `motherboards` VALUES ('Z690 Unify-X','MSI','Z690','MEG Unify-X'),('Z790 Apex','Asus','Z790','ROG Maximus Apex'),('Z790 Dark','EVGA','Z790','Dark K|NGP|N'),('Z790 Tachyon','Gigabyte','Z790','Aorus Tachyon');
/*!40000 ALTER TABLE `motherboards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stages`
--

DROP TABLE IF EXISTS `stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stages` (
  `stagename` varchar(50) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  `descending` tinyint(1) NOT NULL,
  PRIMARY KEY (`stagename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stages`
--

LOCK TABLES `stages` WRITE;
/*!40000 ALTER TABLE `stages` DISABLE KEYS */;
INSERT INTO `stages` VALUES ('Cinebench R15','2023-03-08','2023-03-26',1),('Memory Frequency','2023-03-01','2023-04-09',1),('SuperPi 32M','2023-03-22','2023-04-10',0),('Y-Cruncher 2.5B','2023-03-15','2023-04-06',0);
/*!40000 ALTER TABLE `stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submissions` (
  `score` float NOT NULL,
  `username` varchar(50) NOT NULL,
  `stagename` varchar(50) NOT NULL,
  `submissionDate` date NOT NULL,
  `motherboardname` varchar(50) DEFAULT NULL,
  `memoryFrequency` float DEFAULT NULL,
  `points` int DEFAULT NULL,
  PRIMARY KEY (`username`,`stagename`),
  KEY `stagename` (`stagename`),
  KEY `motherboardname` (`motherboardname`),
  CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`stagename`) REFERENCES `stages` (`stagename`),
  CONSTRAINT `submissions_ibfk_3` FOREIGN KEY (`motherboardname`) REFERENCES `motherboards` (`motherboardname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions`
--

LOCK TABLES `submissions` WRITE;
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
INSERT INTO `submissions` VALUES (1266,'biso biso','Cinebench R15','2023-03-10','Z790 Dark',4687.58,2),(5351.5,'biso biso','Memory Frequency','2023-04-09','Z790 Dark',5351.5,7),(269.948,'biso biso','SuperPi 32M','2023-04-10','Z790 Dark',4278.96,9),(95.433,'biso biso','Y-Cruncher 2.5B','2023-04-06','Z790 Dark',4076.16,9),(1267,'CENS','Cinebench R15','2023-03-26','Z790 Dark',4268.76,3),(5289.3,'CENS','Memory Frequency','2023-04-09','Z790 Dark',5289.3,4),(269.42,'CENS','SuperPi 32M','2023-04-10','Z790 Dark',4584.6,10),(95.425,'CENS','Y-Cruncher 2.5B','2023-04-06','Z790 Dark',4076.16,10),(1267,'IvanCupa','Cinebench R15','2023-03-11','Z790 Apex',4279.97,8),(5179.8,'IvanCupa','Memory Frequency','2023-04-09','Z790 Apex',5179.8,2),(270.697,'IvanCupa','SuperPi 32M','2023-04-10','Z790 Apex',4200,1),(95.961,'IvanCupa','Y-Cruncher 2.5B','2023-04-06','Z690 Unify-X',4041.22,5),(1267,'Luumi','Cinebench R15','2023-03-20','Z790 Apex',4202.06,4),(5400.4,'Luumi','Memory Frequency','2023-04-09','Z790 Apex',5400.4,9),(270.118,'Luumi','SuperPi 32M','2023-04-10','Z790 Dark',4346.88,7),(96.049,'Luumi','Y-Cruncher 2.5B','2023-04-06','Z790 Apex',4076.16,3),(1267,'Micka','Cinebench R15','2023-03-20','Z790 Apex',4202.06,5),(5294.5,'Micka','Memory Frequency','2023-04-09','Z790 Apex',5294.4,5),(270.102,'Micka','SuperPi 32M','2023-04-10','Z790 Apex',4210.01,8),(96.414,'Micka','Y-Cruncher 2.5B','2023-04-06','Z790 Apex',3962.12,2),(1267,'Rauf','Cinebench R15','2023-03-08','Z790 Apex',4278.96,10),(5352.5,'Rauf','Memory Frequency','2023-04-09','Z790 Apex',5352.5,8),(270.234,'Rauf','SuperPi 32M','2023-04-10','Z790 Apex',4178.06,5),(96.04,'Rauf','Y-Cruncher 2.5B','2023-04-05','Z790 Apex',4076.16,4),(1267,'Seby9123','Cinebench R15','2023-03-19','Z790 Apex',4268.76,6),(5504.5,'Seby9123','Memory Frequency','2023-03-26','Z790 Apex',5504.5,10),(270.414,'Seby9123','SuperPi 32M','2023-04-10','Z790 Apex',4120.01,2),(95.911,'Seby9123','Y-Cruncher 2.5B','2023-04-06','Z790 Apex',4026.81,6),(1266,'sergmann','Cinebench R15','2023-03-14','Z790 Tachyon',4212.03,1),(5180,'sergmann','Memory Frequency','2023-04-09','Z790 Tachyon',5180,3),(270.137,'sergmann','SuperPi 32M','2023-04-10','Z790 Tachyon',4211.04,6),(95.823,'sergmann','Y-Cruncher 2.5B','2023-04-06','Z790 Tachyon',4178.06,8),(1267,'snakeeyes','Cinebench R15','2023-03-11','Z790 Apex',4278.96,9),(4993.9,'snakeeyes','Memory Frequency','2023-04-09','Z790 Apex',4993.9,1),(270.261,'snakeeyes','SuperPi 32M','2023-04-10','Z790 Apex',4152.36,3),(95.866,'snakeeyes','Y-Cruncher 2.5B','2023-04-02','Z790 Apex',4098.72,7),(1267,'ZeR0_Dan','Cinebench R15','2023-03-19','Z790 Apex',4279.97,7),(5304.4,'ZeR0_Dan','Memory Frequency','2023-04-09','Z790 Apex',5304.4,6),(270.256,'ZeR0_Dan','SuperPi 32M','2023-04-10','Z790 Apex',4210.01,4),(96.465,'ZeR0_Dan','Y-Cruncher 2.5B','2023-04-06','Z790 Apex',3962.12,1);
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `league` varchar(50) NOT NULL,
  `joindate` date NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('biso biso','South Korea','Elite','2021-03-11'),('CENS','Germany','Elite','2017-11-30'),('IvanCupa','Indonesia','Extreme','2012-10-26'),('Luumi','Finland','Elite','2012-09-23'),('Micka','China','Extreme','2012-03-19'),('Rauf','Sweden','Elite','2014-12-13'),('Seby9123','United States','Extreme','2019-12-30'),('sergmann','Germany','Elite','2007-12-05'),('snakeeyes','Germany','Extreme','2019-02-17'),('ZeR0_Dan','China','Extreme','2013-12-19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'project'
--
/*!50003 DROP FUNCTION IF EXISTS `NeedPointChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `NeedPointChange`(stageNameInput VARCHAR(20), currentPoints INT, newScore FLOAT, ascending BOOL) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE result BOOL;
    SET result = CASE WHEN 
		(SELECT COUNT(points) FROM submissions 
            WHERE stagename = stageNameInput 
			AND ((points = currentPoints + 1 AND ((ascending AND score < newScore) OR (NOT ascending AND score > newScore))) 
            OR (points = currentPoints - 1 AND ((ascending AND score > newScore) OR (NOT ascending AND score < newScore))))
		> 0) 
		THEN 1 
        ELSE 0 
        END;
	RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePoints` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePoints`(IN stageNameInput VARCHAR(50), IN ascending BOOL)
BEGIN
    IF ascending THEN
    UPDATE submissions AS 
		s1 JOIN 
			(SELECT stagename, username, ROW_NUMBER() OVER (ORDER BY score ASC, submissionDate DESC) as newPoints 
            FROM submissions WHERE stagename = stageNameInput) AS s2 
        ON s1.stagename = s2.stagename AND s1.username = s2.username 
	SET s1.points = s2.newPoints;
    
    ELSE
    UPDATE submissions AS 
		s1 JOIN 
			(SELECT stagename, username, ROW_NUMBER() OVER (ORDER BY score DESC, submissionDate DESC) as newPoints 
            FROM submissions WHERE stagename = stageNameInput) AS s2 
        ON s1.stagename = s2.stagename AND s1.username = s2.username 
	SET s1.points = s2.newPoints;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateScore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateScore`(IN newScore FLOAT, IN userNameInput VARCHAR(50), IN stageNameInput VARCHAR(50))
BEGIN
	DECLARE currentPoints INT;
    DECLARE ascending BOOL;
	SET currentPoints = (SELECT points FROM submissions WHERE username = userNameInput AND stagename = stageNameInput);
    SET ascending = (SELECT descending FROM stages WHERE stagename = stageNameInput);

	UPDATE submissions SET score = newScore WHERE username = userNameInput AND stagename = stageNameInput;

	IF project.NeedPointChange(stageNameInput, currentPoints, newScore, ascending) THEN
        CALL UpdatePoints(stageNameInput, ascending);
        SELECT "Points updated";
	ELSE
		SELECT "Points not updated";
	END IF;
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

-- Dump completed on 2023-06-19 23:26:27
