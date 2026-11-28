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
-- Table structure for table `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyecto` (
  `nombre` varchar(100) NOT NULL,
  `codigo` int NOT NULL,
  `valor_presupuesto` decimal(15,2) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `nombre_grupo_investigacion` varchar(100) NOT NULL,
  PRIMARY KEY (`nombre`),
  KEY `nombre_grupo_investigacion` (`nombre_grupo_investigacion`),
  CONSTRAINT `proyecto_ibfk_1` FOREIGN KEY (`nombre_grupo_investigacion`) REFERENCES `grupo_investigacion` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyecto`
--

LOCK TABLES `proyecto` WRITE;
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` VALUES ('Análisis Genómico Computacional',217,71000000.00,'2026-02-05','2027-02-05','GI-Biocomputación'),('Arquitectura Web Modular',203,28500000.00,'2026-03-01','2026-12-15','GI-Ingeniería de Software'),('Balanceo de Carga en Clúster',208,41000000.00,'2026-02-15','2026-11-30','GI-Sistemas Distribuidos'),('Calidad del Aire en Bogotá',214,51000000.00,'2026-03-01','2026-12-28','GI-Ecología y Datos'),('Clasificación de Imágenes Médicas',209,67500000.00,'2026-01-10','2026-12-01','GI-Visión Artificial'),('Control PID en Brazos Mecánicos',215,43500000.00,'2026-01-30','2026-11-15','GI-Control y Procesos'),('Detección de Intrusos en Red',204,54000000.00,'2026-02-10','2026-12-20','GI-Seguridad Informática'),('Evaluación de Pipelines RISC',218,36000000.00,'2026-03-15','2026-12-05','GI-Hardware y Sistemas'),('Gobierno de Datos Abiertos',220,31000000.00,'2026-04-01','2026-12-15','GI-Innovación Pública'),('Microred Solar Académica',211,95000000.00,'2026-01-25','2027-01-25','GI-Energía Sostenible'),('Monitoreo Ambiental con IoT',206,39000000.00,'2026-03-10','2026-12-10','GI-IoT y Sensores'),('Navegación Autónoma en Campus',205,78000000.00,'2026-01-20','2026-11-25','GI-Robótica Móvil'),('Optimización de Rutas Urbanas',212,34000000.00,'2026-04-10','2026-12-18','GI-Modelos Matemáticos'),('Predicción Académica con IA',201,45000000.00,'2026-02-01','2026-11-30','GI-IA Aplicada'),('Repositorio Abierto de Datos',219,29500000.00,'2026-02-18','2026-10-31','GI-Información y Conocimiento'),('Resumen Automático de Tesis',210,25000000.00,'2026-03-05','2026-10-15','GI-PLN y Lingüística'),('Simulación de Circuitos Cuánticos',207,62000000.00,'2026-04-01','2027-03-31','GI-Arquitecturas Cuánticas'),('Simulador de Luz y Sombra 2D',216,22000000.00,'2026-05-01','2026-11-30','GI-Interactivos y Gráficos'),('Tablero de Indicadores Universitarios',202,32000000.00,'2026-01-15','2026-10-30','GI-Datos y Analítica'),('Telemetría de Baja Latencia',213,48000000.00,'2026-02-20','2026-11-20','GI-Redes Avanzadas');
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;
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
