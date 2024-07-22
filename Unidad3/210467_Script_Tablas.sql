-- SCRIPT DE CREACIÓN DE LA TABLA ASIGNADA

-- ELABORADO POR: MYRIAM VALDERRABANO CORTES
-- GRADO Y GRUPO: 9°
-- PROGRAMA EDUCATIVO: INGENIERÍA EN DESARROLLO Y GESTIÓN DE SOFTWARE
-- FECHA DE ELABORACIÓN: 21 DE JULIO DE 2024


DROP TABLE IF EXISTS `tbd_lotes_medicamentos`;

CREATE TABLE `tbd_lotes_medicamentos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Medicamento_ID` int unsigned NOT NULL,
  `Personal_Medico_ID` int unsigned NOT NULL,
  `Clave` varchar(50) NOT NULL,
  `Estatus` enum('Reservado','En transito','Recibido','Rechazado') NOT NULL,
  `Costo_Total` float unsigned NOT NULL,
  `Cantidad` int unsigned NOT NULL,
  `Ubicacion` varchar(100) NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_medicamentos_1_idx` (`Medicamento_ID`),
  KEY `fk_personal_medico_3_idx` (`Personal_Medico_ID`),
  CONSTRAINT `fk_medicamentos_1` FOREIGN KEY (`Medicamento_ID`) REFERENCES `tbc_medicamentos` (`ID`),
  CONSTRAINT `fk_personal_medico_3` FOREIGN KEY (`Personal_Medico_ID`) REFERENCES `tbb_personal_medico` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
