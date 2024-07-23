-- Script de Triggers de la tabla tbc_medicamentos y tbd_dispensaciones 


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 21 de julio de 2024 



--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Insert tbc_medicamentos -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
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
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Before Update tbc_medicamentos -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbc_medicamentos_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_medicamentos` FOR EACH ROW BEGIN
	set new.Fecha_Actualizacion = current_time();

END

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Update  tbc_medicamentos -- -- -- -- -- -- -- -- -- -- -- -- -- --
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



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Delete  tbc_medicamentostbc_medicamentos-- -- -- -- -- -- -- -- -- -- -- -- -- --
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





-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Insert  - tbd_dispensaciones -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbd_dispensaciones_AFTER_INSERT` AFTER INSERT ON `tbd_dispensaciones` FOR EACH ROW BEGIN
    DECLARE v_estatus_new VARCHAR(50) DEFAULT 'Activo';
    DECLARE v_tipo_new VARCHAR(50) DEFAULT 'Desconocido';
    DECLARE v_solicitud_id_new VARCHAR(50);
    DECLARE v_receta_medica_id_new VARCHAR(50);
    DECLARE v_personal_medico_nombre_new VARCHAR(80);

    IF NEW.Estatus = 'Abastecida' THEN
        SET v_estatus_new = 'Abastecida';
    ELSEIF NEW.Estatus = 'Parcialmente abastecida' THEN
        SET v_estatus_new = 'Parcialmente abastecida';
    END IF;

    -- Convertir NULL a 'no aplica'
    IF NEW.Solicitud_id IS NULL THEN
        SET v_solicitud_id_new = 'no aplica';
    ELSE
        SET v_solicitud_id_new = CAST(NEW.Solicitud_id AS CHAR);
    END IF;

    IF NEW.RecetaMedica_id IS NULL THEN
        SET v_receta_medica_id_new = 'no aplica';
    ELSE
        SET v_receta_medica_id_new = CAST(NEW.RecetaMedica_id AS CHAR);
    END IF;

    -- Obtener el tipo para NEW
    IF NEW.Tipo = 'Pública' THEN
        SET v_tipo_new = 'Pública';
    ELSEIF NEW.Tipo = 'Privada' THEN
        SET v_tipo_new = 'Privada';
    ELSEIF NEW.Tipo = 'Mixta' THEN
        SET v_tipo_new = 'Mixta';
    END IF;

    -- Obtener el nombre del personal médico para NEW
    SELECT p.Nombre
    INTO v_personal_medico_nombre_new
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON p.ID = pm.Persona_ID
    WHERE pm.Persona_ID = NEW.PersonalMedico_id;

    -- Si no se encuentra el nombre, asignar un valor por defecto
    IF v_personal_medico_nombre_new IS NULL THEN
        SET v_personal_medico_nombre_new = 'Desconocido';
    END IF;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora (
      
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbd_dispensaciones',
        CONCAT_WS(' ', 
            'Se ha insertado una nueva dispensación con los siguientes datos:',
            '\nReceta Medica: ', v_receta_medica_id_new, 
            '\nPersonal Medico: ', v_personal_medico_nombre_new,
            '\nSolicitud: ', v_solicitud_id_new, 
            '\nEstatus: ', v_estatus_new, 
            '\nTipo: ', v_tipo_new, 
            '\nMedicamentos entregados: ', NEW.TotalMedicamentosEntregados, 
            '\nCosto: ', NEW.Total_costo
        ),
        DEFAULT, 
        DEFAULT
    );
END

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Before Update - tbd_dispensaciones -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`root`@`localhost` TRIGGER `tbd_dispensaciones_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_dispensaciones` FOR EACH ROW BEGIN
	set new.Fecha_Actualizacion = current_time();
END


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Update - tbd_dispensaciones -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbd_dispensaciones_AFTER_UPDATE` AFTER UPDATE ON `tbd_dispensaciones` FOR EACH ROW BEGIN
    DECLARE v_estatus_old VARCHAR(50) DEFAULT 'Activo';
    DECLARE v_estatus_new VARCHAR(50) DEFAULT 'Activo';
    DECLARE v_tipo_old VARCHAR(50) DEFAULT 'Desconocido';
    DECLARE v_tipo_new VARCHAR(50) DEFAULT 'Desconocido';
    DECLARE v_solicitud_id_old VARCHAR(50);
    DECLARE v_solicitud_id_new VARCHAR(50);
    DECLARE v_receta_medica_id_old VARCHAR(50);
    DECLARE v_receta_medica_id_new VARCHAR(50);
    DECLARE v_personal_medico_nombre_old VARCHAR(80);
    DECLARE v_personal_medico_nombre_new VARCHAR(80);

    IF OLD.Estatus = 'Abastecida' THEN
        SET v_estatus_old = 'Abastecida';
    ELSEIF OLD.Estatus = 'Parcialmente abastecida' THEN
        SET v_estatus_old = 'Parcialmente abastecida';
    END IF;

    IF NEW.Estatus = 'Abastecida' THEN
        SET v_estatus_new = 'Abastecida';
    ELSEIF NEW.Estatus = 'Parcialmente abastecida' THEN
        SET v_estatus_new = 'Parcialmente abastecida';
    END IF;

    -- Obtener los nombres del personal médico para OLD y NEW
    SELECT p.Nombre
    INTO v_personal_medico_nombre_old
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON p.ID = pm.Persona_ID
    WHERE pm.Persona_ID = OLD.PersonalMedico_id;

    SELECT p.Nombre
    INTO v_personal_medico_nombre_new
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON p.ID = pm.Persona_ID
    WHERE pm.Persona_ID = NEW.PersonalMedico_id;

    -- Si no se encuentra el nombre, asignar un valor por defecto
    IF v_personal_medico_nombre_old IS NULL THEN
        SET v_personal_medico_nombre_old = 'Desconocido';
    END IF;

    IF v_personal_medico_nombre_new IS NULL THEN
        SET v_personal_medico_nombre_new = 'Desconocido';
    END IF;

    -- Convertir NULL a 'no aplica'
    IF OLD.Solicitud_id IS NULL THEN
        SET v_solicitud_id_old = 'no aplica';
    ELSE
        SET v_solicitud_id_old = CAST(OLD.Solicitud_id AS CHAR);
    END IF;

    IF NEW.Solicitud_id IS NULL THEN
        SET v_solicitud_id_new = 'no aplica';
    ELSE
        SET v_solicitud_id_new = CAST(NEW.Solicitud_id AS CHAR);
    END IF;

    IF OLD.RecetaMedica_id IS NULL THEN
        SET v_receta_medica_id_old = 'no aplica';
    ELSE
        SET v_receta_medica_id_old = CAST(OLD.RecetaMedica_id AS CHAR);
    END IF;

    IF NEW.RecetaMedica_id IS NULL THEN
        SET v_receta_medica_id_new = 'no aplica';
    ELSE
        SET v_receta_medica_id_new = CAST(NEW.RecetaMedica_id AS CHAR);
    END IF;

    -- Obtener el tipo para OLD y NEW
    IF OLD.Tipo = 'Pública' THEN
        SET v_tipo_old = 'Pública';
    ELSEIF OLD.Tipo = 'Privada' THEN
        SET v_tipo_old = 'Privada';
    ELSEIF OLD.Tipo = 'Mixta' THEN
        SET v_tipo_old = 'Mixta';
    END IF;

    IF NEW.Tipo = 'Pública' THEN
        SET v_tipo_new = 'Pública';
    ELSEIF NEW.Tipo = 'Privada' THEN
        SET v_tipo_new = 'Privada';
    ELSEIF NEW.Tipo = 'Mixta' THEN
        SET v_tipo_new = 'Mixta';
    END IF;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora (
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Update',
        'tbd_dispensaciones',
        CONCAT_WS(' ', 
            'Se ha actualizado una dispensación con los siguientes datos:',
            '\nReceta Medica: ', v_receta_medica_id_old, ' - ', v_receta_medica_id_new, 
            '\nPersonal Medico: ', v_personal_medico_nombre_old, ' - ', v_personal_medico_nombre_new,
            '\nSolicitud: ', v_solicitud_id_old, ' - ', v_solicitud_id_new, 
            '\nEstatus: ', v_estatus_old, ' - ', v_estatus_new, 
            '\nTipo: ', v_tipo_old, ' - ', v_tipo_new, 
            '\nMedicamentos entregados: ', OLD.TotalMedicamentosEntregados, ' - ', NEW.TotalMedicamentosEntregados,
            '\nCosto: ', OLD.Total_costo, ' - ', NEW.Total_costo
        ),
        DEFAULT, 
        DEFAULT
    );
END

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- After Delete - tbd_dispensaciones -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE DEFINER=`Cristian.Ojeda`@`%` TRIGGER `tbd_dispensaciones_AFTER_DELETE` AFTER DELETE ON `tbd_dispensaciones` FOR EACH ROW BEGIN
    DECLARE v_estatus_old VARCHAR(50) DEFAULT 'Activo';
    DECLARE v_solicitud_id_old VARCHAR(50);
    DECLARE v_receta_medica_id_old VARCHAR(50);
    DECLARE v_personal_medico_nombre_old VARCHAR(80);

    IF OLD.Estatus = 'Abastecida' THEN
        SET v_estatus_old = 'Abastecida';
    ELSEIF OLD.Estatus = 'Parcialmente abastecida' THEN
        SET v_estatus_old = 'Parcialmente abastecida';
    END IF;

    -- Obtener el nombre del personal médico para OLD
    SELECT p.Nombre
    INTO v_personal_medico_nombre_old
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON p.ID = pm.Persona_ID
    WHERE pm.Persona_ID = OLD.PersonalMedico_id;

    -- Si no se encuentra el nombre, asignar un valor por defecto
    IF v_personal_medico_nombre_old IS NULL THEN
        SET v_personal_medico_nombre_old = 'Desconocido';
    END IF;

    -- Convertir NULL a 'no aplica'
    IF OLD.Solicitud_id IS NULL THEN
        SET v_solicitud_id_old = 'no aplica';
    ELSE
        SET v_solicitud_id_old = CAST(OLD.Solicitud_id AS CHAR);
    END IF;

    IF OLD.RecetaMedica_id IS NULL THEN
        SET v_receta_medica_id_old = 'no aplica';
    ELSE
        SET v_receta_medica_id_old = CAST(OLD.RecetaMedica_id AS CHAR);
    END IF;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora (
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbd_dispensaciones',
        CONCAT_WS(' ', 
            'Se ha eliminado una dispensación con los siguientes datos:',
            '\nReceta Medica: ', v_receta_medica_id_old, 
            '\nPersonal Medico: ', v_personal_medico_nombre_old,
            '\nSolicitud: ', v_solicitud_id_old, 
            '\nEstatus: ', v_estatus_old
        ),
        DEFAULT, 
        DEFAULT
    );
END