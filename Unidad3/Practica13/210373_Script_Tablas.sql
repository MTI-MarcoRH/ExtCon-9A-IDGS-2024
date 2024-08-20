-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Juan Manuel Cruz Ortiz
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Tabla: Estudios
CREATE TABLE `tbc_estudios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Tipo` varchar(50) NOT NULL,
  `Nivel_Urgencia` varchar(50) NOT NULL,
  `Solicitud_ID` int unsigned NOT NULL,
  `Consumibles_ID` int DEFAULT NULL,
  `Estatus` varchar(50) NOT NULL,
  `Total_Costo` decimal(10,2) NOT NULL,
  `Dirigido_A` varchar(100) DEFAULT NULL,
  `Observaciones` text,
  `Fecha_Registro` datetime NOT NULL,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  `ConsumibleID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_solicitud_1` FOREIGN KEY (`Solicitud_ID`) REFERENCES `tbd_solicitudes` (`ID`),
  CONSTRAINT `fk_consumible_1` FOREIGN KEY (`Consumibles_ID`) REFERENCES `tbc_consumibles` (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Script para la creacion de una tabla derivada
SELECT tipo, departamento, SUM(cantidad_existencia) AS total_existencia, COUNT(id) AS numero_consumibles
FROM (
    SELECT id, tipo, departamento, cantidad_existencia
    FROM tbc_consumibles
    WHERE estatus = 1  -- Suponiendo que 1 significa que el consumible está activo
) AS consumibles_activos
GROUP BY tipo, departamento;