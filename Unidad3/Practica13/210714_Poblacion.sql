-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Queries para revisión  y población de la tabla: Valoraciones Medicas

CREATE DEFINER=`romualdo`@`localhost` PROCEDURE `sp_poblar_valoraciones_medicas`(v_password VARCHAR(20))
BEGIN
    IF v_password = "hola123" THEN
        -- Inserciones en la tabla tbb_valoraciones_medicas
        INSERT INTO hospital_general_9a_idgs_matricula.tbb_valoraciones_medicas (
             Valor, Indicador, Unidad_medida, Paciente_id, Cita_id, Pm_id, Estatus, Fecha_registro
        ) VALUES 
        (36.5, 'Temperatura Corporal', 'Celsius', 1, 101, 1, 1, '2024-06-06'),
        (120, 'Presión Arterial Sistólica', 'mmHg', 2, 102, 2, 1, '2024-06-07'),
        (70, 'Frecuencia Cardíaca', 'bpm', 3, 103, 3, 1, '2024-06-07'),
        (180, 'Altura', 'cm', 4, 104, 4, 1, '2024-06-07'),
        (75, 'Peso Corporal', 'kg', 5, 105, 5, 1, '2024-06-07');

        -- Actualización de un registro en tbb_valoraciones_medicas
        UPDATE hospital_general_9a_idgs_matricula.tbb_valoraciones_medicas
        SET Valor = 38.0, Indicador = 'Temperatura Corporal Actualizada'
        WHERE ID = 1;

        -- Eliminación de un registro en tbb_valoraciones_medicas
        DELETE FROM hospital_general_9a_idgs_matricula.tbb_valoraciones_medicas
        WHERE Paciente_id = 1;

    ELSE
        SELECT "La contraseña es incorrecta, no puedo mostrarte el estatus de la base de datos" AS ErrorMessage;
    END IF;
END
