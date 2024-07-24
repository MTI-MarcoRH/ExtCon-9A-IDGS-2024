-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Armando Carrasco Vargas
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla 01: Resultados Estudios

CREATE TABLE `tbd_resultados_estudios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Paciente_ID` int unsigned NOT NULL,
  `Personal_Medico_ID` int unsigned NOT NULL,
  `Estudio_ID` int unsigned NOT NULL,
  `Folio` varchar(50) NOT NULL,
  `Resultados` text NOT NULL,
  `Observaciones` text NOT NULL,
  `Estatus` enum('Pendiente','En Proceso','Completado','Aprobado','Rechazado') DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Folio` (`Folio`),
  KEY `Paciente_ID_idx` (`Paciente_ID`) /*!80000 INVISIBLE */,
  KEY `Personal_Medico_ID_idx` (`Personal_Medico_ID`),
  KEY `Estudio_ID_idx` (`Estudio_ID`),
  CONSTRAINT `fk_estudios_2` FOREIGN KEY (`Estudio_ID`) REFERENCES `tbc_estudios` (`ID`),
  CONSTRAINT `fk_pacientes_8` FOREIGN KEY (`Paciente_ID`) REFERENCES `tbb_pacientes` (`Persona_ID`),
  CONSTRAINT `fk_personal_medico_8` FOREIGN KEY (`Personal_Medico_ID`) REFERENCES `tbb_personal_medico` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
