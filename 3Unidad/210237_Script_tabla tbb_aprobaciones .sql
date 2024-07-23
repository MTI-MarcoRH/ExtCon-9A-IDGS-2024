-- Scrip de la Creacion de la Tabla Asignada
--Elaborado por Carlos Iván Crespo Alvarado
-- Programa Educativo: Ingenieria de Desarrollo y Gestion de Software
-- Fecha de Elaboración: 22 de julio de 2024

CREATE TABLE `tbb_aprobaciones` (
  `ID` int NOT NULL,
  `Personal_Medico_ID` int NOT NULL,
  `Solicitud_ID` int NOT NULL,
  `Comentario` text,
  `Estatus` enum('En Proceso','Pausado','Aprobado','Reprogramado','Cancelado') NOT NULL,
  `Tipo` enum('Servicio Interno','Traslados','Subrogado','Administrativo') NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ;