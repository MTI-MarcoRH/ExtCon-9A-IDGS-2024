-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Juan Manuel Cruz Ortiz
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Queries para revisión  y población de la tabla: Estudios

-- 1. Verificar la construcción de la tabla
DESC tbc_estudios;
-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_estudios("xyz#$%");

SELECT * FROM tbc_estudios;
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbc_estudios" ORDER BY ID DESC;

-- 4. Realizamos una consulta joing para visualizar los datos poblados.




CREATE DEFINER=`Juan.cruz`@`%` PROCEDURE `sp_poblar_estudios`(v_password VARCHAR(60))
BEGIN
	IF v_password="123" THEN
        -- Insertar datos en la tabla tbc_estudios
        INSERT INTO tbc_estudios (
            Tipo,
            Nivel_Urgencia,
            SolicitudID,
            ConsumiblesID,
            Estatus,
            Total_Costo,
            Dirigido_A,
            Observaciones,
            Fecha_Registro,
            Fecha_Actualizacion,
            ConsumibleID
        ) VALUES (
            'MRI',
            'Alta',
            23,
            12,
            'Completado',
            500.00,
            'Dr. Juan Pérez',
            'Resultados del primer estudio',
            CURRENT_TIMESTAMP,
            CURRENT_TIMESTAMP,
            2
        );
        
        INSERT INTO tbc_estudios (
            Tipo,
            Nivel_Urgencia,
            SolicitudID,
            ConsumiblesID,
            Estatus,
            Total_Costo,
            Dirigido_A,
            Observaciones,
            Fecha_Registro,
            Fecha_Actualizacion,
            ConsumibleID
        ) VALUES (
            'Ultrasonido',
            'Media',
            11,
            11,
            'Completado',
            300.00,
            'Dr. Ana Gómez',
            'Resultados del segundo estudio',
            CURRENT_TIMESTAMP,
            CURRENT_TIMESTAMP,
            11
        );

        -- Actualizar datos en la tabla tbc_estudios
        UPDATE tbc_estudios 
        SET 
            Tipo = 'Ecografía',
            Nivel_Urgencia = 'Baja',
            SolicitudID = 12,
            ConsumiblesID = 459,
            Estatus = 'Completado',
            Total_Costo = 180.00,
            Dirigido_A = 'Dr. Laura Martínez',
            Observaciones = 'Sin observaciones',
            Fecha_Actualizacion = CURRENT_TIMESTAMP,
            ConsumibleID = 793
        WHERE 
            ID = 1;

        -- Eliminar datos de la tabla tbc_estudios
        DELETE FROM tbc_estudios 
        WHERE ID = 1;

    ELSE 
        SELECT "La contraseña es incorrecta, no se puede realizar modificación en la tabla Resultados Estudios" AS ErrorMessage;
    END IF;
END