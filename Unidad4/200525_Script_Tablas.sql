-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: AMÉRICA YAELY ESTUDILLO LICONA
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  05 de Agosto de 2024


-- Tabla 1:  áreas médicas 
CREATE TABLE `tbc_areas_medicas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Descripcion` text,
  `Estatus` enum('Activo','Inactivo') DEFAULT 'Activo',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

