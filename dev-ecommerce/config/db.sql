SET NAMES utf8mb4;
-- usuarios grupos

DROP TABLE IF EXISTS `usuarios_grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_grupos` (
  `grp_id` int NOT NULL AUTO_INCREMENT,
  `grp_nombre` varchar(100) NOT NULL,
  `grp_descripcion` varchar(200) NOT NULL,
  `grp_habilitado` tinyint(1) NOT NULL,
  PRIMARY KEY (`grp_id`)
);

-- grupo grupos usuarios
DROP TABLE IF EXISTS `usuarios_grupo_grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_grupo_grupos` (
  `ugg_id` int NOT NULL AUTO_INCREMENT,
  `ugggrp_id` int NOT NULL,
  `ugggrp_idchild` int NOT NULL,
  PRIMARY KEY (`ugg_id`),
  KEY `ugggrp_id` (`ugggrp_id`),
  KEY `ugggrp_idchild` (`ugggrp_idchild`),
  CONSTRAINT `ugggrp_id` FOREIGN KEY (`ugggrp_id`) REFERENCES `usuarios_grupos` (`grp_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `ugggrp_idchild` FOREIGN KEY (`ugggrp_idchild`) REFERENCES `usuarios_grupos` (`grp_id`) ON DELETE CASCADE ON UPDATE RESTRICT
);

-- usuarios roles
DROP TABLE IF EXISTS `usuarios_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_roles` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(100) NOT NULL,
  `rol_descripcion` varchar(200) NOT NULL,
  `rol_habilitado` tinyint(1) NOT NULL,
  `rol_modusuarios` int NOT NULL,
  `rol_moddiversidad` int NOT NULL,
  PRIMARY KEY (`rol_id`)
);

-- usuarixs login

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usr_id` int NOT NULL AUTO_INCREMENT,
  `usrrol_id` int NOT NULL,
  `usrgrp_id` int NOT NULL,
  `usr_email` varchar(100) NOT NULL,
  `usr_nombres` varchar(100) NOT NULL,
  `usr_apellidos` varchar(100) NOT NULL,
  `usr_password` varchar(150) NOT NULL,
  `usr_resetpassword` varchar(100) NOT NULL,
  `usr_habilitado` tinyint(1) NOT NULL,
  PRIMARY KEY (`usr_id`),
  UNIQUE KEY `usr_email` (`usr_email`),
  KEY `usrrol_id` (`usrrol_id`),
  KEY `usrgrp_id` (`usrgrp_id`),
  CONSTRAINT `usrgrp_id` FOREIGN KEY (`usrgrp_id`) REFERENCES `usuarios_grupos` (`grp_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `usrrol_id` FOREIGN KEY (`usrrol_id`) REFERENCES `usuarios_roles` (`rol_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
);

SET character_set_client = utf8mb4;
CREATE TABLE IF NOT EXISTS `categorias` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `categorias` WRITE;
UNLOCK TABLES;

SET character_set_client = utf8mb4;
CREATE TABLE IF NOT EXISTS `productos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `IdCategoria` int NOT NULL,
  `Descripcion` varchar(100) NULL,
  `Precio` INT NOT NULL,
  `Stock` tinyint default NULL,
  PRIMARY KEY (`Id`),
  KEY(`IdCategoria`),
  CONSTRAINT `productos_catgorias` FOREIGN KEY (`IdCategoria`) REFERENCES `categorias` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `productos` WRITE;
UNLOCK TABLES;


SET character_set_client = utf8mb4 ;
CREATE TABLE IF NOT EXISTS `productos_metadata` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `IdProducto` INT NULL,
  `NombreArchivo` VARCHAR(600) NOT NULL,
  `LineaArchivo` INT NOT NULL,
  `OcurrioError` TINYINT(1) NOT NULL,
  `Error` VARCHAR(600) NULL DEFAULT NULL,
  `Creado` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY (`Id`)
  )  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `productos_metadata` WRITE;
UNLOCK TABLES;


LOCK TABLES `usuarios_grupos` WRITE;
/*!40000 ALTER TABLE `usuarios_grupos` DISABLE KEYS */;
INSERT INTO `usuarios_grupos` VALUES (11,'Admin','',1);
/*!40000 ALTER TABLE `usuarios_grupos` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `usuarios_roles` WRITE;
/*!40000 ALTER TABLE `usuarios_roles` DISABLE KEYS */;
INSERT INTO `usuarios_roles` VALUES (1,'Admin','Administrador',1,7,7);
/*!40000 ALTER TABLE `usuarios_roles` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,1,11,'admin@ecommerce.com','admin','admin','wxaCUDtL1D3fd74cd070e7ee45098d298d2c63208ec659adc03b47eeb7612fab0d3d552d43e165c2bca9028cc03be74720b8170b86aa37','',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO `categorias` (Id, Nombre) VALUES (1, "Frutas y verduras");
INSERT INTO `categorias` (Id, Nombre)VALUES (2, "Cervezas y aperitivos");
INSERT INTO `categorias` (Id, Nombre)VALUES (3, "Productos para la higiene");
INSERT INTO `categorias` (Id, Nombre)VALUES (4, "Accesorios de limpieza");
