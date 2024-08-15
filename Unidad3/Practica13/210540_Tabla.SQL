/*
-> Script de la creacion de la tabla recetas 
->Elaborado por: Marvin Yair Tolentino Perez 
-> Grado: 9, Grupo: A 
-> Ingenieria en gestion y desarrollo de software 
-> Fecha de Elaboracion: 20/07/2024
*/

CREATE TABLE `tbd_recetas_medicas` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `paciente_nombre` varchar(100) NOT NULL,
    `paciente_edad` int unsigned NOT NULL,
    `sexo` enum('Masculino','Femenino') NOT NULL,
    `medico_nombre` varchar(100) NOT NULL,
    `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fecha_actualizacion` date DEFAULT NULL,
    `diagnostico` varchar(255) NOT NULL,
    `medicamentos` text NOT NULL,
    `indicaciones` text NOT NULL,
    `id_paciente` int unsigned NOT NULL,
    `id_medico` int unsigned NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_recetas_pacientes_idx` (`id_medico`),
    KEY `fk_receta_paciente_idx` (`id_paciente`),
    CONSTRAINT `fk_receta_medico_1` FOREIGN KEY (`id_medico`) REFERENCES `tbb_personal_medico` (`Persona_ID`),
    CONSTRAINT `fk_receta_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `tbb_pacientes` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci