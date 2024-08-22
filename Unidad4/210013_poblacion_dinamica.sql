
-- Elaborado por : Alexis Gomez Gaona

-- 1 limpiar bd
call sp_limpiar_bd("xYz$123");

-- 2 estatus BD
call sp_estatus_bd("xYz$123");

-- 3 servicios_medicos("1234");
CALL sp_poblar_servicios_medicos("1234");

-- 4 CALL departamentos_servicios
CALL sp_poblar_departamentos_servicios("1234","1");




CREATE DEFINER=`alexis.gomez`@`%` PROCEDURE `sp_poblar_departamentos_servicios`(
    IN v_password VARCHAR(20), 
    IN cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE max_departamento_id INT;
    DECLARE max_servicio_id INT;

    IF v_password = '1234' THEN
        -- Obtener el máximo ID de las tablas de Departamentos y Servicios
        SELECT IFNULL(MAX(Departamento_ID), 0) INTO max_departamento_id FROM tbd_departamentos_servicios;
        SELECT IFNULL(MAX(ID), 0) INTO max_servicio_id FROM tbc_servicios_medicos;

        -- Asegurarse de que los máximos no sean cero
        IF max_departamento_id = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se encontraron registros válidos en tbd_departamentos_servicios';
        END IF;

        IF max_servicio_id = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se encontraron registros válidos en tbc_servicios_medicos';
        END IF;

        -- Bucle para insertar la cantidad de registros especificada
        WHILE i < cantidad DO
            -- Insertar el registro con valores generados aleatoriamente
            INSERT INTO tbd_departamentos_servicios (
                Departamento_ID, Servicio_ID, Requisitos, Restricciones, Estatus, Fecha_Registro
            ) VALUES (
                FLOOR(1 + RAND() * max_departamento_id), -- Genera un Departamento_ID válido
                FLOOR(1 + RAND() * max_servicio_id),     -- Genera un ID válido de tbc_servicios_medicos
                CONCAT('Requisito ', FLOOR(1 + RAND() * 100)), -- Genera un texto de requisito aleatorio
                CONCAT('Restricción ', FLOOR(1 + RAND() * 100)), -- Genera un texto de restricción aleatorio
                b'1', -- Estatus
                fn_fecha_aleatoria_departamentos_servicios() -- Fecha aleatoria
            );

            SET i = i + 1;
        END WHILE;
    ELSE
        SELECT 'La contraseña es incorrecta' AS ErrorMessage;
    END IF;
END
