-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Carlos Martin Hernández de Jesús
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  04 de Julio de 2024

-- Como probarlo

-- 1. LIMPIAR BD 
call sp_limpiar_bd("xYz$123");
-- 2.  ESTATUS BD
call sp_estatus_bd("xYz$123");
-- 3 Personal Médico (Estatica) - Corregir
CALL sp_poblar_personal_medico("xyz#$%");
-- 4 Pacientes (Estatica)
CALL sp_poblar_pacientes("1234");
-- 5 Servicios Medicos (Estatica)
CALL sp_poblar_servicios_medicos("1234");
-- 5.1 Solicitudes
CALL sp_poblar_solicitudes_dinamica(5, 'xYz$123');

CREATE DEFINER=`Carlos.Hernandez`@`%` PROCEDURE `sp_poblar_solicitudes_dinamica`(IN cantidad INT, IN v_password VARCHAR(10))
BEGIN
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_paciente INT;
    DECLARE v_medico INT;
    DECLARE v_servicio INT;
    DECLARE v_prioridad ENUM('Urgente', 'Alta', 'Moderada', 'Emergente', 'Normal');
    DECLARE v_estatus ENUM('Registrada', 'Programada', 'Cancelada', 'Reprogramada', 'En Proceso', 'Realizada');
    DECLARE v_descripcion TEXT;

    IF v_password = 'xYz$123' THEN
        WHILE v_i < cantidad DO
            -- Seleccionar aleatoriamente un paciente, un médico y un servicio
            SET v_paciente = (SELECT Persona_ID FROM tbb_pacientes ORDER BY RAND() LIMIT 1);
            SET v_medico = (SELECT Persona_ID FROM tbb_personal_medico ORDER BY RAND() LIMIT 1);
            SET v_servicio = (SELECT ID FROM tbc_servicios_medicos ORDER BY RAND() LIMIT 1);

            -- Seleccionar aleatoriamente una prioridad y un estatus
            SET v_prioridad = ELT(fn_numero_aleatorio_rangos(1, 5), 'Urgente', 'Alta', 'Moderada', 'Emergente', 'Normal');
            SET v_estatus = ELT(fn_numero_aleatorio_rangos(1, 6), 'Registrada', 'Programada', 'Cancelada', 'Reprogramada', 'En Proceso', 'Realizada');

            -- Seleccionar aleatoriamente una descripción
            SET v_descripcion = ELT(fn_numero_aleatorio_rangos(1, 7), 
                'Revisión médica general para evaluar estado de salud.',
                'Consulta especializada para tratamiento de una condición específica.',
                'Examen de rutina para monitorear parámetros de salud.',
                'Tratamiento intensivo para una enfermedad diagnosticada.',
                'Seguimiento post-quirúrgico para asegurar recuperación.',
                'Revisión periódica para control de enfermedad crónica.',
                'Consulta de emergencia para una situación aguda.'
            );

            -- Insertar el nuevo registro en la tabla tbd_solicitudes
            INSERT INTO tbd_solicitudes (
                Paciente_ID, Medico_ID, Servicio_ID, Prioridad, Descripcion, Estatus, Estatus_Aprobacion, Fecha_Registro, Fecha_Actualizacion
            ) VALUES (
                v_paciente, v_medico, v_servicio, v_prioridad, v_descripcion, v_estatus, b'0', DEFAULT, NULL
            );

            SET v_i = v_i + 1;
        END WHILE;
    ELSE
        -- Mensaje de error si la contraseña es incorrecta
        SELECT 'La contraseña es incorrecta, no puede realizar cambios en la Base de Datos' AS ErrorMessage;
    END IF;
END