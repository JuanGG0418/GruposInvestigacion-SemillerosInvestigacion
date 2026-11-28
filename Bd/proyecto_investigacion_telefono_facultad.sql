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
-- Table structure for table `telefono_facultad`
--

DROP TABLE IF EXISTS `telefono_facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefono_facultad` (
  `nombre` varchar(100) NOT NULL,
  `telefono` bigint NOT NULL,
  PRIMARY KEY (`nombre`,`telefono`),
  CONSTRAINT `telefono_facultad_ibfk_1` FOREIGN KEY (`nombre`) REFERENCES `facultad` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefono_facultad`
--

LOCK TABLES `telefono_facultad` WRITE;
/*!40000 ALTER TABLE `telefono_facultad` DISABLE KEYS */;
INSERT INTO `telefono_facultad` VALUES ('Facultad de Analítica y Datos',6013239319),('Facultad de Artes y Diseño',6013239307),('Facultad de Bioingeniería',6013239314),('Facultad de Ciencias Aplicadas',6013239315),('Facultad de Ciencias Básicas',6013239308),('Facultad de Ciencias de la Información',6013239305),('Facultad de Ciencias Exactas',6013239310),('Facultad de Ciencias Matemáticas y Naturales',6013239303),('Facultad de Energía y Potencia',6013239313),('Facultad de Estudios Interdisciplinarios',6013239312),('Facultad de Ingeniería',6013239301),('Facultad de Ingeniería',6013239302),('Facultad de Innovación Digital',6013239316),('Facultad de Mecánica y Materiales',6013239317),('Facultad de Medio Ambiente',6013239306),('Facultad de Robótica y Automatización',6013239309),('Facultad de Sistemas y Redes',6013239311),('Facultad de Sostenibilidad Urbana',6013239320),('Facultad de Telecomunicaciones',6013239318),('Facultad Tecnológica',6013239304);
/*!40000 ALTER TABLE `telefono_facultad` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-27  8:56:23
