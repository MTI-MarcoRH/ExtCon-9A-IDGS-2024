-- Script de la creación de la tabla tbc_organos

-- Elaborado por : Karen Alyn Fosado Rodriguez
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 22 de julio de 2024 

DROP TABLE IF EXISTS `tbc_organos`;

CREATE TABLE `tbc_organos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Aparato_Sistema` enum('Circulatorio','Digestivo','Respiratorio','Nervioso','Muscular','Esquelético','Endocrino','Linfático','Inmunológico','Reproductor','Urinario','Sensorial') NOT NULL,
  `Detalles_Adicionales` text,
  `Disponibilidad` enum('En Proceso','Disponible','No Disponible','Reservado','Entregado') NOT NULL,
  `Tipo` enum('Vital','No Vital') NOT NULL,
  `Fecha_Extraccion` datetime DEFAULT NULL,
  `Edad_Donante` int DEFAULT NULL,
  `Grupo_Sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `Estado_Salud` enum('Excelente','Bueno','Regular','Pobre','Crítico') NOT NULL,
  `Enfermedades_Transmisibles` tinyint(1) NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_tbc_organos_ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

