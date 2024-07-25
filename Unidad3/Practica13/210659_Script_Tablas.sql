-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Justin Martin Muñoz Escorcia
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024


-- Tabla 1:  Pacientes 
CREATE TABLE `tbb_pacientes` (
  `Persona_ID` int unsigned NOT NULL,
  `NSS` varchar(15) DEFAULT NULL,
  `Tipo_Seguro` varchar(50) NOT NULL,
  `Fecha_Ultima_Cita` datetime DEFAULT NULL,
  `Estatus_Medico` varchar(100) DEFAULT 'Normal',
  `Estatus_Vida` enum('Vivo','Finado','Coma','Vegetativo') NOT NULL DEFAULT 'Vivo',
  `Estatus` binary(1) DEFAULT '',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  UNIQUE KEY `NSS_UNIQUE` (`NSS`),
  CONSTRAINT `fk_pacientes_1` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='	';

--  Tabla 2: Seguimiento Pacientes
CREATE TABLE `tbd_seguimiento_pacientes` (
  `Paciente_ID` int unsigned NOT NULL,
  `Personal_Medico_ID` int unsigned NOT NULL,
  `Observaciones` varchar(100) NOT NULL,
  `Estatus` binary(1) DEFAULT '',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  KEY `fk_pacientes_2` (`Paciente_ID`),
  KEY `fk_personal_medico_2_idx` (`Personal_Medico_ID`),
  CONSTRAINT `fk_pacientes_2` FOREIGN KEY (`Paciente_ID`) REFERENCES `tbb_pacientes` (`Persona_ID`),
  CONSTRAINT `fk_personal_medico_3` FOREIGN KEY (`Personal_Medico_ID`) REFERENCES `tbb_personal_medico` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
