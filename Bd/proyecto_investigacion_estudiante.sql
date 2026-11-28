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
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiante` (
  `codigo` bigint NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `nombre_facultad` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `nombre_facultad` (`nombre_facultad`),
  CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`nombre_facultad`) REFERENCES `facultad` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` VALUES (20261001,'Mateo Alejandro Ruiz','Facultad de Ingeniería'),(20261002,'Sofía Valentina Herrera','Facultad de Ciencias de la Información'),(20261003,'Juan Sebastián Mora','Facultad Tecnológica'),(20261004,'Isabella María Delgado','Facultad de Ciencias Matemáticas y Naturales'),(20261005,'Samuel David Ospina','Facultad de Robótica y Automatización'),(20261006,'Valeria Sofía Guzmán','Facultad de Analítica y Datos'),(20261007,'Tomás Andrés Cárdenas','Facultad de Sistemas y Redes'),(20261008,'Mariana Lucía Peñuela','Facultad de Medio Ambiente'),(20261009,'Nicolás Felipe Rincón','Facultad de Ciencias Exactas'),(20261010,'Salomé Andrea Cubillos','Facultad de Innovación Digital'),(20261011,'Emiliano José Gaitán','Facultad de Mecánica y Materiales'),(20261012,'Luciana Isabel Téllez','Facultad de Bioingeniería'),(20261013,'Martín Esteban Franco','Facultad de Telecomunicaciones'),(20261014,'Antonella Sofía Vega','Facultad de Artes y Diseño'),(20261015,'Daniel Alejandro Niño','Facultad de Energía y Potencia'),(20261016,'Sara Valentina Molina','Facultad de Ciencias Básicas'),(20261017,'Gabriel Felipe Salazar','Facultad de Estudios Interdisciplinarios'),(20261018,'Gabriela Andrea Cruz','Facultad de Ciencias Aplicadas'),(20261019,'Cristian Camilo Roa','Facultad de Sostenibilidad Urbana'),(20261020,'Laura Sofía Castellanos','Facultad de Posgrados en Tecnología');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
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
