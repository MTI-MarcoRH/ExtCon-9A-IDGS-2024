
CREATE DEFINER=`carlos.crespo`@`%` TRIGGER `tbb_aprobaciones_BEFORE_INSERT` BEFORE INSERT ON `tbb_aprobaciones` FOR EACH ROW BEGIN
    -- Declaración de variables
    DECLARE v_estatus_descripcion VARCHAR(20) DEFAULT 'En Proceso';
    DECLARE v_tipo_solicitud VARCHAR(20) DEFAULT 'Servicio Interno';
    DECLARE personal_medico VARCHAR(200) DEFAULT 'No Aplica';
    DECLARE v_personal_medico_id INT;
    DECLARE v_solicitud_id INT;
    DECLARE solicitud VARCHAR(200) DEFAULT 'Sin datos de Solicitud';

	-- Restringir titulo
	-- DECLARE v_titulo VARCHAR(20);
    
    -- Asignar el id del personal médico
    SET v_personal_medico_id = NEW.personal_medico_id;
    
    -- Asignación de la solicitud
    SET v_solicitud_id = NEW.solicitud_id;
    
    
    -- ----------------------------------
        -- Verificar mediante una condicion si el Titulo es permitido
    /*
    SELECT p.Titulo INTO v_titulo
    FROM tbb_personas p
    WHERE p.id = v_personal_medico_id;

    IF v_titulo NOT IN ('Dr.', 'Dra.',  'Lic.', 'Ing.', 'Tec.', 'Q.F.C.') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Titulo no permitido. La Solicitud solo está permitida para Dr., Dra., Lic., Ing, Tec., Q.F.C.';
    END IF;
    */
	-- ----------------------------------
    -- Intentar obtener el nombre del personal médico con su rol
    BEGIN
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET personal_medico = 'No Aplica - Sin Rol';
        SELECT CONCAT(p.Titulo, ' ', p.Nombre, ' ', p.Primer_Apellido, ' ', COALESCE(p.Segundo_Apellido, ''), ' - ', COALESCE(r.nombre, 'Sin Rol'))
        INTO personal_medico
        FROM tbb_personas p
        LEFT JOIN tbc_roles r ON p.id = r.id
        WHERE p.id = v_personal_medico_id AND p.Titulo IN ('Dr.', 'Dra.',  'Lic.', 'Ing.', 'Tec.', 'Q.F.C.');
    END;

    -- Intentar obtener la descripción de la solicitud
    BEGIN
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET solicitud = 'Sin datos de Solicitud';
		SELECT CONCAT('Su Prioridad es: ', Prioridad, ' - ', 'Su estatus es: ', Estatus, ' ')
		INTO solicitud
		FROM tbd_solicitudes
		WHERE id = v_solicitud_id;
	END;
    
    -- Validación del estatus del registro
    CASE NEW.Estatus
        WHEN 'En Proceso' THEN SET v_estatus_descripcion = 'En Proceso';
        WHEN 'Pausado' THEN SET v_estatus_descripcion = 'Pausado';
        WHEN 'Aprobado' THEN SET v_estatus_descripcion = 'Aprobado';
        WHEN 'Reprogramado' THEN SET v_estatus_descripcion = 'Reprogramado';
        WHEN 'Cancelado' THEN SET v_estatus_descripcion = 'Cancelado';
    END CASE;

    -- Validación del tipo de solicitud
    CASE NEW.tipo
        WHEN 'Servicio Interno' THEN SET v_tipo_solicitud = 'Servicio Interno';
        WHEN 'Traslados' THEN SET v_tipo_solicitud = 'Traslados';
        WHEN 'Subrogado' THEN SET v_tipo_solicitud = 'Subrogado';
        WHEN 'Administrativo' THEN SET v_tipo_solicitud = 'Administrativo';
    END CASE;

    -- Inserción en la tabla tbi_bitacora
    INSERT INTO tbi_bitacora (
        Usuario,
        Operacion,
        Tabla,
        Descripcion,
        Estatus,
        Fecha_Registro
    ) VALUES (
        CURRENT_USER(),
        'Create',
        'tbb_aprobaciones',
        CONCAT(
            'Se ha registrado una nueva aprobación con los siguientes datos:', '\n',
            'Personal Médico: ', personal_medico, '\n',
            'Solicitud: ', solicitud , '\n',
            'Comentario: ', COALESCE(NEW.comentario, 'Sin Comentarios'), '\n',
            'Estatus: ', v_estatus_descripcion, '\n',
            'Tipo: ', v_tipo_solicitud, '\n',
            'Fecha de Registro: ', COALESCE(NEW.fecha_registro, 'N/A'), '\n',
            'Fecha de Actualización: ', COALESCE(NEW.fecha_actualizacion, 'N/A')
        ),
        default,
        NOW()
    );
END