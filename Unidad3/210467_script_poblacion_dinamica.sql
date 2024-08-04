CREATE DEFINER=`myriam.valderrabano`@`%` PROCEDURE `sp_poblar_lotes_medicamentos_dinamico`(v_password VARCHAR(20), v_num_inserciones INT)
BEGIN
DECLARE max_medicamento_id INT;
        DECLARE max_personal_medico_id INT;
        DECLARE i INT DEFAULT 0;
    IF v_password = "xYz$123" THEN
        

        -- Obtener el último ID de tbc_medicamentos
        SELECT MAX(ID) INTO max_medicamento_id FROM tbc_medicamentos;

        -- Obtener el último ID de tbb_personal_medico
        SELECT MAX(Persona_ID) INTO max_personal_medico_id FROM tbb_personal_medico;

        -- Bucle para insertar registros
        WHILE i < v_num_inserciones DO
            INSERT INTO tbd_lotes_medicamentos (Medicamento_ID, Personal_Medico_ID, Clave, Estatus, Costo_Total, Cantidad, Ubicacion, Fecha_Registro)
            VALUES
            (fn_numero_aleatorio(max_medicamento_id), fn_numero_aleatorio(max_personal_medico_id), fn_generar_clave(), 'Recibido', fn_generar_costo(1000.00), fn_numero_aleatorio(50), fn_ubicacion_aleatoria(), fn_fecha_aleatoria());

            SET i = i + 1;
        END WHILE;

        -- Actualización 1
        UPDATE tbd_lotes_medicamentos 
        SET Estatus = 'Rechazado', Ubicacion = 'Almacén W' 
        WHERE ID = 2;

        -- Actualización 2
        UPDATE tbd_lotes_medicamentos 
        SET Estatus = 'Reservado', Cantidad = 15 
        WHERE ID = 3;

       

    ELSE
        SELECT "La contraseña es incorrecta, no puedo mostrarte el estatus de llenado de la Base de datos" AS ErrorMessage;
    END IF;
END