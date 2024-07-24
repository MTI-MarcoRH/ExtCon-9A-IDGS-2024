-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Jonathan Enrique Ibarra Canales
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Script creacion de la tabla Personal Médico


CREATE TABLE `tbb_personal_medico` (
  `Persona_ID` int unsigned NOT NULL,
  `Departamento_ID` int unsigned NOT NULL,
  `Cedula_Profesional` varchar(100) NOT NULL,
  `Tipo` enum('Médico','Enfermero','Administrativo','Directivo','Apoyo','Residente','Interno') NOT NULL,
  `Especialidad` varchar(255) DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Contratacion` datetime NOT NULL,
  `Fecha_Termino_Contrato` datetime DEFAULT NULL,
  `Salario` decimal(10,2) NOT NULL,
  `Estatus` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  UNIQUE KEY `Cedula_Profesional` (`Cedula_Profesional`),
  KEY `fk_personas_1_idx` (`Persona_ID`) /*!80000 INVISIBLE */,
  KEY `fk_departamentos_2_idx` (`Departamento_ID`),
  CONSTRAINT `fk_departamentos_2` FOREIGN KEY (`Departamento_ID`) REFERENCES `tbc_departamentos` (`ID`),
  CONSTRAINT `fk_personas_1` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`),
  CONSTRAINT `tbb_personal_medico_chk_1` CHECK ((`Salario` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Script creacion de la tabla 

CREATE TABLE `tbc_departamentos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'DESCRIPCION: Atributo clave primaria autoincremental que identificara cada registro del DEPARTAMENTO\nNATURALEZA: Cuantitativo\nTIPO: Numérico\nDOMINIO: Número Enteros Positivos\nCOMPOSICION:  1{0-9}*\n',
  `Nombre` varchar(100) NOT NULL COMMENT 'DESCRIPCION: Denominación del DEPARTAMENTO (Unidad de Negocio)\nNATURALEZA: Cualitativo\nTIPO: Alfanumerico\nDOMINIO: Letras y Numeros \nCOMPOSICION: 1{a-Z| |0-9}100',
  `AreaMedica_ID` int unsigned DEFAULT NULL,
  `Departamento_Superior_ID` int unsigned DEFAULT NULL,
  `Responsable_ID` int unsigned DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_area_medica_1` (`AreaMedica_ID`),
  KEY `fk_departamento_1` (`Departamento_Superior_ID`),
  CONSTRAINT `fk_area_medica_1` FOREIGN KEY (`AreaMedica_ID`) REFERENCES `tbc_areas_medicas` (`ID`),
  CONSTRAINT `fk_departamento_1` FOREIGN KEY (`Departamento_Superior_ID`) REFERENCES `tbc_departamentos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla catalogo que almacenara la informacion de cada departamento del hospital, en base a su estructura organizacional.';

