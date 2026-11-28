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
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `codigo` bigint NOT NULL,
  `clave` varchar(255) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `cedula_profesor` bigint DEFAULT NULL,
  `codigo_estudiante` bigint DEFAULT NULL,
  `sn` varchar(100) NOT NULL DEFAULT 's',
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `uk_usuario_cedula_profesor` (`cedula_profesor`),
  UNIQUE KEY `uk_usuario_codigo_estudiante` (`codigo_estudiante`),
  CONSTRAINT `fk_usuario_estudiante` FOREIGN KEY (`codigo_estudiante`) REFERENCES `estudiante` (`codigo`),
  CONSTRAINT `fk_usuario_profesor` FOREIGN KEY (`cedula_profesor`) REFERENCES `profesor` (`cedula`),
  CONSTRAINT `chk_usuario_rol` CHECK ((((`rol` = _utf8mb4'ADMIN') and (`cedula_profesor` is null) and (`codigo_estudiante` is null)) or ((`rol` = _utf8mb4'ESTUDIANTE') and (`cedula_profesor` is null) and (`codigo_estudiante` is not null)) or ((`rol` in (_utf8mb4'PROFESOR',_utf8mb4'LIDER',_utf8mb4'DECANO')) and (`cedula_profesor` is not null) and (`codigo_estudiante` is null)))),
  CONSTRAINT `chk_usuario_rol_valido` CHECK ((`rol` in (_utf8mb4'ADMIN',_utf8mb4'ESTUDIANTE',_utf8mb4'PROFESOR',_utf8mb4'LIDER',_utf8mb4'DECANO'))),
  CONSTRAINT `chk_usuario_sn` CHECK ((`sn` in (_utf8mb4's',_utf8mb4'n',_utf8mb4'S',_utf8mb4'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin_clave_01','ADMIN',NULL,NULL,'s'),(2,'admin_clave_02','ADMIN',NULL,NULL,'s'),(3,'decano_clave_01','DECANO',101001,NULL,'s'),(4,'decano_clave_02','DECANO',101004,NULL,'s'),(5,'lider_clave_01','LIDER',101007,NULL,'s'),(6,'lider_clave_02','LIDER',101003,NULL,'s'),(7,'lider_clave_03','LIDER',101009,NULL,'s'),(8,'prof_clave_01','PROFESOR',101002,NULL,'s'),(9,'prof_clave_02','PROFESOR',101005,NULL,'s'),(10,'prof_clave_03','PROFESOR',101006,NULL,'s'),(11,'prof_clave_04','PROFESOR',101008,NULL,'s'),(12,'prof_clave_05','PROFESOR',101010,NULL,'n'),(13,'est_clave_01','ESTUDIANTE',NULL,20261001,'s'),(14,'est_clave_02','ESTUDIANTE',NULL,20261002,'s'),(15,'est_clave_03','ESTUDIANTE',NULL,20261003,'s'),(16,'est_clave_04','ESTUDIANTE',NULL,20261004,'s'),(17,'est_clave_05','ESTUDIANTE',NULL,20261005,'s'),(18,'est_clave_06','ESTUDIANTE',NULL,20261006,'s'),(19,'est_clave_07','ESTUDIANTE',NULL,20261007,'n'),(20,'est_clave_08','ESTUDIANTE',NULL,20261008,'s');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
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
