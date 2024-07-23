-- SCRIPT DE CREACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Arturo Aguilar Santos
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Tabla 1:  Expediente Clínico

CREATE TABLE `tbd_expedientes_clinicos` (
  `Persona_ID` int unsigned NOT NULL,
  `Antecendentes_Medicos_Patologicos` varchar(80) NOT NULL,
  `Antecendentes_Medicos_NoPatologicos` varchar(80) NOT NULL,
  `Antecendentes_Medicos_Patologicos_HeredoFamiliares` varchar(80) NOT NULL,
  `Interrogatorio_Sistemas` varchar(80) NOT NULL,
  `Padecimiento_Actual` varchar(80) NOT NULL,
  `Notas_Medicas` varchar(80) DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  KEY `fk_expedientes_1_idx` (`Persona_ID`),
  CONSTRAINT `fk_expedientes_1` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
