
-- Script de creacion de poblacion dinamica para la tabla de tbb_citas_medicas


-- Elaborado por : Janeth Ahuacatitla Amixtlan 
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 05 de agosto de 2024 


CREATE DEFINER=`janeth.ahuacatitla`@`%` PROCEDURE `sp_poblar_citas_medicas`(v_num_inserciones INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    

    DECLARE v_tipo VARCHAR(20);
    DECLARE v_paciente_id INT;
    DECLARE v_personal_medico_id INT;
    DECLARE v_servicio_medico_id INT;
    DECLARE v_espacio_id INT;
    DECLARE v_fecha_programada DATETIME;
    DECLARE v_estatus VARCHAR(20);
    DECLARE v_observaciones VARCHAR(255);

    -- Inicialización del generador de datos aleatorios
    SET v_tipo = 'Revisión';
    SET v_paciente_id = 1;
    SET v_personal_medico_id = 1;
    SET v_servicio_medico_id = 1;
    SET v_espacio_id = 1;
    SET v_fecha_programada = '2024-08-05 09:00:00';
    SET v_estatus = 'Programada';
    SET v_observaciones = 'Sin Observaciones';


    WHILE i <= v_num_inserciones DO
        
        SET v_tipo = CASE 
                        WHEN i % 3 = 1 THEN 'Revisión'
                        WHEN i % 3 = 2 THEN 'Diagnóstico'
                        ELSE 'Seguimiento'
                     END;
        SET v_paciente_id = (i % 10) + 1;  
        SET v_personal_medico_id = (i % 5) + 1;  
        SET v_servicio_medico_id = (i % 5) + 1;  
        SET v_espacio_id = (i % 5) + 1;  
        SET v_fecha_programada = DATE_ADD('2024-08-05 09:00:00', INTERVAL i HOUR);  
        SET v_estatus = CASE 
                            WHEN i % 4 = 0 THEN 'Programada'
                            WHEN i % 4 = 1 THEN 'En proceso'
                            WHEN i % 4 = 2 THEN 'Atendida'
                            ELSE 'Cancelada'
                        END;
        SET v_observaciones = CONCAT('Observaciones ', i);

        -- Inserción en la tabla
        INSERT INTO tbb_citas_medicas (
            Tipo, Paciente_ID, Personal_medico_ID, Servicio_Medico_ID,
            Espacio_ID, Fecha_Programada, Estatus, Observaciones
        )
        VALUES (
            v_tipo, v_paciente_id, v_personal_medico_id, v_servicio_medico_id,
            v_espacio_id, v_fecha_programada, v_estatus, v_observaciones
        );

        SET i = i + 1;
    END WHILE;
    

    UPDATE tbb_citas_medicas 
    SET Fecha_Programada = '2024-08-30 09:30:00', Estatus = 'Reprogramada' 
    WHERE ID = 1;

    DELETE FROM tbb_citas_medicas WHERE ID = 4;

END