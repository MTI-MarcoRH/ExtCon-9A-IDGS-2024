-- SCRIPT DE CREACIÓN DE EL PROCEDIMIENTO ALMACENADO DE LA TABLA ASIGNADA

-- Elaborado por: Arturo Aguilar Santos
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 17 de Agosto del 2024

-- Procedimiento almacenado dinamico de la Tabla: Expedientes Medicos

DELIMITER $$
&&
CREATE DEFINER=`arturo.aguilar`@`%` PROCEDURE `sp_poblar_expedientes_clinicos_dinamicos`(v_num_inserciones INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_persona_id INT;
    
    DECLARE v_antecedentes_medicos_patologicos TEXT;
    DECLARE v_antecedentes_medicos_nopatologicos TEXT;
    DECLARE v_antecedentes_medicos_patoheredo_familiares TEXT;
    DECLARE v_interrogatorio_sistemas TEXT;
    DECLARE v_padecimiento_actual TEXT;
    DECLARE v_notas_medicas TEXT;
    DECLARE v_estatus BOOLEAN;
    DECLARE v_fecha_registro DATETIME;
    DECLARE v_fecha_actualizacion DATETIME;

    -- Inicialización del generador de datos aleatorios
    SET v_fecha_registro = NOW();
    SET v_fecha_actualizacion = NOW();

    WHILE i <= v_num_inserciones DO
        -- Seleccionar un ID de persona válido aleatoriamente
        SELECT ID INTO v_persona_id
        FROM tbb_personas
        LIMIT 1;
        set v_persona_id = i;

        -- Verificar que se ha obtenido un ID válido
        IF v_persona_id IS NOT NULL THEN
            SET v_antecedentes_medicos_patologicos = fn_genera_Antecendentes_Medicos_Patologicos();
            SET v_antecedentes_medicos_nopatologicos = fn_genera_Antecendentes_Medicos_NoPatologicos();
            SET v_antecedentes_medicos_patoheredo_familiares = fn_genera_Antecendentes_Medicos_Patologicos_HeredoFamiliares();
            SET v_interrogatorio_sistemas = fn_genera_Interrogatorio_Sistemas();
            SET v_padecimiento_actual = fn_genera_Padecimiento_Actual();
            SET v_notas_medicas = fn_genera_Notas_Medicas();
            SET v_estatus = CASE 
                                WHEN i % 2 = 0 THEN TRUE
                                ELSE FALSE
                            END;
            SET v_fecha_registro = DATE_ADD(NOW(), INTERVAL i DAY);  -- Incrementa la fecha de registro por días
            SET v_fecha_actualizacion = DATE_ADD(v_fecha_registro, INTERVAL i MINUTE);  -- Incrementa la fecha de actualización por minutos

            -- Inserción en la tabla
            INSERT INTO tbd_expedientes_clinicos (
                Persona_ID, Antecendentes_Medicos_Patologicos, Antecendentes_Medicos_NoPatologicos,
                Antecendentes_Medicos_Patologicos_HeredoFamiliares, Interrogatorio_sistemas, 
                Padecimiento_Actual, Notas_Medicas, Estatus, Fecha_Registro, Fecha_Actualizacion
            )
            VALUES (
                v_persona_id, v_antecedentes_medicos_patologicos, v_antecedentes_medicos_nopatologicos,
                v_antecedentes_medicos_patoheredo_familiares, v_interrogatorio_sistemas,
                v_padecimiento_actual, v_notas_medicas, v_estatus, v_fecha_registro, v_fecha_actualizacion
            );
        ELSE
            -- Si no se obtiene un ID válido, manejar el error según tus necesidades
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se encontró un ID válido en la tabla tbb_personas.';
        END IF;

        SET i = i + 1;
    END WHILE;
END
DELIMITER ;