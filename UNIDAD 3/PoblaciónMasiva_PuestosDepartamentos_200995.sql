DELIMITER $$

CREATE DEFINER=`jesus.rios`@`%` PROCEDURE `sp_poblar_puestos_departamentos`(
    IN v_password VARCHAR(20),
    IN v_cantidad INT
)
BEGIN
    IF v_password = 'xYz$123' THEN
        DECLARE v_puesto_id INT;
        DECLARE v_departamento_id INT;
        DECLARE v_nombre VARCHAR(255);
        DECLARE v_descripcion VARCHAR(255);
        DECLARE v_salario DECIMAL(10,2);
        DECLARE v_turno ENUM('Mañana', 'Tarde', 'Noche');

        -- Obtener IDs máximos para generar aleatorios
        SELECT MAX(PuestoID) INTO v_puesto_id FROM tbc_puestos;
        SELECT MAX(DepartamentoID) INTO v_departamento_id FROM tbc_departamentos;

        WHILE v_cantidad > 0 DO
            -- Generar datos aleatorios
            SET v_puesto_id = FLOOR(1 + (RAND() * (v_puesto_id - 1)));
            SET v_departamento_id = FLOOR(1 + (RAND() * (v_departamento_id - 1)));
            SET v_salario = FLOOR(30000 + (RAND() * 40000));
            SET v_turno = ELT(FLOOR(1 + RAND() * 3), 'Mañana', 'Tarde', 'Noche');

            -- Obtener nombres y descripciones del puesto
            SELECT Nombre, Descripcion INTO v_nombre, v_descripcion FROM tbc_puestos WHERE PuestoID = v_puesto_id;

            -- Insertar el registro en tbd_puestos_departamentos
            INSERT INTO tbd_puestos_departamentos (Nombre, Descripcion, Salario, Turno, DepartamentoID)
            VALUES (v_nombre, v_descripcion, v_salario, v_turno, v_departamento_id);

            -- Decrementar la cantidad
            SET v_cantidad = v_cantidad - 1;
        END WHILE;
    ELSE
        SELECT 'La contraseña es incorrecta' AS Mensaje;
    END IF;
END$$

DELIMITER ;