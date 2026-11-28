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
-- Table structure for table `grupo_investigacion`
--

DROP TABLE IF EXISTS `grupo_investigacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_investigacion` (
  `nombre` varchar(100) NOT NULL,
  `codigo` int NOT NULL,
  `cod_area_interes` int NOT NULL,
  `cedula_profesor` bigint NOT NULL,
  `nombre_facultad` varchar(100) NOT NULL,
  PRIMARY KEY (`nombre`),
  KEY `cedula_profesor` (`cedula_profesor`),
  KEY `nombre_facultad` (`nombre_facultad`),
  KEY `cod_area_interes` (`cod_area_interes`),
  CONSTRAINT `grupo_investigacion_ibfk_1` FOREIGN KEY (`cedula_profesor`) REFERENCES `profesor` (`cedula`),
  CONSTRAINT `grupo_investigacion_ibfk_2` FOREIGN KEY (`nombre_facultad`) REFERENCES `facultad` (`nombre`),
  CONSTRAINT `grupo_investigacion_ibfk_3` FOREIGN KEY (`cod_area_interes`) REFERENCES `areai` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_investigacion`
--

LOCK TABLES `grupo_investigacion` WRITE;
/*!40000 ALTER TABLE `grupo_investigacion` DISABLE KEYS */;
INSERT INTO `grupo_investigacion` VALUES ('GI-Arquitecturas Cuánticas',107,7,101013,'Facultad de Ciencias Exactas'),('GI-Biocomputación',117,17,101002,'Facultad de Bioingeniería'),('GI-Control y Procesos',115,15,101019,'Facultad de Mecánica y Materiales'),('GI-Datos y Analítica',102,2,101004,'Facultad de Ciencias Matemáticas y Naturales'),('GI-Ecología y Datos',114,14,101014,'Facultad de Medio Ambiente'),('GI-Energía Sostenible',111,11,101011,'Facultad de Energía y Potencia'),('GI-Hardware y Sistemas',118,18,101005,'Facultad de Estudios Interdisciplinarios'),('GI-IA Aplicada',101,1,101007,'Facultad de Ingeniería'),('GI-Información y Conocimiento',119,19,101008,'Facultad de Ciencias Aplicadas'),('GI-Ingeniería de Software',103,3,101001,'Facultad Tecnológica'),('GI-Innovación Pública',120,20,101006,'Facultad de Sostenibilidad Urbana'),('GI-Interactivos y Gráficos',116,16,101020,'Facultad de Posgrados en Tecnología'),('GI-IoT y Sensores',106,6,101017,'Facultad de Telecomunicaciones'),('GI-Modelos Matemáticos',112,12,101015,'Facultad de Ciencias Básicas'),('GI-PLN y Lingüística',110,10,101010,'Facultad de Artes y Diseño'),('GI-Redes Avanzadas',113,13,101017,'Facultad de Telecomunicaciones'),('GI-Robótica Móvil',105,5,101009,'Facultad de Robótica y Automatización'),('GI-Seguridad Informática',104,4,101016,'Facultad de Sistemas y Redes'),('GI-Sistemas Distribuidos',108,8,101003,'Facultad Tecnológica'),('GI-Visión Artificial',109,9,101012,'Facultad de Innovación Digital');
/*!40000 ALTER TABLE `grupo_investigacion` ENABLE KEYS */;
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
