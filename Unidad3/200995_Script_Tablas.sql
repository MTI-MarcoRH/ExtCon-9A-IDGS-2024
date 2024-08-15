-- SCRIPT DE CREACION DE TABLAS ASIGNADAS
-- Elaborado por: Jesus Rios Gomez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Archivo: tablas.sql

CREATE TABLE tbd_puestos_departamentos (
    PuestoID int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nombre varchar(100) NOT NULL,
    Descripcion varchar(255),
    Salario decimal(10,2),
    Turno enum('Mañana','Tarde','Noche'),
    Creado timestamp DEFAULT CURRENT_TIMESTAMP,
    Modificado timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    DepartamentoID int UNSIGNED NOT NULL,
    FOREIGN KEY (DepartamentoID) REFERENCES tbc_departamentos(ID)
);

CREATE TABLE `tbc_puestos` (
  `PuestoID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Salario` decimal(10,2) DEFAULT NULL,
  `Turno` enum('Mañana','Tarde','Noche') DEFAULT NULL,
  `Creado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Modificado` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PuestoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
