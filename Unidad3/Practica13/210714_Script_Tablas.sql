-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla 1:  Valoraciones Medicas
DROP TABLE IF EXISTS `tbb_valoraciones_medicas`;

CREATE TABLE `tbb_valoraciones_medicas` (
  `id` int NOT NULL,
  `paciente_id` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `antecedentes_personales` text,
  `antecedentes_familiares` text,
  `antecedentes_medicos` text,
  `sintomas_signos` text,
  `examen_fisico` text,
  `pruebas_diagnosticas` text,
  `diagnostico` text,
  `plan_tratamiento` text,
  `seguimiento` text,
  `fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
