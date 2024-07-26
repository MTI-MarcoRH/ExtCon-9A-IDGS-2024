-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Daniela Aguilar Torres
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio

-- Tabla de Consumibles

CREATE TABLE `tbc_consumibles` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text,
  `Cantidad` int unsigned NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `Departamento_ID` int unsigned NOT NULL,
  `Estatus` enum('Activo','Inactivo','En Revisión') NOT NULL DEFAULT 'Activo',
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Observaciones` text,
  `Espacio_Medico` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


------------- Tabla Derivada Cirugia Consumibles --------------------------------------------

CREATE TABLE `tbd_cirugia_consumibles` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Cirugia_ID` int NOT NULL,
  `Consumible_ID` int NOT NULL,
  `Cantidad_Utilizada` int unsigned NOT NULL,
  `Fecha_Registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_cirugia` (`Cirugia_ID`),
  KEY `fk_consumibles` (`Consumible_ID`),
  CONSTRAINT `fk_cirugia` FOREIGN KEY (`Cirugia_ID`) REFERENCES `tbb_cirugias` (`ID`),
  CONSTRAINT `fk_consumibles` FOREIGN KEY (`Consumible_ID`) REFERENCES `tbc_consumibles` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

