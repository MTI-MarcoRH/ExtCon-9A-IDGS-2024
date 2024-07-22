-- SCRIPT DEL PROCEDIMIENTO DE LA TABLA 'tbd_lotes_medicamentos'

-- ELABORADO POR: MYRIAM VALDERRABANO CORTES
-- GRADO Y GRUPO: 9°
-- PROGRAMA EDUCATIVO: INGENIERÍA EN DESARROLLO Y GESTIÓN DE SOFTWARE
-- FECHA DE ELABORACIÓN: 21 DE JULIO DE 2024


CREATE DEFINER=`myriam.valderrabano`@`%` PROCEDURE `sp_poblar_lotes_medicamentos`(v_password VARCHAR(20))
BEGIN
	IF v_password = "xYz$123" THEN
        -- Insertar registros en la tabla tbd_lotes_medicamentos
        INSERT INTO tbd_lotes_medicamentos (Medicamento_ID, Personal_Medico_ID, Clave, Estatus, Costo_Total, Cantidad, Ubicacion)
        VALUES
        (1, 3, 'ABC123', 'Reservado', 100.00, 10, 'Almacen A'),
        (3, 3, 'DEF456', 'En transito', 200.00, 20, 'Almacen B'),
        (4, 3, 'GHI789', 'Recibido', 300.00, 30, 'Almacen C');

        -- Actualización 1
        UPDATE tbd_lotes_medicamentos 
        SET Estatus = 'Rechazado', Ubicacion = 'Almacén W' 
        WHERE ID = 2;

        -- Actualización 2
        UPDATE tbd_lotes_medicamentos 
        SET Estatus = 'Reservado', Cantidad = 15 
        WHERE ID = 3;

        -- Eliminación
        DELETE FROM tbd_lotes_medicamentos 
        WHERE ID = 3;

    ELSE
        SELECT "La contraseña es incorrecta, no puedo mostrarte el estatus de llenado de la Base de datos" AS ErrorMessage;
    END IF;
END