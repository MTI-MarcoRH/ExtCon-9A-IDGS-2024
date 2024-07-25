-- Scrip de la Creacion de la Tabla Asignada
--Elaborado por Carlos Iván Crespo Alvarado
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingenieria de Desarrollo y Gestion de Software
-- Fecha de Elaboración: 22 de julio de 2024

-- Tabla 1:  Aprobaciones

CREATE TABLE `tbb_aprobaciones` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Personal_Medico_ID` int unsigned NOT NULL,
  `Solicitud_ID` int unsigned NOT NULL,
  `Comentario` text,
  `Estatus` enum('En Proceso','Pausado','Aprobado','Reprogramado','Cancelado') NOT NULL,
  `Tipo` enum('Servicio Interno','Traslados','Subrogado','Administrativo') NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_aprobaciones_idx` (`Personal_Medico_ID`),
  KEY `fk_aprobaciones_solicitud_idx` (`Solicitud_ID`),
  CONSTRAINT `fk_aprobaciones_personal_medico` FOREIGN KEY (`Personal_Medico_ID`) REFERENCES `tbb_personal_medico` (`Persona_ID`),
  CONSTRAINT `fk_aprobaciones_solicitud` FOREIGN KEY (`Solicitud_ID`) REFERENCES `tbd_solicitudes` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci