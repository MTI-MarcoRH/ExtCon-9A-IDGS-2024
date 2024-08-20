-- Scrip de la Creacion del Procedimeinto Masivo sp_poblar_aprobaciones();
-- Elaborado por Carlos Iván Crespo Alvarado
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingenieria de Desarrollo y Gestion de Software
-- Fecha de Elaboración: 22 de julio de 2024

-- 1. Verifica la Constriccion de la Tabla
desc tbb_aprobaciones;

-- 2. Poblar de manera estatica la tabla
Call sp_insertar_aprobaciones();
select * from tbb_aprobaciones;

-- 3. Verifica el registro de los eventos en la bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_aprobaciones" ORDER BY ID DESC;

-- 4. Realizamos una consulta Join para visualzar los datos poblados
SELECT p.id, CONCAT_WS(' ', NULLIF(p.titulo, ""), p.nombre, p.primer_apellido, p.segundo_apellido) 
as Solicitante, s.Prioridad, s.Descripcion, a.Comentario, a.Estatus, a.Tipo, a.Fecha_Registro, a.fecha_actualizacion
FROM tbb_personas p
JOIN tbd_solicitudes s ON p.id = s.id
JOIN tbb_aprobaciones a ON a.id=s.id;


-- --------------------------------------------------------------------------------------------------------------
CREATE DEFINER=`carlos.crespo`@`%` PROCEDURE `sp_insertar_aprobaciones`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE p_medico_id INT;
    DECLARE solicitud_id INT;
    DECLARE comentario TEXT;
    DECLARE random_status ENUM('En Proceso', 'Pausado', 'Aprobado', 'Reprogramado', 'Cancelado');
    DECLARE random_type ENUM('Servicio Interno', 'Traslados', 'Subrogado', 'Administrativo');
    DECLARE num_solicitudes INT;
    DECLARE num_medicos INT;
    DECLARE idx INT;
    DECLARE random_index INT;
    DECLARE last_insert_id INT;
    DECLARE inserted_rows INT DEFAULT 0;
    DECLARE fecha_registro DATETIME;
    DECLARE fecha_actualizacion DATETIME;

    -- Cursors
    DECLARE solicitud_cursor CURSOR FOR 
        SELECT ID FROM tbd_solicitudes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Get the total number of Solicitud_IDs
    SELECT COUNT(*) INTO num_solicitudes FROM tbd_solicitudes;

    -- Get the total number of Personal_Medico_IDs
    SELECT COUNT(*) INTO num_medicos FROM tbb_personal_medico;

    -- Open cursor for Solicitud_IDs
    OPEN solicitud_cursor;

    -- Loop through Solicitud_IDs
    solicitud_loop: LOOP
        FETCH solicitud_cursor INTO solicitud_id;
        IF done THEN
            LEAVE solicitud_loop;  -- Exit loop when no more Solicitud_IDs
        END IF;

        -- Select a random Personal_Medico_ID for this Solicitud_ID
        SET random_index = FLOOR(1 + (RAND() * num_medicos));

        -- Retrieve a random Personal_Medico_ID
        SET @sql = CONCAT('SELECT Persona_ID INTO @p_medico_id FROM tbb_personal_medico ORDER BY RAND() LIMIT 1');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Generate random values
        SET idx = FLOOR(1 + (RAND() * 100));
        SET random_status = ELT(FLOOR(1 + (RAND() * 5)), 'En Proceso', 'Pausado', 'Aprobado', 'Reprogramado', 'Cancelado');
        SET random_type = ELT(FLOOR(1 + (RAND() * 4)), 'Servicio Interno', 'Traslados', 'Subrogado', 'Administrativo');

        -- Select a random comment
        CASE idx
            WHEN 1 THEN SET comentario = 'Paciente muestra signos de mejoría.';
            WHEN 2 THEN SET comentario = 'Requiere monitoreo constante.';
            WHEN 3 THEN SET comentario = 'Se recomienda cambio de medicación.';
            WHEN 4 THEN SET comentario = 'Alta programada para mañana.';
            WHEN 5 THEN SET comentario = 'Necesita intervención quirúrgica.';
            WHEN 6 THEN SET comentario = 'Paciente estable, continuar tratamiento actual.';
            WHEN 7 THEN SET comentario = 'Realizar análisis de sangre adicional.';
            WHEN 8 THEN SET comentario = 'Se observa reacción alérgica, cambiar antibiótico.';
            WHEN 9 THEN SET comentario = 'Consultar con especialista en cardiología.';
            WHEN 10 THEN SET comentario = 'Requiere traslado a unidad de cuidados intensivos.';
            WHEN 11 THEN SET comentario = 'Paciente presenta fiebre alta.';
            WHEN 12 THEN SET comentario = 'Iniciar tratamiento con antibióticos.';
            WHEN 13 THEN SET comentario = 'Mantener en observación 24 horas.';
            WHEN 14 THEN SET comentario = 'Evaluar función renal y hepática.';
            WHEN 15 THEN SET comentario = 'Paciente no responde al tratamiento.';
            WHEN 16 THEN SET comentario = 'Administrar líquidos intravenosos.';
            WHEN 17 THEN SET comentario = 'Preparar para radiografía de tórax.';
            WHEN 18 THEN SET comentario = 'Recomendar dieta baja en sodio.';
            WHEN 19 THEN SET comentario = 'Paciente en recuperación postoperatoria.';
            WHEN 20 THEN SET comentario = 'Reevaluar síntomas en 48 horas.';
            WHEN 21 THEN SET comentario = 'Realizar electrocardiograma (ECG).';
            WHEN 22 THEN SET comentario = 'Observar por posibles complicaciones.';
            WHEN 23 THEN SET comentario = 'Paciente presenta dolor agudo.';
            WHEN 24 THEN SET comentario = 'Administrar analgésicos según prescripción.';
            WHEN 25 THEN SET comentario = 'Evaluar función pulmonar.';
            WHEN 26 THEN SET comentario = 'Paciente reporta mareos frecuentes.';
            WHEN 27 THEN SET comentario = 'Recomendar descanso absoluto.';
            WHEN 28 THEN SET comentario = 'Administrar antihistamínicos.';
            WHEN 29 THEN SET comentario = 'Programar sesión de fisioterapia.';
            WHEN 30 THEN SET comentario = 'Realizar pruebas de función tiroidea.';
            WHEN 31 THEN SET comentario = 'Paciente presenta náuseas y vómitos.';
            WHEN 32 THEN SET comentario = 'Iniciar tratamiento para hipertensión.';
            WHEN 33 THEN SET comentario = 'Recomendar control de glucemia.';
            WHEN 34 THEN SET comentario = 'Paciente muestra signos de deshidratación.';
            WHEN 35 THEN SET comentario = 'Administrar suero oral.';
            WHEN 36 THEN SET comentario = 'Evaluar respuesta a la medicación.';
            WHEN 37 THEN SET comentario = 'Paciente en estado crítico.';
            WHEN 38 THEN SET comentario = 'Mantener en unidad de cuidados intensivos.';
            WHEN 39 THEN SET comentario = 'Realizar tomografía computarizada (TC).';
            WHEN 40 THEN SET comentario = 'Paciente con historial de alergias.';
            WHEN 41 THEN SET comentario = 'Administrar epinefrina en caso de emergencia.';
            WHEN 42 THEN SET comentario = 'Monitorizar niveles de oxígeno en sangre.';
            WHEN 43 THEN SET comentario = 'Paciente requiere ventilación asistida.';
            WHEN 44 THEN SET comentario = 'Evaluar necesidad de transfusión sanguínea.';
            WHEN 45 THEN SET comentario = 'Paciente presenta síntomas de infección.';
            WHEN 46 THEN SET comentario = 'Iniciar aislamiento preventivo.';
            WHEN 47 THEN SET comentario = 'Realizar pruebas de función hepática.';
            WHEN 48 THEN SET comentario = 'Paciente en estado de shock.';
            WHEN 49 THEN SET comentario = 'Administrar fluidos intravenosos rápidamente.';
            WHEN 50 THEN SET comentario = 'Recomendar consulta con endocrinólogo.';
            WHEN 51 THEN SET comentario = 'Paciente presenta convulsiones.';
            WHEN 52 THEN SET comentario = 'Administrar anticonvulsivantes.';
            WHEN 53 THEN SET comentario = 'Recomendar seguimiento neurológico.';
            WHEN 54 THEN SET comentario = 'Paciente con dolor torácico persistente.';
            WHEN 55 THEN SET comentario = 'Realizar angiografía coronaria.';
            WHEN 56 THEN SET comentario = 'Paciente presenta erupción cutánea.';
            WHEN 57 THEN SET comentario = 'Administrar corticosteroides tópicos.';
            WHEN 58 THEN SET comentario = 'Evaluar signos de sepsis.';
            WHEN 59 THEN SET comentario = 'Iniciar tratamiento antibiótico de amplio espectro.';
            WHEN 60 THEN SET comentario = 'Paciente con historial de enfermedades cardíacas.';
            WHEN 61 THEN SET comentario = 'Recomendar prueba de esfuerzo.';
            WHEN 62 THEN SET comentario = 'Paciente presenta dificultad respiratoria.';
            WHEN 63 THEN SET comentario = 'Administrar broncodilatadores.';
            WHEN 64 THEN SET comentario = 'Paciente en recuperación post-anestesia.';
            WHEN 65 THEN SET comentario = 'Monitorizar signos vitales cada 30 minutos.';
            WHEN 66 THEN SET comentario = 'Realizar ecografía abdominal.';
            WHEN 67 THEN SET comentario = 'Paciente con signos de anemia.';
            WHEN 68 THEN SET comentario = 'Administrar suplemento de hierro.';
            WHEN 69 THEN SET comentario = 'Paciente requiere evaluación psiquiátrica.';
            WHEN 70 THEN SET comentario = 'Iniciar terapia cognitivo-conductual.';
            WHEN 71 THEN SET comentario = 'Paciente con historial de diabetes.';
            WHEN 72 THEN SET comentario = 'Recomendar control estricto de glucosa.';
            WHEN 73 THEN SET comentario = 'Realizar prueba de función pulmonar.';
            WHEN 74 THEN SET comentario = 'Paciente presenta ictericia.';
            WHEN 75 THEN SET comentario = 'Evaluar función hepática y biliar.';
            WHEN 76 THEN SET comentario = 'Paciente con síntomas de migraña.';
            WHEN 77 THEN SET comentario = 'Administrar triptanos según prescripción.';
            WHEN 78 THEN SET comentario = 'Realizar resonancia magnética (RM).';
            WHEN 79 THEN SET comentario = 'Paciente con dolor lumbar agudo.';
            WHEN 80 THEN SET comentario = 'Recomendar fisioterapia y ejercicios de estiramiento.';
            WHEN 81 THEN SET comentario = 'Paciente muestra signos de fatiga crónica.';
            WHEN 82 THEN SET comentario = 'Evaluar por posibles trastornos del sueño.';
            WHEN 83 THEN SET comentario = 'Paciente con historial de cáncer.';
            WHEN 84 THEN SET comentario = 'Programar seguimiento oncológico.';
            WHEN 85 THEN SET comentario = 'Paciente requiere cuidados paliativos.';
            WHEN 86 THEN SET comentario = 'Administrar analgésicos según necesidad.';
            WHEN 87 THEN SET comentario = 'Paciente con signos de infección urinaria.';
            WHEN 88 THEN SET comentario = 'Iniciar tratamiento con antibióticos.';
            WHEN 89 THEN SET comentario = 'Realizar endoscopia digestiva alta.';
            WHEN 90 THEN SET comentario = 'Paciente con antecedentes de asma.';
            WHEN 91 THEN SET comentario = 'Administrar corticosteroides inhalados.';
            WHEN 92 THEN SET comentario = 'Paciente presenta signos de depresión.';
            WHEN 93 THEN SET comentario = 'Iniciar tratamiento con antidepresivos.';
            WHEN 94 THEN SET comentario = 'Recomendar terapia psicológica.';
            WHEN 95 THEN SET comentario = 'Paciente en estado de desnutrición.';
            WHEN 96 THEN SET comentario = 'Iniciar dieta rica en nutrientes.';
            WHEN 97 THEN SET comentario = 'Paciente presenta dolor articular.';
            WHEN 98 THEN SET comentario = 'Administrar antiinflamatorios no esteroideos (AINEs).';
            WHEN 99 THEN SET comentario = 'Recomendar seguimiento con reumatólogo.';
            WHEN 100 THEN SET comentario = 'Paciente requiere atención odontológica.';
            ELSE SET comentario = 'No hay comentarios adicionales.';
        END CASE;

        -- Generar fecha de registro aleatoria entre el año 2000 y la fecha actual
        SET fecha_registro = DATE_ADD('2000-01-01', INTERVAL FLOOR(RAND() * DATEDIFF(NOW(), '2000-01-01')) DAY);
        SET fecha_registro = DATE_ADD(fecha_registro, INTERVAL FLOOR(RAND() * 24) HOUR); -- Agregar horas aleatorias
        SET fecha_registro = DATE_ADD(fecha_registro, INTERVAL FLOOR(RAND() * 60) MINUTE); -- Agregar minutos aleatorios
        SET fecha_registro = DATE_ADD(fecha_registro, INTERVAL FLOOR(RAND() * 60) SECOND); -- Agregar segundos aleatorios

        -- Verificar si hay una actualización previa para esta solicitud y si el nuevo status es "En Proceso"
        SELECT MAX(fecha_actualizacion) INTO fecha_actualizacion
        FROM tbb_aprobaciones
        WHERE solicitud_id = solicitud_id;

        IF fecha_actualizacion IS NOT NULL AND random_status = 'En Proceso' THEN
            -- Si hay una fecha de actualización previa y el nuevo estatus es "En Proceso", seleccionar otro estatus aleatorio que no sea "En Proceso"
            SET random_status = ELT(FLOOR(2 + (RAND() * 4)), 'Pausado', 'Aprobado', 'Reprogramado', 'Cancelado'); -- Evitar 'En Proceso'
        END IF;

        -- Generar fecha de actualización dentro de un rango de 2 a 3 días si el estatus no está en "En Proceso"
        IF random_status != 'En Proceso' THEN
            SET fecha_actualizacion = DATE_ADD(fecha_registro, INTERVAL 2 + FLOOR(RAND() * 2) DAY); -- Fecha aleatoria entre 2 y 3 días después de la fecha de registro
            SET fecha_actualizacion = DATE_ADD(fecha_actualizacion, INTERVAL FLOOR(RAND() * 24) HOUR); -- Agregar horas aleatorias
            SET fecha_actualizacion = DATE_ADD(fecha_actualizacion, INTERVAL FLOOR(RAND() * 60) MINUTE); -- Agregar minutos aleatorios
            SET fecha_actualizacion = DATE_ADD(fecha_actualizacion, INTERVAL FLOOR(RAND() * 60) SECOND); -- Agregar segundos aleatorios
        ELSE
            SET fecha_actualizacion = NULL; -- Dejar fecha_actualizacion como NULL si el estatus es "En Proceso"
        END IF;

        -- Insert into tbb_aprobaciones
        INSERT INTO tbb_aprobaciones (Personal_Medico_ID, Solicitud_ID, Comentario, Estatus, Tipo, Fecha_Registro, Fecha_Actualizacion)
        VALUES (@p_medico_id, solicitud_id, comentario, random_status, random_type, fecha_registro, fecha_actualizacion);

        -- Obtener el ID del registro insertado
        SET last_insert_id = LAST_INSERT_ID();
        SET inserted_rows = inserted_rows + 1;

        -- Actualizar aleatoriamente algunos registros después de la inserción
        IF RAND() < 0.5 AND inserted_rows < num_solicitudes - 1 THEN -- Aproximadamente el 50% de las veces
            -- Generar un nuevo tipo y estatus aleatorio para un registro aleatorio
            UPDATE tbb_aprobaciones
            SET Tipo = ELT(FLOOR(1 + (RAND() * 4)), 'Servicio Interno', 'Traslados', 'Subrogado', 'Administrativo'),
                Estatus = ELT(FLOOR(1 + (RAND() * 5)), 'En Proceso', 'Pausado', 'Aprobado', 'Reprogramado', 'Cancelado')
            WHERE id = last_insert_id AND Estatus != 'En Proceso'; -- Evitar actualizar a 'En Proceso'
        END IF;

        -- Eliminar Registros de manera aleatoria
        IF RAND() < 0.2 AND inserted_rows < num_solicitudes - 1 THEN  -- Aproximadamente el 20% de las veces
            DELETE FROM tbb_aprobaciones 
            WHERE id = last_insert_id; -- Elimina el Registro actual
        END IF;

    END LOOP;

    CLOSE solicitud_cursor;
END
