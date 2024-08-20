-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Juan Manuel Cruz Ortiz
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  18 de Agosto de 2024


CREATE DEFINER=`Juan.cruz`@`localhost` PROCEDURE `sp_insertar_estudios`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE solicitud_id INT;
    DECLARE consumible_id INT;
    DECLARE random_tipo VARCHAR(50);
    DECLARE random_nivel_urgencia VARCHAR(50);
    DECLARE random_estatus VARCHAR(50);
    DECLARE random_dirigido_a VARCHAR(100);
    DECLARE random_observaciones TEXT;
    DECLARE random_total_costo DECIMAL(10,2);
    DECLARE fecha_registro DATETIME;
    DECLARE fecha_actualizacion DATETIME;

    -- Cursor para recorrer las Solicitudes
    DECLARE solicitud_cursor CURSOR FOR 
        SELECT ID FROM tbd_solicitudes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Abrir cursor
    OPEN solicitud_cursor;

    -- Loop a través de las solicitudes
    solicitud_loop: LOOP
        FETCH solicitud_cursor INTO solicitud_id;
        IF done THEN
            LEAVE solicitud_loop;  -- Salir del loop cuando no haya más solicitudes
        END IF;

        -- Generar valores aleatorios
        SET random_tipo = ELT(FLOOR(1 + (RAND() * 4)), 'Radiografía', 'Análisis de Sangre', 'Tomografía', 'Ultrasonido');
        SET random_nivel_urgencia = ELT(FLOOR(1 + (RAND() * 3)), 'Alta', 'Media', 'Baja');
        SET random_estatus = ELT(FLOOR(1 + (RAND() * 5)), 'Pendiente', 'En Proceso', 'Finalizado', 'Cancelado', 'Reprogramado');
        SET random_dirigido_a = CONCAT('Dr. ', ELT(FLOOR(1 + (RAND() * 5)), 'García', 'Martínez', 'López', 'Hernández', 'Pérez'));
        SET random_observaciones = CONCAT('Estudio realizado para el paciente ID ', solicitud_id);
        SET random_total_costo = ROUND((RAND() * 1000) + 100, 2);

        -- Generar fechas aleatorias
        SET fecha_registro = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * DATEDIFF(NOW(), '2020-01-01')) DAY);
        SET fecha_actualizacion = IF(RAND() < 0.5, DATE_ADD(fecha_registro, INTERVAL FLOOR(RAND() * 30) DAY), NULL);

        -- Insertar en la tabla tbc_estudios
        INSERT INTO tbc_estudios (Tipo, Nivel_Urgencia, SolicitudID, ConsumiblesID, Estatus, Total_Costo, Dirigido_A, Observaciones, Fecha_Registro, Fecha_Actualizacion)
        VALUES (random_tipo, random_nivel_urgencia, solicitud_id, consumible_id, random_estatus, random_total_costo, random_dirigido_a, random_observaciones, fecha_registro, fecha_actualizacion);

    END LOOP;

    CLOSE solicitud_cursor;
END;
