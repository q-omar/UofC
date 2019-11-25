-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: payroll
-- ------------------------------------------------------
-- Server version	8.0.16

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
-- Table structure for table `benefit`
--

DROP TABLE IF EXISTS `benefit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `benefit` (
  `Employee_SIN` int(11) NOT NULL,
  `Salary_ID` int(11) NOT NULL,
  `CCB_Amount` int(11) NOT NULL,
  `Healthcare_Amount` int(11) NOT NULL,
  KEY `Employee_SIN_idx` (`Employee_SIN`),
  KEY `Salary_ID_idx` (`Salary_ID`),
  KEY `Employee_SIN_idx2` (`Employee_SIN`),
  KEY `Salary_ID_idx2` (`Salary_ID`),
  CONSTRAINT `benefitEmployeeSIN` FOREIGN KEY (`Employee_SIN`) REFERENCES `employee` (`SIN`) ON DELETE CASCADE,
  CONSTRAINT `benefitSalarySIN` FOREIGN KEY (`Salary_ID`) REFERENCES `salary` (`Salary_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `benefit`
--

LOCK TABLES `benefit` WRITE;
/*!40000 ALTER TABLE `benefit` DISABLE KEYS */;
INSERT INTO `benefit` VALUES (111111111,1,2000,2000),(222222222,3,4000,2000),(333333333,4,1000,2000),(444444444,5,3000,2000);
/*!40000 ALTER TABLE `benefit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonus`
--

DROP TABLE IF EXISTS `bonus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bonus` (
  `Bonus_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Employee_ID` int(11) NOT NULL,
  `Employer_Lic#` int(11) NOT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  `Date_Awarded` date DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`Bonus_ID`),
  UNIQUE KEY `Bonus_ID_UNIQUE` (`Bonus_ID`),
  KEY `Employee_ID_idx` (`Employee_ID`),
  KEY `Employer_Lic#_idx` (`Employer_Lic#`),
  CONSTRAINT `Employee_ID` FOREIGN KEY (`Employee_ID`) REFERENCES `employee` (`Employee_ID`) ON DELETE CASCADE,
  CONSTRAINT `Employer_Lic#2` FOREIGN KEY (`Employer_Lic#`) REFERENCES `employer` (`LicenseNum`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonus`
--

LOCK TABLES `bonus` WRITE;
/*!40000 ALTER TABLE `bonus` DISABLE KEYS */;
INSERT INTO `bonus` VALUES (2,1,1,'Contract Signing Bonus','2019-06-17',1200),(3,3,1,'Contract Signing Bonus','2019-06-17',2000),(4,4,1,'Contract Signing Bonus','2019-06-17',3000),(5,5,1,'Loyalty Bonus','2019-06-17',4000);
/*!40000 ALTER TABLE `bonus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `company` (
  `CID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`CID`),
  UNIQUE KEY `CID_UNIQUE` (`CID`)
) ENGINE=InnoDB AUTO_INCREMENT=97898 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (97897,'Hamzah Inc.');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deduction`
--

DROP TABLE IF EXISTS `deduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `deduction` (
  `Employee_SIN` int(11) NOT NULL,
  `Salary_ID` int(11) NOT NULL,
  `Tax_Amount` int(11) NOT NULL,
  `EI_Amount` int(11) NOT NULL,
  `Union_Dues` int(11) NOT NULL,
  KEY `Employee_SIN_idx` (`Employee_SIN`),
  KEY `Salary_ID_idx` (`Salary_ID`),
  CONSTRAINT `Employee_SIN` FOREIGN KEY (`Employee_SIN`) REFERENCES `employee` (`SIN`) ON DELETE CASCADE,
  CONSTRAINT `Salary_ID` FOREIGN KEY (`Salary_ID`) REFERENCES `salary` (`Salary_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deduction`
--

LOCK TABLES `deduction` WRITE;
/*!40000 ALTER TABLE `deduction` DISABLE KEYS */;
INSERT INTO `deduction` VALUES (111111111,1,12000,4800,20),(222222222,3,12300,4920,20),(333333333,4,27300,10500,20),(444444444,5,40300,15500,20);
/*!40000 ALTER TABLE `deduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `employee` (
  `Employee_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SIN` int(11) NOT NULL,
  `NumMinorDeps` int(11) DEFAULT '0',
  `Sex` varchar(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`SIN`),
  UNIQUE KEY `Employee_ID_UNIQUE` (`Employee_ID`),
  KEY `SIN_idx` (`SIN`),
  CONSTRAINT `SIN` FOREIGN KEY (`SIN`) REFERENCES `user` (`SIN`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,111111111,2,'Male'),(3,222222222,4,'Male'),(4,333333333,1,'Female'),(5,444444444,3,'Male');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employer`
--

DROP TABLE IF EXISTS `employer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `employer` (
  `LicenseNum` int(11) NOT NULL AUTO_INCREMENT,
  `SIN` int(11) NOT NULL,
  PRIMARY KEY (`LicenseNum`,`SIN`),
  UNIQUE KEY `LicenseNum_UNIQUE` (`LicenseNum`),
  KEY `SIN_idx` (`SIN`),
  CONSTRAINT `employerSIN` FOREIGN KEY (`SIN`) REFERENCES `user` (`SIN`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employer`
--

LOCK TABLES `employer` WRITE;
/*!40000 ALTER TABLE `employer` DISABLE KEYS */;
INSERT INTO `employer` VALUES (1,123456789);
/*!40000 ALTER TABLE `employer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `log` (
  `LogID` int(11) NOT NULL,
  `Interval` varchar(45) DEFAULT NULL,
  `Date_Generated` datetime DEFAULT NULL,
  `Generator_Lic#` int(11) NOT NULL,
  PRIMARY KEY (`LogID`),
  KEY `Generator_Lic#_idx` (`Generator_Lic#`),
  CONSTRAINT `Generator_Lic#` FOREIGN KEY (`Generator_Lic#`) REFERENCES `employer` (`LicenseNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `salary` (
  `Salary_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Recipient_SIN` int(11) NOT NULL,
  `Employer_Lic#` int(11) NOT NULL,
  `Amount` int(11) DEFAULT NULL,
  `Frequency` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Salary_ID`,`Recipient_SIN`),
  UNIQUE KEY `Salary_ID_UNIQUE` (`Salary_ID`),
  KEY `Employer_Lic#_idx` (`Employer_Lic#`),
  KEY `index3` (`Salary_ID`),
  KEY `Recipient_SIN_idx` (`Recipient_SIN`),
  CONSTRAINT `Employer_Lic#` FOREIGN KEY (`Employer_Lic#`) REFERENCES `employer` (`LicenseNum`),
  CONSTRAINT `Recipient_SIN` FOREIGN KEY (`Recipient_SIN`) REFERENCES `employee` (`SIN`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES (1,111111111,1,120000,'Monthly'),(3,222222222,1,123000,'Monthly'),(4,333333333,1,210000,'Monthly'),(5,444444444,1,310000,'Monthly');
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `SIN` int(11) NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `PhoneNum` varchar(45) DEFAULT NULL,
  `CID` int(11) NOT NULL,
  `loginID` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`SIN`),
  UNIQUE KEY `loginID_UNIQUE` (`loginID`),
  KEY `CID_idx` (`CID`),
  CONSTRAINT `CID` FOREIGN KEY (`CID`) REFERENCES `company` (`CID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (111111111,'Abhi','Bala','123-123-1234',97897,3,'728442'),(123456789,'Hamzah','Umar','403-891-2571',97897,1,'812557'),(222222222,'Omar','Qureshi','123-123-0019',97897,5,'211834'),(333333333,'Kashfia','Sailunaz','123-019-3412',97897,6,'172514'),(444444444,'Jalal','Kawash','123-012-3412',97897,7,'879057');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-18  0:10:36
