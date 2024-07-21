-- Script de creacion de las tablas asignadas


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 21 de julio de 2024 

DROP TABLE IF EXISTS `tbc_medicamentos`;

CREATE TABLE `tbc_medicamentos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre_comercial` varchar(80) NOT NULL,
  `Nombre_generico` varchar(80) NOT NULL,
  `Via_administracion` enum('Oral','Intravenoso','Rectal','Cutáneo','Subcutáneo','Oftálmica','Ótica','Nasal','Tópica','Parenteral') NOT NULL,
  `Presentacion` enum('Comprimidos','Grageas','Cápsulas','Jarabes','Gotas','Solución','Pomada','Jabón','Supositorios','Viales') NOT NULL,
  `Tipo` enum('Analgésicos','Antibióticos','Antidepresivos','Antihistamínicos','Antiinflamatorios','Antipsicóticos') NOT NULL,
  `Cantidad` decimal(10,2)  NOT NULL,
  `Volumen` decimal(10,2)  NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  `Fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ---------------------------------------------------- Tabla de tbd_dispensaciones --------------------------------------------------------

DROP TABLE IF EXISTS `tbd_dispensaciones`;

CREATE TABLE `tbd_dispensaciones` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `RecetaMedica_id` int unsigned DEFAULT NULL,
  `PersonalMedico_id` int unsigned NOT NULL,
  `Solicitud_id` int unsigned DEFAULT NULL,
  `Estatus` enum('Abastecida','Parcialmente abastecida') NOT NULL,
  `Tipo` enum('Pública','Privada','Mixta') NOT NULL,
  `TotalMedicamentosEntregados` int unsigned NOT NULL,
  `Total_costo` float NOT NULL,
  `Fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_receta_medica_1_idx` (`RecetaMedica_id`),
  KEY `fk_solicitudes_1_idx` (`Solicitud_id`),
  KEY `fk_personal_medico_1_idx` (`PersonalMedico_id`),
  CONSTRAINT `fk_personal_medico_1` FOREIGN KEY (`PersonalMedico_id`) REFERENCES `tbb_personal_medico` (`Persona_ID`),
  CONSTRAINT `fk_receta_medica_1` FOREIGN KEY (`RecetaMedica_id`) REFERENCES `tbd_recetas_medicas` (`id`),
  CONSTRAINT `fk_solicitudes_1` FOREIGN KEY (`Solicitud_id`) REFERENCES `tbd_solicitudes` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
