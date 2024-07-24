-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Elí Aidan Melo Calva
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla 1:  Nacimientos
 CREATE TABLE `tbb_nacimientos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Padre` varchar(100) NOT NULL,
  `Madre` varchar(100) NOT NULL,
  `Signos_vitales` varchar(10) NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Calificacion_APGAR` int NOT NULL,
  `Observaciones` varchar(45) NOT NULL,
  `Genero` enum('M','F') NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_nacimientos_1` FOREIGN KEY (`ID`) REFERENCES `tbb_cirugias` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;