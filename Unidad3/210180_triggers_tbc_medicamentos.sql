-- Script de Triggers de la tabla tbc_medicamentos


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 21 de julio de 2024 



--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Insert -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbc_medicamentos_AFTER_INSERT` AFTER INSERT ON `tbc_medicamentos` FOR EACH ROW BEGIN
    DECLARE v_estatus VARCHAR(20) DEFAULT 'Activo';

    -- Validamos el estatus para asignarle su valor textual
    IF NEW.Estatus = 0 THEN
        SET v_estatus = 'Inactivo';
    END IF;

    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT, -- Asumiendo que el ID es autoincrementable y no se especifica
        CURRENT_USER(),
        'Create',
        'tbc_medicamentos',
        CONCAT_WS(' ', 
            'Se ha insertado un nuevo medicamento con los siguientes datos:',
            '\n Nombre Comercial:', NEW.Nombre_comercial,
            '\n Nombre Genérico:', NEW.Nombre_generico,
            '\n Vía de Administración:', NEW.Via_administracion,
            '\n Presentación:', NEW.Presentacion,
            '\n Tipo:', NEW.Tipo,
            '\n Cantidad:', NEW.Cantidad,
            '\n Volumen:', NEW.Volumen,
            '\n Estatus:', v_estatus
        ),
        DEFAULT, -- Fecha_registro
        DEFAULT  -- Fecha_actualizacion
    );
END
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Before Update -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbc_medicamentos_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_medicamentos` FOR EACH ROW BEGIN
	set new.Fecha_Actualizacion = current_time();

END

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Update -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbc_medicamentos_AFTER_UPDATE` AFTER UPDATE ON `tbc_medicamentos` FOR EACH ROW BEGIN
    DECLARE v_estatus_old VARCHAR(20) DEFAULT 'Activo';
    DECLARE v_estatus_new VARCHAR(20) DEFAULT 'Activo';

    -- Validamos el estatus para asignarles sus valores textuales
    IF OLD.Estatus = 0 THEN
        SET v_estatus_old = 'Inactivo';
    END IF;

    IF NEW.Estatus = 0 THEN
        SET v_estatus_new = 'Inactivo';
    END IF;

    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT, 
        CURRENT_USER(),
        'Update',
        'tbc_medicamentos',
        CONCAT_WS(' ', 
            'Se ha actualizado el medicamento con los siguientes datos:',
            '\n Nombre Comercial: ', OLD.Nombre_comercial, ' - ', NEW.Nombre_comercial,
            '\n Nombre Genérico: ', OLD.Nombre_generico, ' - ', NEW.Nombre_generico,
            '\n Vía de Administración: ', OLD.Via_administracion, ' - ', NEW.Via_administracion,
            '\n Presentación: ', OLD.Presentacion, ' - ', NEW.Presentacion,
            '\n Tipo: ', OLD.Tipo, ' - ', NEW.Tipo,
            '\n Cantidad: ', OLD.Cantidad, ' - ', NEW.Cantidad,
            '\n Volumen: ', OLD.Volumen, ' - ', NEW.Volumen,
            '\n Estatus: ', v_estatus_old, ' - ', v_estatus_new
        ),
        DEFAULT, -- Fecha_registro
        DEFAULT  -- Fecha_actualizacion
    );
END



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Delete -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbc_medicamentos_AFTER_DELETE` AFTER DELETE ON `tbc_medicamentos` FOR EACH ROW BEGIN
    DECLARE v_estatus_old VARCHAR(20);

    -- Validamos el estatus para asignarle su valor textual
    IF OLD.Estatus = 1 THEN
        SET v_estatus_old = 'Activo';
    ELSE
        SET v_estatus_old = 'Inactivo';
    END IF;

    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT, -- Asumiendo que el ID es autoincrementable y no se especifica
        CURRENT_USER(),
        'Delete',
        'tbc_medicamentos',
        CONCAT_WS(' ', 
            'Se ha eliminado el medicamento que tenía los siguientes datos:',
            '\n Nombre Comercial:', OLD.Nombre_comercial,
            '\n Nombre Genérico:', OLD.Nombre_generico,
            '\n Estatus:', v_estatus_old
        ),
        DEFAULT, -- Fecha_registro
        DEFAULT  -- Fecha_actualizacion
    );
END