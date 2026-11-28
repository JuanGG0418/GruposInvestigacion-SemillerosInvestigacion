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
-- Table structure for table `facultad`
--

DROP TABLE IF EXISTS `facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad` (
  `nombre` varchar(100) NOT NULL,
  `cod_sede` int NOT NULL,
  `cedula_profesor` bigint NOT NULL,
  PRIMARY KEY (`nombre`),
  KEY `cod_sede` (`cod_sede`),
  KEY `cedula_profesor` (`cedula_profesor`),
  CONSTRAINT `facultad_ibfk_1` FOREIGN KEY (`cod_sede`) REFERENCES `sede` (`codigo`),
  CONSTRAINT `facultad_ibfk_2` FOREIGN KEY (`cedula_profesor`) REFERENCES `profesor` (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultad`
--

LOCK TABLES `facultad` WRITE;
/*!40000 ALTER TABLE `facultad` DISABLE KEYS */;
INSERT INTO `facultad` VALUES ('Facultad de Analítica y Datos',18,101018),('Facultad de Artes y Diseño',11,101010),('Facultad de Bioingeniería',13,101002),('Facultad de Ciencias Aplicadas',5,101008),('Facultad de Ciencias Básicas',3,101015),('Facultad de Ciencias de la Información',18,101007),('Facultad de Ciencias Exactas',3,101013),('Facultad de Ciencias Matemáticas y Naturales',3,101004),('Facultad de Energía y Potencia',10,101011),('Facultad de Estudios Interdisciplinarios',1,101005),('Facultad de Ingeniería',2,101001),('Facultad de Innovación Digital',5,101012),('Facultad de Mecánica y Materiales',16,101019),('Facultad de Medio Ambiente',12,101014),('Facultad de Posgrados en Tecnología',15,101020),('Facultad de Robótica y Automatización',17,101009),('Facultad de Sistemas y Redes',2,101016),('Facultad de Sostenibilidad Urbana',19,101006),('Facultad de Telecomunicaciones',17,101017),('Facultad Tecnológica',4,101003);
/*!40000 ALTER TABLE `facultad` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-27  8:56:22
