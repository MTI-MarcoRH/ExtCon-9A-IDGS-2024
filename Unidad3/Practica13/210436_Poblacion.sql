-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Diego Oliver Basilio
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Queries para revisión  y población de la tabla: tbd_horarios
-- 1. Verificar la construcción de la tabla
DESC tbd_horarios; 

--2. Procedimiento almacenado para la poblacion de tbd_horarios:
DELIMITER ;;

CREATE DEFINER=`DiegoOliver`@`%` PROCEDURE `sp_poblar_horarios`(v_password VARCHAR(20))
BEGIN
    IF v_password = '1234' THEN
        -- Persona 1
        INSERT INTO `tbd_horarios` 
        (empleado_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, nombre_departamento, nombre_sala, fecha_creacion, fecha_actualizacion)
        VALUES 
            (1, 'Doctor A', 'Cardiología', 'Martes', '09:00:00', '17:00:00', 'Matutino', 'Departamento 1', 'Sala 1', '2024-07-01 10:00:00', '2024-07-01 10:00:00'),
        -- Persona 2
        INSERT INTO `tbd_horarios` 
        (empleado_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, nombre_departamento, nombre_sala, fecha_creacion, fecha_actualizacion)
        VALUES 
            (2, 'Doctor B', 'Neurología', 'Miércoles', '10:00:00', '18:00:00', 'Vespertino', 'Departamento 2', 'Sala 2', '2024-07-02 11:00:00', '2024-07-02 11:00:00'),
        -- Persona 3
        INSERT INTO `tbd_horarios` 
        (empleado_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, nombre_departamento, nombre_sala, fecha_creacion, fecha_actualizacion)
        VALUES 
            (3, 'Doctor C', 'Pediatría', 'Jueves', '11:00:00', '19:00:00', 'Nocturno', 'Departamento 3', 'Sala 3', '2024-07-03 12:00:00', '2024-07-03 12:00:00'),
        -- Persona 4
        INSERT INTO `tbd_horarios` 
        (empleado_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, nombre_departamento, nombre_sala, fecha_creacion, fecha_actualizacion)
        VALUES 
            (4, 'Doctor D', 'Oncología', 'Viernes', '08:00:00', '16:00:00', 'Matutino', 'Departamento 4', 'Sala 4', '2024-07-04 09:00:00', '2024-07-04 09:00:00');
    END IF;
END ;;

DELIMITER ;

-- 3. Poblar de manera estática la tabla.
CALL sp_poblar_horarios("1234");

SELECT * FROM tbd_hoarios; 
-- 4. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbd_horarios" ORDER BY ID DESC;

-- 4. Realizamos una consulta joing para visualizar los datos poblados. 
SELECT 
    h.empleado_id, 
    CONCAT_WS(' ', NULLIF(p.titulo, ''), p.nombre, p.primer_apellido, p.segundo_apellido) AS NombreCompleto,
    pm.Especialidad, 
    h.dia_semana, 
    h.hora_inicio, 
    h.hora_fin, 
    h.turno, 
    d.nombre AS NombreDepartamento
FROM 
    tbd_horarios h
JOIN 
    tbb_personas p ON h.empleado_id = p.id
JOIN 
    tbb_personal_medico pm ON p.id = pm.persona_id
JOIN 
    tbc_departamentos d ON pm.departamento_id = d.id;
