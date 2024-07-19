-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: M.T.I. Marco A. Ramírez Hernández
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  18 de Julio de 2024


-- Tabla 1:  Usuarios 
CREATE TABLE `tbb_usuarios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Persona_ID` int unsigned NOT NULL,
  `Nombre_Usuario` varchar(60) NOT NULL,
  `Correo_Electronico` varchar(100) NOT NULL,
  `Contrasena` varchar(40) NOT NULL,
  `Numero_Telefonico_Movil` char(19) NOT NULL,
  `Estatus` enum('Activo','Inactivo','Bloqueado','Suspendido') DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Correo_Electronico_UNIQUE` (`Correo_Electronico`),
  UNIQUE KEY `Nombre_Usuario_UNIQUE` (`Nombre_Usuario`),
  UNIQUE KEY `Numero_Telefonico_Movil_UNIQUE` (`Numero_Telefonico_Movil`),
  KEY `fk_Personas_2_idx` (`Persona_ID`),
  CONSTRAINT `fk_Personas_2` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--  Tabla 2: Roles
CREATE TABLE `tbc_roles` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Descripcion` text,
  `Estatus` bit(1) DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Tabla 3: Usuarios_Roles
CREATE TABLE `tbd_usuarios_roles` (
  `Usuario_ID` int unsigned NOT NULL,
  `Rol_ID` int unsigned NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Usuario_ID`,`Rol_ID`),
  KEY `Rol_ID` (`Rol_ID`),
  CONSTRAINT `tbd_usuarios_roles_ibfk_1` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`ID`),
  CONSTRAINT `tbd_usuarios_roles_ibfk_2` FOREIGN KEY (`Rol_ID`) REFERENCES `tbc_roles` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


