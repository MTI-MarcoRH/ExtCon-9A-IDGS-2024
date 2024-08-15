DELIMITER ;;

CREATE DEFINER=`DiegoOliver`@`localhost` PROCEDURE `sp_poblar_horarios_dinamico`(v_password VARCHAR(20), IN v_especialidad VARCHAR(50))
BEGIN
    IF v_password = '1234' THEN
        SET @sql = CONCAT('INSERT INTO tbd_horarios (empleado_id, nombre, especialidad, dia_semana, hora_inicio, hora_fin, turno, nombre_departamento, nombre_sala, fecha_creacion, fecha_actualizacion) VALUES ');
        
      
        
        SET @sql = CONCAT(@sql, '(1, \'Doctor A\', \'Cardiología\', \'Martes\', \'09:00:00\', \'17:00:00\', \'Matutino\', \'Departamento 1\', \'Sala 1\', \'2024-07-01 10:00:00\', \'2024-07-01 10:00:00\');');
        
     
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Contraseña incorrecta';
    END IF;
END ;;

DELIMITER ;
