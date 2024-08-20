-- SCRIPT DE CREACIÓN DE EL PROCEDIMIENTO ALMACENADO DE LA TABLA ASIGNADA

-- Elaborado por: Justin Martin Muñoz Escorcia
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Procedimiento almacenado dinamico de las Tablas: Pacientes y Seguimiento pacientes

--tbb_pacientes

CREATE DEFINER=`justin.muñoz`@`%` PROCEDURE `sp_poblar_pacientes_dinamico`(v_num_inserciones INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    DECLARE v_persona_id INT;
    DECLARE v_nss VARCHAR(15);
    DECLARE v_tipo_seguro VARCHAR(50);
    DECLARE v_fecha_ultima_cita DATETIME;
    DECLARE v_estatus_medico VARCHAR(100);
    DECLARE v_estatus_vida ENUM('Vivo','Finado','Coma','Vegetativo');
    DECLARE v_estatus BINARY(1);
    DECLARE v_fecha_registro DATETIME;
    DECLARE v_fecha_actualizacion DATETIME;

    -- Inicialización del generador de datos aleatorios
    SET v_fecha_registro = CURRENT_TIMESTAMP;
    SET v_fecha_actualizacion = NULL;

    WHILE i <= v_num_inserciones DO
        
        SET v_persona_id = i;
        SET v_nss = CONCAT('NSS-', LPAD(i, 5, '0'));  
        SET v_tipo_seguro = fn_genera_tipo_seguro();
        
        SET v_fecha_ultima_cita = DATE_ADD(CURRENT_DATE, INTERVAL - (i % 30) DAY);  
        SET v_estatus_medico = fn_genera_estatusmedico();
        
		
        
        SET v_estatus_vida = fn_genera_estatusvida();
        SET v_estatus = CASE 
                           WHEN i % 2 = 0 THEN 1
                           ELSE 0
                        END;

        -- Inserción en la tabla
        INSERT INTO tbb_pacientes (
            Persona_ID, NSS, Tipo_Seguro, Fecha_Ultima_Cita, Estatus_Medico, Estatus_Vida, Estatus, Fecha_Registro, Fecha_Actualizacion
        )
        VALUES (
            v_persona_id, v_nss, v_tipo_seguro, v_fecha_ultima_cita, v_estatus_medico, v_estatus_vida, v_estatus, v_fecha_registro, v_fecha_actualizacion
        );

        -- Verificación de inserción
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en tbb_pacientes';
        END IF;

        SET i = i + 1;
    END WHILE;
    
    -- Actualización de un registro específico (ejemplo: Persona_ID = 1)
    UPDATE tbb_pacientes 
    SET Fecha_Ultima_Cita = '2024-08-30 10:00:00', Estatus_Medico = 'En tratamiento' 
    WHERE Persona_ID = 1;

    -- Eliminación de un registro específico (ejemplo: Persona_ID = 4)
    DELETE FROM tbb_pacientes WHERE Persona_ID = 4;

END



--tbd_seguimiento_pacientes


CREATE DEFINER=`justin.muñoz`@`%` PROCEDURE `sp_poblar_seguimiento_pacientes_dinamico`(v_num_inserciones INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    DECLARE v_paciente_id INT;
    DECLARE v_personal_medico_id INT;
    DECLARE v_observaciones VARCHAR(100);
    DECLARE v_estatus BINARY(1);
    DECLARE v_fecha_registro DATETIME;
    DECLARE v_fecha_actualizacion DATETIME;

    -- Inicialización del generador de datos aleatorios
    SET v_fecha_registro = CURRENT_TIMESTAMP;
    SET v_fecha_actualizacion = NULL;

    WHILE i <= v_num_inserciones DO
        
        SET v_paciente_id = (i % 10) + 1;  -- Asume que hay al menos 10 pacientes
        SET v_personal_medico_id = (i % 5) + 1;  -- Asume que hay al menos 5 personal médico
        SET v_observaciones = fn_genera_Observacion();
        SET v_estatus = CASE 
                           WHEN i % 2 = 0 THEN b'1'
                           ELSE b'0'
                        END;

        -- Inserción en la tabla
        INSERT INTO tbd_seguimiento_pacientes (
            Paciente_ID, Personal_Medico_ID, Observaciones, Estatus, Fecha_Registro, Fecha_Actualizacion
        )
        VALUES (
            v_paciente_id, v_personal_medico_id, v_observaciones, v_estatus, v_fecha_registro, v_fecha_actualizacion
        );

        SET i = i + 1;
    END WHILE;
    
    -- Actualización de un registro específico (ejemplo: Paciente_ID = 1 y Personal_Medico_ID = 1)
    UPDATE tbd_seguimiento_pacientes 
    SET Observaciones = 'Observaciones Actualizadas', Fecha_Actualizacion = CURRENT_TIMESTAMP
    WHERE Paciente_ID = 1 AND Personal_Medico_ID = 1;

    -- Eliminación de un registro específico (ejemplo: Paciente_ID = 2 y Personal_Medico_ID = 2)
    DELETE FROM tbd_seguimiento_pacientes WHERE Paciente_ID = 2 AND Personal_Medico_ID = 2;

END