-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Juan Manuel Cruz Ortiz
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de Usuarios
-- 1) AFTER INSERT USUARIOS
CREATE DEFINER=`Juan.cruz`@`%` TRIGGER `tbc_estudios_AFTER_INSERT` AFTER INSERT ON `tbc_estudios` FOR EACH ROW BEGIN
	INSERT INTO tbi_bitacora VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbb_estudios',
        CONCAT_WS(' ', 
            'Se ha creado un nuevo estudio médico con los siguientes datos:\n',
            'ID: ', NEW.ID, '\n',
            'Tipo: ', NEW.Tipo, '\n',
            'Estatus: ', NEW.Estatus, '\n',
            'Total Costo: ', NEW.Total_Costo, '\n',
            'Dirigido A: ', NEW.Dirigido_A, '\n',
            'Observaciones: ', NEW.Observaciones, '\n',
            'Nivel Urgencia: ', NEW.Nivel_Urgencia, '\n',
            'Fecha Registro: ', NEW.Fecha_Registro, '\n'),
        DEFAULT,
        DEFAULT
    );
END

-- 2) BEFORE UPDATE
CREATE DEFINER=`Juan.cruz`@`%` TRIGGER `tbb_estudios_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_estudios` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp();
END

-- 3) AFTER UPDATE
CREATE DEFINER=`Juan.cruz`@`%` TRIGGER `tbc_estudios_AFTER_UPDATE` AFTER UPDATE ON `tbc_estudios` FOR EACH ROW BEGIN
	INSERT INTO tbi_bitacora VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Update',
        'tbb_estudios',
        CONCAT_WS('',
            'Se ha actualizado un estudio médico con los siguientes datos:\n',
            'ID: ', NEW.ID, '\n',
            'Tipo: ', NEW.Tipo, '\n',
            'Estatus: ', NEW.Estatus, '\n',
            'Total Costo: ', NEW.Total_Costo, '\n',
            'Dirigido A: ', NEW.Dirigido_A, '\n',
            'Observaciones: ', NEW.Observaciones, '\n',
            'Nivel Urgencia: ', NEW.Nivel_Urgencia, '\n',
            'Fecha Registro: ', NEW.Fecha_Registro, '\n',
            'Fecha Actualización: ', NEW.Fecha_Actualizacion, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END

-- 4) AFTER DELETE
CREATE DEFINER=`Juan.cruz`@`%` TRIGGER `tbc_estudios_AFTER_DELETE` AFTER DELETE ON `tbc_estudios` FOR EACH ROW BEGIN
	INSERT INTO tbi_bitacora (
        ID,
        Usuario,
        Operacion,
        Tabla,
        Descripcion,
        Estatus,
        Fecha_Registro
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbb_estudios',
        CONCAT_WS('',
            'Se ha eliminado un estudio médico con los siguientes datos:\n',
            'ID: ', OLD.ID, '\n',
            'Tipo: ', OLD.Tipo, '\n',
            'Estatus: ', OLD.Estatus, '\n',
            'Total Costo: ', OLD.Total_Costo, '\n',
            'Dirigido A: ', OLD.Dirigido_A, '\n',
            'Observaciones: ', OLD.Observaciones, '\n',
            'Nivel Urgencia: ', OLD.Nivel_Urgencia, '\n',
            'Fecha Registro: ', OLD.Fecha_Registro, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END