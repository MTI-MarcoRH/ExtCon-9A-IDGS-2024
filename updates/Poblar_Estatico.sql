DELIMITER ;;

CREATE PROCEDURE `sp_poblar_horarios`()
BEGIN
    -- Registro 1
    INSERT INTO `tbd_horarios` 
    (espacio_id, servicio_medico_id, departamento_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, tipo_horario, fecha_creacion, fecha_actualizacion)
    VALUES 
        (1, 1, 1, 'Doctor A', 'Cardiología', 'Martes', '09:00:00', '17:00:00', 'Matutino', 'Diario', NOW(), NOW()),
        -- Registro 2
        (2, 2, 2, 'Doctor B', 'Neurología', 'Miércoles', '10:00:00', '18:00:00', 'Vespertino', 'Semanal', NOW(), NOW()),
        -- Registro 3
        (3, 3, 3, 'Doctor C', 'Pediatría', 'Jueves', '11:00:00', '19:00:00', 'Nocturno', 'Quincenal', NOW(), NOW()),
        -- Registro 4
        (4, 4, 4, 'Doctor D', 'Oncología', 'Viernes', '08:00:00', '16:00:00', 'Matutino', 'Mensual', NOW(), NOW());
END ;;

DELIMITER ;
