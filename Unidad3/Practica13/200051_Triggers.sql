-- SCRIPT DE TRIGGERS

-- Elaborado por: Daniela Aguilar Torres
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- TABLA CONSUMIBLES TBC

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


-- Fecha elaboración:  26 de Julio de 2024

-- TABLA  TBD CIRUGIA CONSUMIBLES -----------------------------------------------------------------------------------------------------------

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `after_delete_cirugia_consumibles`
AFTER DELETE ON `tbd_cirugia_consumibles`
FOR EACH ROW
BEGIN
    -- Revertir la cantidad del consumible después de eliminar el registro
    UPDATE `tbc_consumibles`
    SET `Cantidad` = `Cantidad` + OLD.Cantidad_Utilizada
    WHERE `ID` = OLD.Consumible_ID;
END;


--BEFORE INSERT ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `before_insert_cirugia_consumibles` BEFORE INSERT ON `tbd_cirugia_consumibles` FOR EACH ROW BEGIN
    DECLARE v_Cantidad_Disponible INT;

    -- Obtener la cantidad disponible del consumible
    SELECT `Cantidad` INTO v_Cantidad_Disponible
    FROM `tbc_consumibles`
    WHERE `ID` = NEW.Consumible_ID;

    -- Verificar si hay suficiente stock
    IF v_Cantidad_Disponible < NEW.Cantidad_Utilizada THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock del consumible.';
    END IF;
END


-- AFTER INSERT ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `after_insert_cirugia_consumibles` AFTER INSERT ON `tbd_cirugia_consumibles` FOR EACH ROW BEGIN
    -- Actualizar el stock del consumible
    UPDATE `tbc_consumibles`
    SET `Cantidad` = `Cantidad` - NEW.Cantidad_Utilizada,
        `Fecha_Actualizacion` = NOW()
    WHERE `ID` = NEW.Consumible_ID;
END



--BEFORE UPDATE ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `before_update_cirugia_consumibles` BEFORE UPDATE ON `tbd_cirugia_consumibles` FOR EACH ROW BEGIN
    DECLARE v_Cantidad_Disponible INT;

    -- Obtener la cantidad disponible del consumible
    SELECT `Cantidad` INTO v_Cantidad_Disponible
    FROM `tbc_consumibles`
    WHERE `ID` = NEW.Consumible_ID;

    -- Verificar si hay suficiente stock
    IF v_Cantidad_Disponible + OLD.Cantidad_Utilizada < NEW.Cantidad_Utilizada THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock del consumible.';
    END IF;
END


-- AFTER UPDATE ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `after_update_cirugia_consumibles` AFTER UPDATE ON `tbd_cirugia_consumibles` FOR EACH ROW BEGIN
    -- Actualizar la cantidad del consumible con la nueva cantidad utilizada
    UPDATE `tbc_consumibles`
    SET `Cantidad` = `Cantidad` - NEW.Cantidad_Utilizada + OLD.Cantidad_Utilizada
    WHERE `ID` = NEW.Consumible_ID;
END

-- AFTER DELETE ----------------------------------------------------------------------------------------------------------- 

CREATE DEFINER=`daniela.aguilar`@`%` TRIGGER `after_delete_cirugia_consumibles` AFTER DELETE ON `tbd_cirugia_consumibles` FOR EACH ROW BEGIN
    -- Revertir la cantidad del consumible después de eliminar el registro
    UPDATE `tbc_consumibles`
    SET `Cantidad` = `Cantidad` + OLD.Cantidad_Utilizada
    WHERE `ID` = OLD.Consumible_ID;
END
