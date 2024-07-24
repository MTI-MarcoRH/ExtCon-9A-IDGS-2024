-- SCRIP DE CREACIÓN DE LA TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 18 de Julio del 2024

-- Tabla: tbb_personas

CREATE TABLE `tbb_personas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Titulo` varchar(20) DEFAULT NULL,
  `Nombre` varchar(80) NOT NULL,
  `Primer_Apellido` varchar(80) NOT NULL,
  `Segundo_Apellido` varchar(80) DEFAULT NULL,
  `CURP` varchar(18) DEFAULT NULL,
  `Genero` enum('M','F','N/B') NOT NULL,
  `Grupo_Sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CURP_UNIQUE` (`CURP`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci