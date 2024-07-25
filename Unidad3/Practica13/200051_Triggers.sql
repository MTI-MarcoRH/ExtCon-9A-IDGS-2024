-- SCRIPT DE TRIGGERS

-- Elaborado por: Daniela Aguilar Torres
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- TABLA CONSUMIBLES

-- AFTER_INSERT ---------------------------------------------------------------------------------------------------------------

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `tbc_consumibles_AFTER_INSERT` AFTER INSERT ON `tbc_consumibles` FOR EACH ROW BEGIN
    DECLARE v_estatus VARCHAR(20) DEFAULT 'Activo';

    IF NEW.Estatus = 'Inactivo' THEN
        SET v_estatus = 'Inactivo';
    ELSEIF NEW.Estatus = 'En Revisión' THEN
        SET v_estatus = 'En Revisión';
    END IF;

    INSERT INTO tbi_bitacora 
    (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (
        USER(),
        'Create',
        'tbc_consumibles',
        CONCAT_WS(' ', 'Se ha insertado un nuevo consumible con los siguientes datos:',
            'NOMBRE =', NEW.Nombre,
            'DESCRIPCION =', NEW.Descripcion,
            'TIPO =', NEW.Tipo,
            'DEPARTAMENTO =', NEW.Departamento_ID,
            'CANTIDAD =', NEW.Cantidad,
            'FECHA DE REGISTRO =', NEW.Fecha_Registro,
            'ESTATUS =', v_estatus,
            'ESPACIO MEDICO =', NEW.Espacio_Medico),
        b'1',
        NOW()
    );

END

--BEFORE UPDATE ----------------------------------------------------------------------------------------------------------- 
  
CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `tbc_consumibles_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_consumibles` FOR EACH ROW BEGIN
    SET NEW.Fecha_Actualizacion = CURRENT_TIMESTAMP();
END

-- AFTER UPDATE ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `tbc_consumibles_AFTER_UPDATE` AFTER UPDATE ON `tbc_consumibles` FOR EACH ROW BEGIN
    DECLARE v_estatus_old VARCHAR(20) DEFAULT 'Activo';
    DECLARE v_estatus_new VARCHAR(20) DEFAULT 'Activo';

    IF OLD.Estatus = 'Inactivo' THEN
        SET v_estatus_old = 'Inactivo';
    ELSEIF OLD.Estatus = 'En Revisión' THEN
        SET v_estatus_old = 'En Revisión';
    END IF;

    IF NEW.Estatus = 'Inactivo' THEN
        SET v_estatus_new = 'Inactivo';
    ELSEIF NEW.Estatus = 'En Revisión' THEN
        SET v_estatus_new = 'En Revisión';
    END IF;

    INSERT INTO tbi_bitacora 
    (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (
        USER(),
        'Update',
        'tbc_consumibles',
        CONCAT_WS(' ', 'Se ha modificado un consumible con los siguientes datos:',
            'NOMBRE =', OLD.Nombre, ' - ', NEW.Nombre,
            'DESCRIPCION =', OLD.Descripcion, ' - ', NEW.Descripcion,
            'TIPO =', OLD.Tipo, ' - ', NEW.Tipo,
            'DEPARTAMENTO =', OLD.Departamento_ID, ' - ', NEW.Departamento_ID,
            'CANTIDAD =', OLD.Cantidad, ' - ', NEW.Cantidad,
            'FECHA DE REGISTRO =', OLD.Fecha_Registro, ' - ', NEW.Fecha_Registro,
            'ESTATUS =', v_estatus_old, ' - ', v_estatus_new,
            'ESPACIO MEDICO =', OLD.Espacio_Medico, ' - ', NEW.Espacio_Medico),
        b'1',
        NOW()
    );

END

-- AFTER UPDATE ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `tbc_consumibles_BEFORE_DELETE` BEFORE DELETE ON `tbc_consumibles` FOR EACH ROW BEGIN
    DECLARE v_estatus VARCHAR(20) DEFAULT 'Activo';

    IF OLD.Estatus = 'Inactivo' THEN
        SET v_estatus = 'Inactivo';
    ELSEIF OLD.Estatus = 'En Revisión' THEN
        SET v_estatus = 'En Revisión';
    END IF;

    INSERT INTO tbi_bitacora 
    (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (
        USER(),
        'Delete',
        'tbc_consumibles',
        CONCAT_WS(' ', 'Se ha eliminado un consumible con los siguientes datos:',
            'NOMBRE =', OLD.Nombre,
            'DESCRIPCION =', OLD.Descripcion,
            'TIPO =', OLD.Tipo,
            'DEPARTAMENTO =', OLD.Departamento_ID,
            'CANTIDAD =', OLD.Cantidad,
            'FECHA DE REGISTRO =', OLD.Fecha_Registro,
            'ESTATUS =', v_estatus,
            'ESPACIO MEDICO =', OLD.Espacio_Medico),
        b'1',
        NOW()
    );

END


