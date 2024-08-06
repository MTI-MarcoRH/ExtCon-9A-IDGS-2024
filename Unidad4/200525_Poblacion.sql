-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por:AMERICA YAELY ESTUDILLO LICONA
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  05 de Agosto de 2024

-- Queries para revisión  y población de la tabla: Personal Médico

-- 1. Verificar la construcción de la tabla
DESC tbc_areas_medicas; 

--  2. Procedimiento de poblacion de áreas médicas
DELIMITER $$
CREATE DEFINER=`america.estudillo`@`%` PROCEDURE `sp_poblar_areas_medicas`(IN v_password VARCHAR(50))
BEGIN
    DECLARE id_val INT;

    IF v_password = "xYz$123" THEN
        -- Realizar la inserción inicial
        INSERT INTO tbc_areas_medicas (Nombre, Descripcion, Estatus, Fecha_Registro, Fecha_Actualizacion)
        VALUES
        ('Servicios Medicos', 'Por definir', 'Activo', '2024-01-21 16:00:41', NOW()),
        ('Servicios de Apoyo', 'Por definir', 'Activo', '2024-01-21 16:06:31', NOW()),
        ('Servicios Medico - Administrativos', 'Por definir', 'Activo', '2024-01-21 16:06:31', NOW()),
        ('Servicios de Enfermeria', 'Por definir', 'Activo', '2024-01-21 16:06:31', NOW()),
        ('Departamentos Administrativos', 'Por definir', 'Activo', '2024-01-21 16:06:31', NOW()),
        ('Nueva Área Médica', 'Por definir', 'Activo', '2024-06-18 12:00:00', NOW()); -- Inserción de la nueva área médica

        -- Obtener el último ID insertado
        SET id_val = LAST_INSERT_ID();

        -- Mostrar los datos insertados
        SELECT * FROM tbc_areas_medicas;

        -- Actualizar el estado a 'Inactivo' para el registro 'Nueva Área Médica'
        UPDATE tbc_areas_medicas
        SET Estatus = 'Inactivo'
        WHERE Nombre = 'Nueva Área Médica';

        -- Mostrar los datos actualizados
        SELECT * FROM tbc_areas_medicas;

        -- Eliminar el registro 'Nueva Área Médica'
        DELETE FROM tbc_areas_medicas
        WHERE Nombre = 'Nueva Área Médica';

        -- Mostrar los datos después de la eliminación
        SELECT * FROM tbc_areas_medicas;

    ELSE
        -- Mostrar mensaje de error si la contraseña es incorrecta
        SELECT 'Contraseña incorrecta' AS ErrorMessage;
    END IF;
END
$$
DELIMITER ;

-- 3. Poblar de manera estática la tabla.
CALL sp_poblar_areas_medicas("xYz$123");

SELECT * FROM tbc_areas_medicas; 
-- 4. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbc_areas_medicas" ORDER BY ID DESC;

