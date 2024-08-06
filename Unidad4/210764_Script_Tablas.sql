-- Script de la creación de la tabla tbc_organos

-- Elaborado por : Karen Alyn Fosado Rodriguez
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 22 de julio de 2024 

DROP TABLE IF EXISTS `tbc_organos`;

CREATE TABLE `tbc_organos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Aparato_Sistema` enum('Circulatorio','Digestivo','Respiratorio','Nervioso','Muscular','Esquelético','Endocrino','Linfático','Inmunológico','Reproductor','Urinario','Sensorial') NOT NULL,
  `Descripcion` text NOT NULL,
  `Disponibilidad` enum('Disponible','No Disponible','Reservado') NOT NULL,
  `Tipo` enum('Vital','No Vital') NOT NULL,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  `Fecha_Registro` datetime DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
