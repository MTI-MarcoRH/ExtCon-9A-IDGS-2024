-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Carlos Martin Hernández de Jesús
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla:  Solicitudes 
CREATE TABLE `tbd_solicitudes` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Paciente_ID` int unsigned NOT NULL,
  `Medico_ID` int unsigned NOT NULL,
  `Servicio_ID` int unsigned NOT NULL,
  `Prioridad` enum('Urgente','Alta','Moderada','Emergente','Normal') NOT NULL,
  `Descripcion` text,
  `Estatus` enum('Registrada','Programada','Cancelada','Reprogramada','En Proceso','Realizada') NOT NULL DEFAULT 'Registrada',
  `Estatus_Aprobacion` bit(1) NOT NULL DEFAULT b'0',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_personal_medico_1_idx` (`Medico_ID`),
  KEY `fk_paciente_1_idx` (`Paciente_ID`),
  KEY `fk_servicios_medicos_2_idx` (`Servicio_ID`),
  CONSTRAINT `fk_paciente_1` FOREIGN KEY (`Paciente_ID`) REFERENCES `tbb_pacientes` (`Persona_ID`),
  CONSTRAINT `fk_personal_medico_1` FOREIGN KEY (`Medico_ID`) REFERENCES `tbb_personal_medico` (`Persona_ID`),
  CONSTRAINT `fk_servicios_medicos_2` FOREIGN KEY (`Servicio_ID`) REFERENCES `tbc_servicios_medicos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;