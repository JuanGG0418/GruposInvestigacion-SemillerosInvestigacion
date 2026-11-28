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
-- Table structure for table `colaborar`
--

DROP TABLE IF EXISTS `colaborar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colaborar` (
  `nombre_grupo_investigacion` varchar(100) NOT NULL,
  `cedula_profesor` bigint NOT NULL,
  PRIMARY KEY (`nombre_grupo_investigacion`,`cedula_profesor`),
  KEY `cedula_profesor` (`cedula_profesor`),
  CONSTRAINT `colaborar_ibfk_1` FOREIGN KEY (`nombre_grupo_investigacion`) REFERENCES `grupo_investigacion` (`nombre`),
  CONSTRAINT `colaborar_ibfk_2` FOREIGN KEY (`cedula_profesor`) REFERENCES `profesor` (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colaborar`
--

LOCK TABLES `colaborar` WRITE;
/*!40000 ALTER TABLE `colaborar` DISABLE KEYS */;
INSERT INTO `colaborar` VALUES ('GI-IA Aplicada',101001),('GI-Seguridad Informática',101001),('GI-Ingeniería de Software',101003),('GI-Modelos Matemáticos',101004),('GI-Datos y Analítica',101007),('GI-Sistemas Distribuidos',101007),('GI-Biocomputación',101008),('GI-IoT y Sensores',101009),('GI-Visión Artificial',101010),('GI-Control y Procesos',101011),('GI-IA Aplicada',101012),('GI-Interactivos y Gráficos',101012),('GI-Hardware y Sistemas',101013),('GI-Energía Sostenible',101014),('GI-Arquitecturas Cuánticas',101015),('GI-Ingeniería de Software',101016),('GI-Redes Avanzadas',101016),('GI-Datos y Analítica',101018),('GI-Ecología y Datos',101018),('GI-Robótica Móvil',101019);
/*!40000 ALTER TABLE `colaborar` ENABLE KEYS */;
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
