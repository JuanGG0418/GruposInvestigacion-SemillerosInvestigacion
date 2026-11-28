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
-- Table structure for table `participar`
--

DROP TABLE IF EXISTS `participar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participar` (
  `nombre_proyecto` varchar(100) NOT NULL,
  `cedula_profesor` bigint NOT NULL,
  `fecha_incorporacion` date NOT NULL,
  `fecha_retiro` date DEFAULT NULL,
  `dedicacion` int NOT NULL,
  PRIMARY KEY (`nombre_proyecto`,`cedula_profesor`),
  KEY `cedula_profesor` (`cedula_profesor`),
  CONSTRAINT `participar_ibfk_1` FOREIGN KEY (`nombre_proyecto`) REFERENCES `proyecto` (`nombre`),
  CONSTRAINT `participar_ibfk_2` FOREIGN KEY (`cedula_profesor`) REFERENCES `profesor` (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participar`
--

LOCK TABLES `participar` WRITE;
/*!40000 ALTER TABLE `participar` DISABLE KEYS */;
INSERT INTO `participar` VALUES ('Análisis Genómico Computacional',101002,'2026-02-05',NULL,10),('Arquitectura Web Modular',101001,'2026-03-01',NULL,15),('Balanceo de Carga en Clúster',101003,'2026-02-15','2026-10-15',20),('Calidad del Aire en Bogotá',101014,'2026-03-01',NULL,15),('Clasificación de Imágenes Médicas',101012,'2026-01-10',NULL,30),('Control PID en Brazos Mecánicos',101019,'2026-01-30','2026-07-31',20),('Detección de Intrusos en Red',101016,'2026-02-10',NULL,25),('Evaluación de Pipelines RISC',101005,'2026-03-15','2026-11-01',15),('Gobierno de Datos Abiertos',101006,'2026-04-01',NULL,15),('Microred Solar Académica',101011,'2026-01-25',NULL,20),('Monitoreo Ambiental con IoT',101017,'2026-03-10',NULL,15),('Navegación Autónoma en Campus',101009,'2026-01-20','2026-08-31',20),('Optimización de Rutas Urbanas',101015,'2026-04-10',NULL,12),('Predicción Académica con IA',101007,'2026-02-01',NULL,20),('Repositorio Abierto de Datos',101008,'2026-02-18','2026-09-15',20),('Resumen Automático de Tesis',101010,'2026-03-05','2026-09-20',15),('Simulación de Circuitos Cuánticos',101013,'2026-04-01',NULL,10),('Simulador de Luz y Sombra 2D',101020,'2026-05-01',NULL,25),('Tablero de Indicadores Universitarios',101004,'2026-01-15','2026-09-30',10),('Telemetría de Baja Latencia',101017,'2026-02-20','2026-10-01',18);
/*!40000 ALTER TABLE `participar` ENABLE KEYS */;
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
