-- SCRIPT DE TRIGGERS DE LA TABLA 'tbd_lotes_medicamentos'

-- ELABORADO POR: MYRIAM VALDERRABANO CORTES
-- GRADO Y GRUPO: 9°
-- PROGRAMA EDUCATIVO: INGENIERÍA EN DESARROLLO Y GESTIÓN DE SOFTWARE
-- FECHA DE ELABORACIÓN: 21 DE JULIO DE 2024



-- --------------------------- AFTER INSERT

CREATE DEFINER=`myriam.valderrabano`@`%` TRIGGER `tbd_lotes_medicamentos_AFTER_INSERT` AFTER INSERT ON `tbd_lotes_medicamentos` FOR EACH ROW BEGIN

    DECLARE v_estatus_descripcion VARCHAR(20) DEFAULT 'Reservado';
    DECLARE v_nombre_generico VARCHAR(80);
    DECLARE v_personal_medico VARCHAR(200);

    SELECT Nombre_generico INTO v_nombre_generico
    FROM tbc_medicamentos
    WHERE ID = NEW.Medicamento_ID;

    -- Obtenemos los datos del personal médico
    SELECT CONCAT_WS(' ', Titulo, Nombre, Primer_Apellido, Segundo_Apellido) INTO v_personal_medico
    FROM tbb_personas
    WHERE ID = (SELECT Persona_ID FROM tbb_personal_medico WHERE Persona_ID = NEW.Personal_Medico_ID);

    IF NEW.Estatus = 'Reservado' THEN
        SET v_estatus_descripcion = 'Reservado';
    ELSEIF NEW.Estatus = 'En transito' THEN
        SET v_estatus_descripcion = 'En transito';
    ELSEIF NEW.Estatus = 'Recibido' THEN
        SET v_estatus_descripcion = 'Recibido';
    ELSEIF NEW.Estatus = 'Rechazado' THEN
        SET v_estatus_descripcion = 'Rechazado';
    END IF;

    INSERT INTO tbi_bitacora VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbb_lotes_medicamentos',
        CONCAT_WS(' ', 
            'Se ha insertado un nuevo Lote de Medicamento con:',
            '\n Nombre Genérico del Medicamento:', v_nombre_generico,
            '\n Personal Médico:', v_personal_medico,
            '\n Clave:', NEW.Clave,
            '\n Estatus:', NEW.Estatus,
            '\n Costo_Total:', NEW.Costo_Total,
            '\n Cantidad:', NEW.Cantidad,
            '\n y Ubicado en:', NEW.Ubicacion),
        DEFAULT,
        DEFAULT
    );
END




-- --------------------------- BEFORE UPDATE

CREATE DEFINER=`myriam.valderrabano`@`%` TRIGGER `tbd_lotes_medicamentos_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_lotes_medicamentos` FOR EACH ROW BEGIN
	set new.Fecha_Actualizacion = current_timestamp();
END




-- --------------------------- AFTER UPDATE

CREATE DEFINER=`myriam.valderrabano`@`%` TRIGGER `tbd_lotes_medicamentos_AFTER_UPDATE` AFTER UPDATE ON `tbd_lotes_medicamentos` FOR EACH ROW BEGIN
	DECLARE v_estatus_descripcion VARCHAR(20);
    DECLARE v_nombre_generico_old VARCHAR(80);
    DECLARE v_nombre_generico_new VARCHAR(80);
    DECLARE v_personal_medico_old VARCHAR(200);
    DECLARE v_personal_medico_new VARCHAR(200);

    SELECT Nombre_generico INTO v_nombre_generico_old
    FROM tbc_medicamentos
    WHERE ID = OLD.Medicamento_ID;

    SELECT Nombre_generico INTO v_nombre_generico_new
    FROM tbc_medicamentos
    WHERE ID = NEW.Medicamento_ID;

    SELECT CONCAT_WS(' ', Titulo, Nombre, Primer_Apellido, Segundo_Apellido) INTO v_personal_medico_old
    FROM tbb_personas
    WHERE ID = (SELECT Persona_ID FROM tbb_personal_medico WHERE Persona_ID = OLD.Personal_Medico_ID);

    SELECT CONCAT_WS(' ', Titulo, Nombre, Primer_Apellido, Segundo_Apellido) INTO v_personal_medico_new
    FROM tbb_personas
    WHERE ID = (SELECT Persona_ID FROM tbb_personal_medico WHERE Persona_ID = NEW.Personal_Medico_ID);

    -- Asignamos una descripción al estatus del lote de medicamento
    CASE NEW.Estatus
        WHEN 'Reservado' THEN SET v_estatus_descripcion := 'Reservado';
        WHEN 'En transito' THEN SET v_estatus_descripcion := 'En transito';
        WHEN 'Recibido' THEN SET v_estatus_descripcion := 'Recibido';
        WHEN 'Rechazado' THEN SET v_estatus_descripcion := 'Rechazado';
    END CASE;

    INSERT INTO tbi_bitacora VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Update',
        'tbb_lotes_medicamentos',
        CONCAT_WS(' ', 
            'Se ha actualizado el Lote de Medicamento con la siguiente información:',
            '\n Nombre Genérico del Medicamento:', v_nombre_generico_old, '-', v_nombre_generico_new,
            '\n Personal Médico:', v_personal_medico_old, '-', v_personal_medico_new,
            '\n Clave:', OLD.Clave, '-', NEW.Clave,
            '\n Estatus:', OLD.Estatus, '-', v_estatus_descripcion,
            '\n Costo Total:', OLD.Costo_Total, '-', NEW.Costo_Total,
            '\n Cantidad:', OLD.Cantidad, '-', NEW.Cantidad,
            '\n y Ubicación:', OLD.Ubicacion, '-', NEW.Ubicacion
        ),
        DEFAULT,
        DEFAULT
    );
END



-- ------------------------------------------ AFTER DELETE

CREATE DEFINER=`myriam.valderrabano`@`%` TRIGGER `tbd_lotes_medicamentos_AFTER_DELETE` AFTER DELETE ON `tbd_lotes_medicamentos` FOR EACH ROW BEGIN
    DECLARE v_estatus_descripcion VARCHAR(20);
    DECLARE v_nombre_generico VARCHAR(80);
    DECLARE v_personal_medico VARCHAR(200);

    SELECT Nombre_generico INTO v_nombre_generico
    FROM tbc_medicamentos
    WHERE ID = OLD.Medicamento_ID;

    SELECT CONCAT_WS(' ', Titulo, Nombre, Primer_Apellido, Segundo_Apellido) INTO v_personal_medico
    FROM tbb_personas
    WHERE ID = (SELECT Persona_ID FROM tbb_personal_medico WHERE Persona_ID = OLD.Personal_Medico_ID);

    CASE OLD.Estatus
        WHEN 'Reservado' THEN SET v_estatus_descripcion := 'Reservado';
        WHEN 'En transito' THEN SET v_estatus_descripcion := 'En transito';
        WHEN 'Recibido' THEN SET v_estatus_descripcion := 'Recibido';
        WHEN 'Rechazado' THEN SET v_estatus_descripcion := 'Rechazado';
    END CASE;

    INSERT INTO tbi_bitacora VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbb_lotes_medicamentos',
        CONCAT_WS(' ', 
            'Se ha eliminado el Lote de Medicamento con:',
            '\n Nombre Genérico del Medicamento:', v_nombre_generico,
            '\n Personal Médico:', v_personal_medico,
            '\n Clave:', OLD.Clave,
            '\n Estatus:', v_estatus_descripcion,
            '\n Costo Total:', OLD.Costo_Total,
            '\n Cantidad:', OLD.Cantidad,
            '\n y con Ubicación:', OLD.Ubicacion
        ),
        DEFAULT,
        DEFAULT
    );
END