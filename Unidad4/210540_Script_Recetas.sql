

CREATE TABLE `tbd_receta_medicamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_receta` int unsigned NOT NULL,
  `id_medicamento` int unsigned NOT NULL,
  `cantidad` int unsigned NOT NULL,
  `indicaciones` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medicamento_receta_1` (`id_medicamento`),
  KEY `fk_receta_medicamento_1` (`id_receta`),
  CONSTRAINT `fk_medicamento_receta_1` FOREIGN KEY (`id_medicamento`) REFERENCES `tbc_medicamentos` (`ID`),
  CONSTRAINT `fk_receta_medicamento_1` FOREIGN KEY (`id_receta`) REFERENCES `tbd_recetas_medicas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `tbd_recetas_medicas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha_cita` datetime NOT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `diagnostico` varchar(255) NOT NULL,
  `id_paciente` int unsigned NOT NULL,
  `id_medico` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recetas_pacientes_idx` (`id_medico`),
  KEY `fk_receta_paciente_idx` (`id_paciente`),
  CONSTRAINT `fk_receta_medico_2` FOREIGN KEY (`id_medico`) REFERENCES `tbb_personal_medico` (`Persona_ID`),
  CONSTRAINT `fk_receta_paciente_2` FOREIGN KEY (`id_paciente`) REFERENCES `tbb_pacientes` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `tbd_recetas_detalles` (
  `id_receta` int unsigned NOT NULL,
  `observaciones` varchar(255) NOT NULL,
  `recomendaciones` text NOT NULL,
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_recetas_detalles2_idx` (`id_receta`),
  CONSTRAINT `fk_recetas_detalles2` FOREIGN KEY (`id_receta`) REFERENCES `tbd_recetas_medicas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci




