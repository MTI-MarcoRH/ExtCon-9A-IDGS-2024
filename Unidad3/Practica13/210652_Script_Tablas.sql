-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Bruno Lemus Gonzalez
-- Grado y Grupo:  9° A  
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla 1:  Espacios

CREATE TABLE `tbc_espacios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Tipo` enum('Consultorio','Laboratorio','Quirófano','Sala de Espera','Edificio','Estacionamiento','Habitación','Cama','Sala Maternidad','Cunero','Anfiteatro','Oficina','Sala de Juntas','Auditorio','Cafeteria','Capilla','Farmacia','Ventanilla','Recepción','Piso') NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Departamento_ID` int unsigned NOT NULL,
  `Estatus` enum('Activo','Inactivo','En remodelación','Clausurado','Reubicado','Temporal') NOT NULL DEFAULT 'Activo',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  `Capacidad` int NOT NULL DEFAULT '0',
  `Espacio_superior_ID` int unsigned DEFAULT NULL,
  `tbc_espacioscol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`),
  KEY `fk_departamento_3_idx` (`Departamento_ID`),
  KEY `fk_espacios_1_idx` (`Espacio_superior_ID`),
  CONSTRAINT `fk_departamento_3` FOREIGN KEY (`Departamento_ID`) REFERENCES `tbc_departamentos` (`ID`),
  CONSTRAINT `fk_espacios_1` FOREIGN KEY (`Espacio_superior_ID`) REFERENCES `tbc_espacios` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
