-- Script de la creación de triggers tbc_organos

-- Elaborado por : Karen Alyn Fosado Rodriguez
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 22 de julio de 2024



-- AFTER INSERT 
CREATE DEFINER=`Alyn.Fosado`@`localhost` TRIGGER `tbc_organos_AFTER_INSERT` AFTER INSERT ON `tbc_organos` FOR EACH ROW BEGIN
    DECLARE v_estatus BIT(1) DEFAULT b'1';

    -- Validamos el estatus para asignarle su valor textual 
    IF NOT NEW.Estatus THEN 
        SET v_estatus = b'0';
    END IF;

    INSERT INTO tbi_bitacora (
        ID, 
        Usuario, 
        Operacion, 
        Tabla, 
        Descripcion, 
        Estatus, 
        Fecha_Registro
    ) 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Create', 
        'tbc_organos', 
        CONCAT_WS(' ', 'Se ha registrado un nuevo órgano con ID:', NEW.ID, 
            ', Nombre:', NEW.Nombre, 
            ', Aparato Sistema:', NEW.Aparato_Sistema, 
            ', Detalles Adicionales:', NEW.Detalles_Adicionales, 
            ', Disponibilidad:', NEW.Disponibilidad, 
            ', Tipo:', NEW.Tipo, 
            ', Grupo Sanguíneo:', NEW.Grupo_Sanguineo,
            ', Estado de Salud:', NEW.Estado_Salud, 
            ', Enfermedades Transmisibles:', IF(NEW.Enfermedades_Transmisibles, 'Sí', 'No'),
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

    -- Iniciamos la descripción con el nombre y ID del órgano
    SET v_descripcion = CONCAT('Se ha actualizado el órgano ', OLD.Nombre, ' con el ID: ', OLD.ID);

    -- Añadimos la comparación de cada campo para incluir en la descripción si fue modificado
    IF OLD.Nombre != NEW.Nombre THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Nombre Antiguo:', OLD.Nombre, ', Nombre Nuevo:', NEW.Nombre);
    END IF;

    IF OLD.Aparato_Sistema != NEW.Aparato_Sistema THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Aparato Sistema Antiguo:', OLD.Aparato_Sistema, ', Aparato Sistema Nuevo:', NEW.Aparato_Sistema);
    END IF;

    IF OLD.Detalles_Adicionales != NEW.Detalles_Adicionales THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Detalles Adicionales Antiguos:', OLD.Detalles_Adicionales, ', Detalles Adicionales Nuevos:', NEW.Detalles_Adicionales);
    END IF;

    IF OLD.Disponibilidad != NEW.Disponibilidad THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Disponibilidad Antigua:', OLD.Disponibilidad, ', Disponibilidad Nueva:', NEW.Disponibilidad);
    END IF;

    IF OLD.Tipo != NEW.Tipo THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Tipo Antiguo:', OLD.Tipo, ', Tipo Nuevo:', NEW.Tipo);
    END IF;

    IF OLD.Fecha_Extraccion != NEW.Fecha_Extraccion THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Fecha de Extracción Antigua:', OLD.Fecha_Extraccion, ', Fecha de Extracción Nueva:', NEW.Fecha_Extraccion);
    END IF;

    IF OLD.Edad_Donante != NEW.Edad_Donante THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Edad del Donante Antigua:', OLD.Edad_Donante, ', Edad del Donante Nueva:', NEW.Edad_Donante);
    END IF;

    IF OLD.Grupo_Sanguineo != NEW.Grupo_Sanguineo THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Grupo Sanguíneo Antiguo:', OLD.Grupo_Sanguineo, ', Grupo Sanguíneo Nuevo:', NEW.Grupo_Sanguineo);
    END IF;

    IF OLD.Estado_Salud != NEW.Estado_Salud THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Estado de Salud Antiguo:', OLD.Estado_Salud, ', Estado de Salud Nuevo:', NEW.Estado_Salud);
    END IF;

    IF OLD.Enfermedades_Transmisibles != NEW.Enfermedades_Transmisibles THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Enfermedades Transmisibles Antigua:', IF(OLD.Enfermedades_Transmisibles, 'Sí', 'No'), ', Enfermedades Transmisibles Nueva:', IF(NEW.Enfermedades_Transmisibles, 'Sí', 'No'));
    END IF;

    IF OLD.Estatus != NEW.Estatus THEN
        SET v_descripcion = CONCAT(v_descripcion, ', Estatus Antiguo:', IF(OLD.Estatus, 'Activo', 'Inactivo'), ', Estatus Nuevo:', IF(NEW.Estatus, 'Activo', 'Inactivo'));
    END IF;

    -- Insertamos la bitácora con la descripción construida
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

    -- Inserta en la bitácora la información sobre el órgano eliminado
    INSERT INTO tbi_bitacora (
        ID, 
        Usuario, 
        Operacion, 
        Tabla, 
        Descripcion, 
        Estatus, 
        Fecha_Registro
    ) 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Delete', 
        'tbc_organos', 
        CONCAT_WS(' ', 'Se ha eliminado el órgano', OLD.Nombre, 'con ID:', OLD.ID,
            ', Aparato Sistema:', OLD.Aparato_Sistema, 
            ', Detalles Adicionales:', OLD.Detalles_Adicionales, 
            ', Disponibilidad:', OLD.Disponibilidad, 
            ', Tipo:', OLD.Tipo, 
            ', Grupo Sanguíneo:', OLD.Grupo_Sanguineo,
            ', Estado de Salud:', OLD.Estado_Salud, 
            ', Enfermedades Transmisibles:', IF(OLD.Enfermedades_Transmisibles, 'Sí', 'No'),
            ', Estatus:', IF(OLD.Estatus, 'Activo', 'Inactivo')
        ), 
        v_estatus, 
        NOW()
    );
END