-- Script de la creación de triggers tbc_organos

-- Elaborado por : Karen Alyn Fosado Rodriguez
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 04 de julio de 2024



-- AFTER INSERT 
CREATE DEFINER=`Alyn.Fosado`@`localhost` TRIGGER `tbc_organos_AFTER_INSERT` AFTER INSERT ON `tbc_organos` FOR EACH ROW BEGIN
DECLARE v_estatus BIT(1) DEFAULT b'1';

    -- Validamos el estatus para asignarle su valor textual 
    IF NOT NEW.Estatus THEN 
        SET v_estatus = b'0';
    END IF;

    INSERT INTO tbi_bitacora (ID, Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Create', 
        'tbc_organos', 
        CONCAT_WS(' ', 'Se ha registrado un nuevo órgano con ID:', NEW.ID, 
            ', Nombre:', NEW.Nombre, 
            ', Aparato Sistema:', NEW.Aparato_Sistema, 
            ', Descripcion:', NEW.Descripcion, 
            ', Disponibilidad:', NEW.Disponibilidad, 
            ', Tipo:', NEW.Tipo, 
            ', Estatus:', IF(NEW.Estatus, 'Activo', 'Inactivo')
        ), 
        v_estatus, 
        NOW()
    );
END

-- BEFORE UPDATE
CREATE DEFINER=`Alyn.Fosado`@`localhost` TRIGGER `tbc_organos_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_organos` FOR EACH ROW BEGIN
SET NEW.Fecha_Actualizacion = CURRENT_TIMESTAMP();
END

-- AFTER UPDATE 
CREATE DEFINER=`Alyn.Fosado`@`localhost` TRIGGER `tbc_organos_AFTER_UPDATE` AFTER UPDATE ON `tbc_organos` FOR EACH ROW BEGIN
 DECLARE v_estatus_old BIT(1) DEFAULT b'1';
    DECLARE v_estatus_new BIT(1) DEFAULT b'1';
    DECLARE v_descripcion TEXT;

    -- Validamos el estatus antiguo y nuevo para asignar sus valores textuales 
    IF NOT OLD.Estatus THEN 
        SET v_estatus_old = b'0';
    END IF;

    IF NOT NEW.Estatus THEN 
        SET v_estatus_new = b'0';
    END IF;

    -- Construimos la descripción con solo los campos modificados
    SET v_descripcion = CONCAT('Se ha actualizado un órgano con ID:', NEW.ID);

    IF OLD.Nombre != NEW.Nombre THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Nombre Antiguo:', OLD.Nombre, ', Nombre Nuevo:', NEW.Nombre);
    END IF;

    IF OLD.Aparato_Sistema != NEW.Aparato_Sistema THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Aparato Sistema Antiguo:', OLD.Aparato_Sistema, ', Aparato Sistema Nuevo:', NEW.Aparato_Sistema);
    END IF;

    IF OLD.Descripcion != NEW.Descripcion THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Descripcion Antiguo:', OLD.Descripcion, ', Descripcion Nuevo:', NEW.Descripcion);
    END IF;

    IF OLD.Disponibilidad != NEW.Disponibilidad THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Disponibilidad Antiguo:', OLD.Disponibilidad, ', Disponibilidad Nuevo:', NEW.Disponibilidad);
    END IF;

    IF OLD.Tipo != NEW.Tipo THEN
        SET v_descripcion = CONCAT(v_descripcion, ' Tipo Antiguo:', OLD.Tipo, ', Tipo Nuevo:', NEW.Tipo);
    END IF;

    IF OLD.Estatus != NEW.Estatus THEN
        SET v_descripcion = CONCAT(v_descripcion, ' Estatus Antiguo:', IF(OLD.Estatus, 'Activo', 'Inactivo'), ', Estatus Nuevo:', IF(NEW.Estatus, 'Activo', 'Inactivo'));
    END IF;

    INSERT INTO tbi_bitacora (ID, Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Update', 
        'tbc_organos', 
        v_descripcion, 
        v_estatus_new, 
        NOW()
    );
END

-- AFTER DELETE 
CREATE DEFINER=`Alyn.Fosado`@`localhost` TRIGGER `tbc_organos_AFTER_DELETE` AFTER DELETE ON `tbc_organos` FOR EACH ROW BEGIN
 DECLARE v_estatus BIT(1) DEFAULT b'1';

    -- Validamos el estatus para asignarle su valor textual 
    IF NOT OLD.Estatus THEN 
        SET v_estatus = b'0';
    END IF;

    INSERT INTO tbi_bitacora (ID, Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Delete', 
        'tbc_organos', 
        CONCAT_WS(' ', 'Se ha eliminado un órgano con ID:', OLD.ID,
            ', Nombre:', OLD.Nombre, 
            ', Aparato Sistema:', OLD.Aparato_Sistema, 
            ', Descripcion:', OLD.Descripcion, 
            ', Disponibilidad:', OLD.Disponibilidad, 
            ', Tipo:', OLD.Tipo, 
            ', Estatus:', IF(OLD.Estatus, 'Activo', 'Inactivo')
        ), 
        v_estatus, 
        NOW()
    );
END