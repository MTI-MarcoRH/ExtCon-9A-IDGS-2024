
-- ALEXIS GOMEZ
-- EXTRACCION DE BASE DE DATOS
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

-----------------------------------------------------------------------------------------------------------

------------- DEPARTAMENTOS SERVICIOS  --------------------------------------------------------------


-- AFTER INSERT DEPARTAMENTOS SERVICIOS

CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbd_departamentos_servicios_AFTER_INSERT` AFTER INSERT ON `tbd_departamentos_servicios` FOR EACH ROW BEGIN
DECLARE v_departamento_nombre VARCHAR(100);
    DECLARE v_servicio_nombre VARCHAR(100);
    
    -- Obtener el nombre del departamento
    SELECT nombre INTO v_departamento_nombre
    FROM tbc_departamentos
    WHERE id = NEW.Departamento_ID;
    
    -- Obtener el nombre del servicio médico
    SELECT nombre INTO v_servicio_nombre
    FROM tbc_servicios_medicos
    WHERE id = NEW.Servicio_ID;
    
    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbd_departamentos_servicios',
        CONCAT_WS(' ',
            'Se ha registrado un nuevo departamento-servicio con los siguientes datos:', '\n',
            'Departamento:', v_departamento_nombre, '\n',
            'Servicio Médico:', v_servicio_nombre, '\n',
            'Requisitos:', NEW.Requisitos, '\n',
            'Restricciones:', NEW.Restricciones, '\n',
            'Estatus:', 'Activo', '\n',  -- Modificado a "activo"
            'Fecha_Registro:', NEW.Fecha_Registro, '\n',
            'Fecha_Actualizacion:', NEW.Fecha_Actualizacion, '\n'
        ),
        DEFAULT,
        DEFAULT
    );



-- BEFORE UPDATE DEPARTAMENTOS SERVICIOS
CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbc_servicios_medicos_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_servicios_medicos` FOR EACH ROW BEGIN
set new.fecha_actualizacion = current_timestamp();

END



-- AFTER UPDATE DEPARTAMENTOS SERVICIOS
CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbd_departamentos_servicios_AFTER_UPDATE` AFTER UPDATE ON `tbd_departamentos_servicios` FOR EACH ROW BEGIN
  DECLARE v_old_departamento_nombre VARCHAR(100);
    DECLARE v_old_servicio_nombre VARCHAR(100);
    DECLARE v_new_departamento_nombre VARCHAR(100);
    DECLARE v_new_servicio_nombre VARCHAR(100);
 
    SELECT nombre INTO v_old_departamento_nombre
    FROM tbc_departamentos
    WHERE id = OLD.Departamento_ID;
    
    SELECT nombre INTO v_old_servicio_nombre
    FROM tbc_servicios_medicos
    WHERE id = OLD.Servicio_ID;

    SELECT nombre INTO v_new_departamento_nombre
    FROM tbc_departamentos
    WHERE id = NEW.Departamento_ID;
 
    SELECT nombre INTO v_new_servicio_nombre
    FROM tbc_servicios_medicos
    WHERE id = NEW.Servicio_ID;
    
    INSERT INTO tbi_bitacora 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Update', 
        'tbd_departamentos_servicios', 
        CONCAT_WS(' ', 
            'Se ha modificado un departamento-servicio con los siguientes datos:', '\n',
            'Departamento (antes):', v_old_departamento_nombre, ' -> ', v_new_departamento_nombre, '\n',
            'Servicio Médico (antes):', v_old_servicio_nombre, ' -> ', v_new_servicio_nombre, '\n',
            'Requisitos (antes):', OLD.Requisitos, ' -> ', NEW.Requisitos, '\n',
            'Restricciones (antes):', OLD.Restricciones, ' -> ', NEW.Restricciones, '\n',
            'Estatus (antes):','activo', ' -> ', 'activo', '\n',  -- Modificado a "activo"
            'Fecha_Registro (antes):', OLD.Fecha_Registro, ' -> ', NEW.Fecha_Registro, '\n',
            'Fecha_Actualizacion:', OLD.Fecha_Actualizacion, ' -> ', NEW.Fecha_Actualizacion, '\n'
        ), 
        DEFAULT, 
        DEFAULT
    );
END



-- AFTER DELETE DEPARTAMENTOS SERVICIOS
CREATE DEFINER=`alexis.gomez`@`%` TRIGGER `tbd_departamentos_servicios_AFTER_DELETE` AFTER DELETE ON `tbd_departamentos_servicios` FOR EACH ROW BEGIN
 DECLARE v_departamento_nombre VARCHAR(100);
    DECLARE v_servicio_nombre VARCHAR(100);
    
    -- Obtener el nombre del departamento eliminado
    SELECT nombre INTO v_departamento_nombre
    FROM tbc_departamentos
    WHERE id = OLD.Departamento_ID;
    
    -- Obtener el nombre del servicio médico eliminado
    SELECT nombre INTO v_servicio_nombre
    FROM tbc_servicios_medicos
    WHERE id = OLD.Servicio_ID;
    
    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbd_departamentos_servicios',
        CONCAT_WS(' ',
            'Se ha eliminado un departamento-servicio con los siguientes datos:', '\n',
            'Departamento:', v_departamento_nombre, '\n',
            'Servicio Médico:', v_servicio_nombre, '\n',
            'Requisitos:', OLD.Requisitos, '\n',
            'Restricciones:', OLD.Restricciones, '\n',
            'Estatus:', 'Inactivo', '\n',
            'Fecha_Registro:', OLD.Fecha_Registro, '\n',
            'Fecha_Actualizacion:', OLD.Fecha_Actualizacion, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END










