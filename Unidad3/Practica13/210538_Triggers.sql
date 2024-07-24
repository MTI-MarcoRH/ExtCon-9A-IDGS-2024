-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Elí Aidan Melo Calva
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de Nacimientos
-- 1) AFTER INSERT NACIMIENTOS
CREATE DEFINER=`eli.aidan`@`%` TRIGGER `tbb_nacimientos_AFTER_INSERT` AFTER INSERT ON `tbb_nacimientos` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora 
    VALUES ( default,
        current_user(), 
        'Create',
        'tbb_nacimientos', 
        CONCAT_WS('', 
            'Se ha agregado un nuevo registro en tbb_nacimientos con el ID: ', NEW.ID,
            ', con los siguientes datos; ',
            'Nombre del Padre: ', NEW.Padre,
            ', Nombre de la Madre: ', NEW.Madre,
            ', Signos Vitales: ', NEW.Signos_vitales,
            ', Estatus: ', NEW.Estatus,
            ', Calificación APGAR: ', NEW.Calificacion_APGAR,
            ', Observaciones: ', NEW.Observaciones,
            ', Genero: ', NEW.Genero
        ), 
        default,
        default
    );
END

-- 2) BEFORE UPDATE NACIMIENTOS
CREATE DEFINER=`eli.aidan`@`%` TRIGGER `tbb_nacimientos_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_nacimientos` FOR EACH ROW BEGIN
	SET new.fecha_actualizacion = current_timestamp();
END

-- 3) AFTER UPDATE NACIMIENTOS
CREATE DEFINER=`eli.aidan`@`%` TRIGGER `tbb_nacimientos_AFTER_UPDATE` AFTER UPDATE ON `tbb_nacimientos` FOR EACH ROW BEGIN
	INSERT INTO tbi_bitacora 
    VALUES ( default,
		current_user(),
        'Update', 
        'tbb_nacimientos', 
        CONCAT_WS('', 
            'Se ha actualizado el registro en tbb_nacimientos con el ID: ', NEW.ID,
            ', con los siguientes datos actualizados; ',
            'Nombre del Padre: ', NEW.Padre,
            ', Nombre de la Madre: ', NEW.Madre,
            ', Signos Vitales: ', NEW.Signos_vitales,
            ', Estatus: ', NEW.Estatus,
            ', Calificación APGAR: ', NEW.Calificacion_APGAR,
            ', Observaciones: ', NEW.Observaciones,
            ', Genero: ', NEW.Genero
        ), 
        default,
        default
    );
END

-- 4) AFTER DELETE NACIMIENTOS
CREATE DEFINER=`eli.aidan`@`%` TRIGGER `tbb_nacimientos_AFTER_DELETE` AFTER DELETE ON `tbb_nacimientos` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora
    VALUES ( default,
		current_user(),
        'Delete', 
        'tbb_nacimientos',
        CONCAT_WS('', 
            'Se ha eliminado un registro en tbb_nacimientos con el ID: ', OLD.ID,
            ', que contenía los siguientes datos; ',
            'Nombre del Padre: ', OLD.Padre,
            ', Nombre de la Madre: ', OLD.Madre,
            ', Signos Vitales: ', OLD.Signos_vitales,
            ', Estatus: ', OLD.Estatus,
            ', Calificación APGAR: ', OLD.Calificacion_APGAR,
            ', Observaciones: ', OLD.Observaciones,
            ', Genero: ', OLD.Genero
        ), 
        default,
        default
    );
END