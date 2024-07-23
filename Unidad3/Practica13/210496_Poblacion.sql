-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Carlos Martin Hernández de Jesús
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- 1. Verificar la construcción de la tabla
DESC tbd_solicitudes;

-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_solicitudes('xYz$123');

SELECT * FROM tbd_solicitudes;
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbd_solicitudes" ORDER BY ID DESC;

-- 4. Realizamos una consulta joing para visualizar los datos poblados. 
SELECT s.ID AS Solicitud_ID,
CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido) AS "Nombre Del Paciente",
CONCAT_WS(" ", m.Nombre, m.Primer_Apellido, m.Segundo_Apellido) AS "Nombre Del Medico",
sv.nombre AS "Nombre Del Servicio", s.Prioridad, s.Descripcion, s.Estatus AS "Estatus"
FROM tbd_solicitudes s
LEFT JOIN  tbb_personas p ON s.Paciente_ID = p.id
LEFT JOIN  tbb_personas m ON s.Medico_ID = m.id
LEFT JOIN  tbc_servicios_medicos sv ON s.Servicio_ID = sv.id;



CREATE DEFINER=`Carlos.Hernandez`@`%` PROCEDURE `sp_poblar_solicitudes`(v_password VARCHAR(10))
BEGIN
    IF v_password = 'xYz$123' THEN
    
        INSERT INTO tbd_solicitudes (Paciente_ID, Medico_ID, Servicio_ID, Prioridad, Descripcion, Estatus, Estatus_Aprobacion, Fecha_Registro, Fecha_Actualizacion)
        VALUES 
        (5, 1, 1, 'Moderada', 'Revisión médica anual para monitorear mi salud general.', 'Registrada', b'1', DEFAULT, NULL),
        (6, 1, 2, 'Emergente', 'Tratamiento médico para mejorar mi bienestar.', 'Programada', b'1', DEFAULT, NULL),
        (6, 2, 2, 'Alta', 'Consulta especializada para manejar una condición específica.', 'Reprogramada', b'1', DEFAULT, NULL),
        (5, 3, 4, 'Normal', 'Revisión mensual para monitorear mi condición cardiaca.', 'En Proceso', b'1', DEFAULT, NULL),
        (8, 3, 5, 'Urgente', 'Revisión médica para ver mis niveles de salud.', 'Realizada', b'1', DEFAULT, NULL);

        -- Actualizar registros existentes
        UPDATE tbd_solicitudes SET Prioridad = 'Normal' WHERE ID = 1;
        UPDATE tbd_solicitudes SET Estatus = 'Cancelada' WHERE ID = 2;

        -- Eliminar un registro específico
        DELETE FROM tbd_solicitudes WHERE ID = 5;
    ELSE
        SELECT 'La contraseña es incorrecta, no puede mostrar el estatus de la Base de Datos' AS ErrorMessage;
    END IF;
END