-- SCRIPT DE TRIGGERS DE TABLAS ASIGNADAS

-- Elaborado por: Armando Carrasco Vargas
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla Resultados Estudios
-- 1) AFTER INSERT USUARIOS
DELIMITER &&

CREATE DEFINER=`armando.carrasco`@`%` TRIGGER `tbd_resultados_estudios_AFTER_INSERT` AFTER INSERT ON `tbd_resultados_estudios` FOR EACH ROW BEGIN
    DECLARE paciente_nombre_completo VARCHAR(255);
    DECLARE personal_medico_nombre_completo VARCHAR(255);
    DECLARE estudio_tipo VARCHAR(255);

    -- Obtener el nombre completo del paciente
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO paciente_nombre_completo
    FROM tbb_personas p
    JOIN tbb_pacientes pac ON pac.Persona_ID = p.ID
    WHERE pac.Persona_ID = NEW.Paciente_ID;

    -- Obtener el nombre completo del personal medico
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO personal_medico_nombre_completo
    FROM tbb_personal_medico pm
    JOIN tbb_personas p ON pm.Persona_ID = p.ID
    WHERE pm.Persona_ID = NEW.Personal_Medico_ID;

    -- Obtener el tipo del estudio
    SELECT Tipo
    INTO estudio_tipo
    FROM tbc_estudios
    WHERE ID = NEW.Estudio_ID;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbd_resultados_estudios',
        CONCAT_WS(' ',
            'Se ha registrado un nuevo resultado de estudio con los siguientes datos:', '\n',
            'Nombre del Paciente:', paciente_nombre_completo, '\n',
            'Nombre del Personal Médico:', personal_medico_nombre_completo, '\n',
            'Tipo de Estudio:', estudio_tipo, '\n',
            'Folio:', NEW.Folio, '\n',
            'Resultados:', NEW.Resultados, '\n',
            'Observaciones:', NEW.Observaciones, '\n',
            'Estatus:', NEW.Estatus, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END
&&
DELIMITER ;

-- 2) BEFORE UPDATE
DELIMITER &&

CREATE DEFINER=`armando.carrasco`@`%` TRIGGER `tbd_resultados_estudios_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_resultados_estudios` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp();
END
&&
DELIMITER ;


-- 3) AFTER UPDATE
DELIMITER &&

CREATE DEFINER=`armando.carrasco`@`%` TRIGGER `tbd_resultados_estudios_AFTER_UPDATE` AFTER UPDATE ON `tbd_resultados_estudios` FOR EACH ROW BEGIN
    DECLARE paciente_nombre_completo_old VARCHAR(255);
    DECLARE paciente_nombre_completo_new VARCHAR(255);
    DECLARE personal_medico_nombre_completo_old VARCHAR(255);
    DECLARE personal_medico_nombre_completo_new VARCHAR(255);
    DECLARE estudio_tipo_old VARCHAR(255);
    DECLARE estudio_tipo_new VARCHAR(255);

    -- Obtener el nombre completo del paciente antes de la actualización
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO paciente_nombre_completo_old
    FROM tbb_personas p
    JOIN tbb_pacientes pac ON pac.Persona_ID = p.ID
    WHERE pac.Persona_ID = OLD.Paciente_ID;

    -- Obtener el nombre completo del paciente después de la actualización
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO paciente_nombre_completo_new
    FROM tbb_personas p
    JOIN tbb_pacientes pac ON pac.Persona_ID = p.ID
    WHERE pac.Persona_ID = NEW.Paciente_ID;

    -- Obtener el nombre completo del personal médico antes de la actualización
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO personal_medico_nombre_completo_old
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON pm.Persona_ID = p.ID
    WHERE pm.Persona_ID = OLD.Personal_Medico_ID;

    -- Obtener el nombre completo del personal médico después de la actualización
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO personal_medico_nombre_completo_new
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON pm.Persona_ID = p.ID
    WHERE pm.Persona_ID = NEW.Personal_Medico_ID;

    -- Obtener el tipo del estudio antes y después de la actualización
    SELECT Tipo
    INTO estudio_tipo_old
    FROM tbc_estudios
    WHERE ID = OLD.Estudio_ID;

    SELECT Tipo
    INTO estudio_tipo_new
    FROM tbc_estudios
    WHERE ID = NEW.Estudio_ID;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora 
    VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Update', 
        'tbd_resultados_estudios', 
        CONCAT_WS(' ', 
            'Se ha modificado un resultado de estudio con ID:', OLD.ID, '\n',
            'Nombre del Paciente:', paciente_nombre_completo_old, '->', paciente_nombre_completo_new, '\n',
            'Nombre del Personal Médico:', personal_medico_nombre_completo_old, '->', personal_medico_nombre_completo_new, '\n',
            'Tipo de Estudio:', estudio_tipo_old, '->', estudio_tipo_new, '\n',
            'FOLIO:', OLD.Folio, '->', NEW.Folio, '\n',
            'RESULTADOS:', OLD.Resultados, '->', NEW.Resultados, '\n',
            'OBSERVACIONES:', OLD.Observaciones, '->', NEW.Observaciones, '\n',
            'ESTATUS:', OLD.Estatus, '->', NEW.Estatus
        ), 
        DEFAULT, 
        DEFAULT
    );
END
&&
DELIMITER ;


-- 4) AFTER DELETE
DELIMITER &&

CREATE DEFINER=`armando.carrasco`@`%` TRIGGER `tbd_resultados_estudios_AFTER_DELETE` AFTER DELETE ON `tbd_resultados_estudios` FOR EACH ROW BEGIN
    DECLARE paciente_nombre_completo VARCHAR(255);
    DECLARE personal_medico_nombre_completo VARCHAR(255);
    DECLARE estudio_tipo VARCHAR(255);

    -- Obtener el nombre completo del paciente
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO paciente_nombre_completo
    FROM tbb_personas p
    JOIN tbb_pacientes pac ON pac.Persona_ID = p.ID
    WHERE pac.Persona_ID = OLD.Paciente_ID;

    -- Obtener el nombre completo del personal médico
    SELECT CONCAT_WS(' ', p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
    INTO personal_medico_nombre_completo
    FROM tbb_personas p
    JOIN tbb_personal_medico pm ON pm.Persona_ID = p.ID
    WHERE pm.Persona_ID = OLD.Personal_Medico_ID;

    -- Obtener el tipo del estudio
    SELECT Tipo
    INTO estudio_tipo
    FROM tbc_estudios
    WHERE ID = OLD.Estudio_ID;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbd_resultados_estudios',
        CONCAT_WS(' ',
            'Se ha eliminado un resultado de estudio con los siguientes datos:', '\n',
            'Nombre del Paciente:', paciente_nombre_completo, '\n',
            'Nombre del Personal Médico:', personal_medico_nombre_completo, '\n',
            'Tipo de Estudio:', estudio_tipo, '\n',
            'FOLIO:', OLD.Folio, '\n',
            'RESULTADOS:', OLD.Resultados, '\n',
            'OBSERVACIONES:', OLD.Observaciones, '\n',
            'ESTATUS:', OLD.Estatus, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END
&&
DELIMITER ;




