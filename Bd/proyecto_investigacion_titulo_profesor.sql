-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_investigacion
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `titulo_profesor`
--

DROP TABLE IF EXISTS `titulo_profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titulo_profesor` (
  `titulo` varchar(150) NOT NULL,
  `cedula` bigint NOT NULL,
  PRIMARY KEY (`titulo`,`cedula`),
  KEY `cedula` (`cedula`),
  CONSTRAINT `titulo_profesor_ibfk_1` FOREIGN KEY (`cedula`) REFERENCES `profesor` (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulo_profesor`
--

LOCK TABLES `titulo_profesor` WRITE;
/*!40000 ALTER TABLE `titulo_profesor` DISABLE KEYS */;
INSERT INTO `titulo_profesor` VALUES ('Ingeniero de Sistemas',101001),('Magíster en Ciencias de la Computación',101001),('Ingeniera Electrónica',101002),('Doctor en Ingeniería',101003),('Magíster en Estadística Aplicada',101004),('Matemática Pura',101004),('Ingeniero Industrial',101005),('Doctor en Ciencias Físicas',101006),('Ingeniero de Software',101007),('Magíster en Inteligencia Artificial',101007),('Licenciada en Química',101008),('Ingeniero Mecatrónico',101009),('Doctora en Educación',101010),('Ingeniero Eléctrico',101011),('Magíster en Gestión de Datos',101012),('Físico Teórico',101013),('Ingeniera Ambiental',101014),('Doctor en Matemáticas',101015),('Magíster en Ciberseguridad',101016),('Ingeniero en Telecomunicaciones',101017);
/*!40000 ALTER TABLE `titulo_profesor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-27  8:56:21
