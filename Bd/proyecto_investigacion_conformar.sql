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
-- Table structure for table `conformar`
--

DROP TABLE IF EXISTS `conformar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conformar` (
  `codigo_estudiante` bigint NOT NULL,
  `nombre_proyecto` varchar(100) NOT NULL,
  PRIMARY KEY (`codigo_estudiante`,`nombre_proyecto`),
  KEY `nombre_proyecto` (`nombre_proyecto`),
  CONSTRAINT `conformar_ibfk_1` FOREIGN KEY (`codigo_estudiante`) REFERENCES `estudiante` (`codigo`),
  CONSTRAINT `conformar_ibfk_2` FOREIGN KEY (`nombre_proyecto`) REFERENCES `proyecto` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conformar`
--

LOCK TABLES `conformar` WRITE;
/*!40000 ALTER TABLE `conformar` DISABLE KEYS */;
INSERT INTO `conformar` VALUES (20261020,'Análisis Genómico Computacional'),(20261003,'Arquitectura Web Modular'),(20261017,'Balanceo de Carga en Clúster'),(20261006,'Calidad del Aire en Bogotá'),(20261012,'Clasificación de Imágenes Médicas'),(20261011,'Control PID en Brazos Mecánicos'),(20261007,'Detección de Intrusos en Red'),(20261016,'Evaluación de Pipelines RISC'),(20261019,'Gobierno de Datos Abiertos'),(20261015,'Microred Solar Académica'),(20261008,'Monitoreo Ambiental con IoT'),(20261005,'Navegación Autónoma en Campus'),(20261004,'Optimización de Rutas Urbanas'),(20261001,'Predicción Académica con IA'),(20261018,'Repositorio Abierto de Datos'),(20261010,'Resumen Automático de Tesis'),(20261009,'Simulación de Circuitos Cuánticos'),(20261014,'Simulador de Luz y Sombra 2D'),(20261002,'Tablero de Indicadores Universitarios'),(20261013,'Telemetría de Baja Latencia');
/*!40000 ALTER TABLE `conformar` ENABLE KEYS */;
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
