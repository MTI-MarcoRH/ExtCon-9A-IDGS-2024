CREATE PROCEDURE sp_poblar_horarios_dinamicamente()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE k INT DEFAULT 1;
    DECLARE espacios INT DEFAULT 4;
    DECLARE servicios INT DEFAULT 4;
    DECLARE departamentos INT DEFAULT 4;

    WHILE i <= espacios DO
        WHILE j <= servicios DO
            WHILE k <= departamentos DO
                INSERT INTO tbd_horarios 
                (espacio_id, servicio_medico_id, departamento_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, tipo_horario, fecha_creacion, fecha_actualizacion)
                VALUES 
                    (i, j, k, 
                     CONCAT('Doctor ', i), 
                     CONCAT('Especialidad ', j), 
                     DAYNAME(CURDATE()), 
                     '09:00:00', '17:00:00', 
                     'Matutino', 
                     'Diario', 
                     NOW(), NOW());

                SET k = k + 1;
            END WHILE;
            
            SET k = 1;  -- Reiniciar k para el siguiente loop de j
            SET j = j + 1;
        END WHILE;

        SET j = 1;  -- Reiniciar j para el siguiente loop de i
        SET i = i + 1;
    END WHILE;
END