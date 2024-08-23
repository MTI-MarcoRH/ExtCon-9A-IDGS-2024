CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_poblar_horarios`()
BEGIN
    -- Registro 1
    INSERT INTO `tbd_horarios` 
    (espacio_id, servicio_medico_id, departamento_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, tipo_horario, fecha_creacion, fecha_actualizacion)
    VALUES 
        (1, 1, 1, 'Justin Martin', 'Cardiología', 'Martes', '09:00:00', '17:00:00', 'Matutino', 'Diario', NOW(), NOW()),
        -- Registro 2
        (2, 2, 2, 'Arturo Aguilar', 'Neurología', 'Miércoles', '10:00:00', '18:00:00', 'Vespertino', 'Semanal', NOW(), NOW()),
        -- Registro 3
        (1, 1, 1, 'Marvin Yair', 'Pediatría', 'Jueves', '11:00:00', '19:00:00', 'Nocturno', 'Quincenal', NOW(), NOW()),
        -- Registro 4
        (4, 4, 4, 'Miriam Cortez', 'Oncología', 'Viernes', '08:00:00', '16:00:00', 'Matutino', 'Mensual', NOW(), NOW());
END