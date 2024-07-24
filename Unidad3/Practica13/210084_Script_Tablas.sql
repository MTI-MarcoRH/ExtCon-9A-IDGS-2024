-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Janeth Ahuacatitla Amixtlan
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla:  Citas Medicas 
CREATE TABLE `tbb_citas_medicas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Personal_Medico_ID` int unsigned NOT NULL,
  `Paciente_ID` int unsigned NOT NULL,
  `Servicio_Medico_ID` int unsigned NOT NULL,
  `Folio` varchar(60) NOT NULL,
  `Tipo` enum('Revisión','Diagnóstico','Tratamiento','Rehabilitación','Preoperatoria','Postoperatoria','Proceminientos','Seguimiento') NOT NULL,
  `Espacio_ID` int unsigned NOT NULL,
  `Fecha_Programada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Inicio` datetime DEFAULT NULL,
  `Fecha_Termino` datetime DEFAULT NULL,
  `Observaciones` text NOT NULL,
  `Estatus` enum('Programada','Atendida','Cancelada','Reprogramada','No atendida','En proceso') NOT NULL DEFAULT 'Programada',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Folio_UNIQUE` (`Folio`),
  KEY `fk_personal_medico_2_idx` (`Personal_Medico_ID`),
  KEY `fk_paciente_2_idx` (`Paciente_ID`),
  KEY `fk_servicio_medico_1_idx` (`Servicio_Medico_ID`),
  CONSTRAINT `fk_paciente_2` FOREIGN KEY (`Paciente_ID`) REFERENCES `tbb_pacientes` (`Persona_ID`),
  CONSTRAINT `fk_personal_medico_2` FOREIGN KEY (`Personal_Medico_ID`) REFERENCES `tbb_personal_medico` (`Persona_ID`),
  CONSTRAINT `fk_servicio_medico_1` FOREIGN KEY (`Servicio_Medico_ID`) REFERENCES `tbc_servicios_medicos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci