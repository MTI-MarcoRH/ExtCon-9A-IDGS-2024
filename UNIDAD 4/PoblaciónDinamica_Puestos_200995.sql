DELIMITER $$

CREATE DEFINER=`jesus.rios`@`%` PROCEDURE `sp_poblar_puestos`(
    IN v_password VARCHAR(20),
    IN v_cantidad INT
)
BEGIN
    IF v_password = 'xYz$123' THEN
        DECLARE v_nombre VARCHAR(255);
        DECLARE v_descripcion VARCHAR(255);
        DECLARE v_salario DECIMAL(10,2);

        -- Listas de nombres y descripciones para generar aleatoriamente
        DECLARE nombres_cursor CURSOR FOR SELECT Nombre FROM tbc_puestos;
        DECLARE descr_cursor CURSOR FOR SELECT Descripcion FROM tbc_puestos;

        -- Abrir cursores
        OPEN nombres_cursor;
        OPEN descr_cursor;

        WHILE v_cantidad > 0 DO
            -- Generar salario aleatorio entre 30000 y 70000
            SET v_salario = FLOOR(30000 + (RAND() * 40000));

            -- Avanzar cursores
            FETCH nombres_cursor INTO v_nombre;
            FETCH descr_cursor INTO v_descripcion;

            -- Insertar el registro aleatorio en tbc_puestos
            INSERT INTO tbc_puestos (Nombre, Descripcion, Salario)
            VALUES (v_nombre, v_descripcion, v_salario);

            -- Decrementar la cantidad
            SET v_cantidad = v_cantidad - 1;

            -- Volver al inicio de los cursores si se agotaron
            IF v_cantidad > 0 THEN
                FETCH nombres_cursor INTO v_nombre;
                FETCH descr_cursor INTO v_descripcion;
            ELSE
                CLOSE nombres_cursor;
                CLOSE descr_cursor;
                OPEN nombres_cursor;
                OPEN descr_cursor;
            END IF;
        END WHILE;

        -- Cerrar cursores
        CLOSE nombres_cursor;
        CLOSE descr_cursor;
    ELSE
        SELECT 'La contraseÃ±a es incorrecta' AS Mensaje;
    END IF;
END$$

DELIMITER ;