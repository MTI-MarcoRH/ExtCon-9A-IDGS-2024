
-- ALEXIS GOMEZ
-- Grado y Grupo: 9 A
-- Ingenieria de Desarrollo  y Gestion de Software
 
-- AFTER INSERT SERVICIOS MEDICOS

CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbc_servicios_medicos_AFTER_INSERT` AFTER INSERT ON `tbc_servicios_medicos` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbc_servicios_medicos',
        CONCAT_WS(' ',
            'Se ha registrado un nuevo servicio médico con los siguientes datos:','\n',
            'NOMBRE:', NEW.nombre,'\n',
            'DESCRIPCION:', NEW.descripcion,'\n',
            'OBSERVACIONES:', NEW.observaciones,'\n',
            'FECHA REGISTRO:', NEW.fecha_registro,'\n',
            'FECHA ACTUALIZACION:', NEW.fecha_actualizacion,'\n'
        ),
        DEFAULT,
        DEFAULT
    );
END



-- BEFORE UPDATE SERVICIOS MEDICOS
CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbc_servicios_medicos_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_servicios_medicos` FOR EACH ROW BEGIN
set new.fecha_actualizacion = current_timestamp();

END


-- AFTER UPDATE SERVICIOS MEDICOS
CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbc_servicios_medicos_AFTER_UPDATE` AFTER UPDATE ON `tbc_servicios_medicos` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Update', 
        'tbc_servicios_medicos', 
        CONCAT_WS(' ', 
            'Se ha modificado un servicio médico con los siguientes datos:', '\n',
            'NOMBRE:', OLD.nombre, '-', NEW.nombre, '\n',
            'DESCRIPCION:', OLD.descripcion, '-', NEW.descripcion, '\n',
            'OBSERVACIONES:', OLD.observaciones, '-', NEW.observaciones, '\n',
            'FECHA REGISTRO:', OLD.fecha_registro, '-', NEW.fecha_registro, '\n',
            'FECHA ACTUALIZACION:', OLD.fecha_actualizacion, '-', NEW.fecha_actualizacion, '\n'
        ), 
        DEFAULT, 
        DEFAULT
    );
END

-- AFTER DELETE SERVICIOS MEDICOS
CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbc_servicios_medicos_AFTER_DELETE` AFTER DELETE ON `tbc_servicios_medicos` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbc_servicios_medicos',
        CONCAT_WS(' ',
            'Se ha eliminado un servicio médico con los siguientes datos:','\n',
            'NOMBRE:', OLD.nombre,'\n',
            'DESCRIPCION:', OLD.descripcion,'\n',
            'OBSERVACIONES:', OLD.observaciones,'\n',
            'FECHA REGISTRO:', OLD.fecha_registro,'\n',
            'FECHA ACTUALIZACION:', OLD.fecha_actualizacion,'\n'
        ),
        DEFAULT,
        DEFAULT
    );
END