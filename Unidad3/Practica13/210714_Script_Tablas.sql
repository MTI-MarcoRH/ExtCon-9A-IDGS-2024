-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla 1:  Valoraciones Medicas
CREATE TABLE `tbb_valoraciones_medicas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Valor` decimal(10,2) NOT NULL,
  `Indicador` varchar(100) NOT NULL,
  `Unidad_medida` varchar(50) NOT NULL,
  `Paciente_id` int NOT NULL,
  `Cita_id` int NOT NULL,
  `Pm_id` int NOT NULL,
  `Estatus` tinyint(1) NOT NULL,
  `Fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
