-- Script de creacion de poblacion dinamica para la tabla de tbd_dispensaciones


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 02 de agosto de 2024 


-- 1 limpiar bd
call sp_limpiar_bd("xYz$123");

-- 2 estatus BD
call sp_estatus_bd("xYz$123");

-- 3 personal medico (Estatica)
call sp_poblar_personal_medico("xyz#$%");

-- 4 receta medica (Dinamico)
call sp_poblar_recetas("141002");

-- 5 solicitudes (Dinamico)
call sp_poblar_solicitudes("xYz$123");

-- 6 Dispensaciones(Dinamico)
call sp_poblar_dispensacion_dinamica("xYz$123", 10);


-- 7 Join de recetas con dispensacion
SELECT 
    d.ID AS DispensaID,
    r.paciente_nombre AS PacienteNombre,
    r.medicamentos AS Medicamento,
    CONCAT(p.Titulo, ' ', p.Nombre, ' ', p.Primer_Apellido, ' ', p.Segundo_Apellido) AS MedicoNombre,
    d.TotalMedicamentosEntregados AS CantidadEntregada,
    d.Total_costo AS TotalCosto,
    d.Estatus,
    d.Tipo
FROM 
    tbd_dispensaciones d
JOIN 
    tbd_recetas_medicas r ON d.RecetaMedica_id = r.id
JOIN 
    tbb_personal_medico pm ON d.PersonalMedico_id = pm.Persona_ID
JOIN 
    tbb_personas p ON pm.Persona_ID = p.ID
WHERE 
    d.RecetaMedica_id IS NOT NULL;

-- 8 Poblacion dinamica de dispensacion



CREATE DEFINER=`Cristian.Ojeda`@`%` PROCEDURE `sp_poblar_dispensacion_dinamica`(
    IN v_password VARCHAR(20), 
    IN cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE receta_id INT;
    DECLARE solicitud_id INT;
    DECLARE personal_medico_id INT;
    DECLARE max_receta_id INT;
    DECLARE max_solicitud_id INT;
    DECLARE max_personal_medico_id INT;

    IF v_password = 'xYz$123' THEN
        -- Obtener el máximo ID de cada tabla
        SELECT MAX(id) INTO max_receta_id FROM tbd_recetas_medicas;
        SELECT MAX(ID) INTO max_solicitud_id FROM tbd_solicitudes;

        -- Bucle para insertar la cantidad de registros especificada
        WHILE i < cantidad DO
            -- Generar aleatoriamente si se asigna un RecetaMedica_id o un Solicitud_id
            IF fn_numero_aleatorio_dispensaciones(2) = 1 THEN
                SET receta_id = FLOOR(1 + RAND() * max_receta_id); -- Genera un RecetaMedica_id válido
                SET solicitud_id = NULL;
            ELSE
                SET receta_id = NULL;
                SET solicitud_id = FLOOR(1 + RAND() * max_solicitud_id); -- Genera un Solicitud_id válido
            END IF;
		

            -- Insertar el registro con los valores generados
            INSERT INTO tbd_dispensaciones 
                (RecetaMedica_id, PersonalMedico_id, Solicitud_id, Estatus, Tipo, TotalMedicamentosEntregados, Total_costo,Fecha_registro)
            VALUES 
                (receta_id, 
                 fn_numero_aleatorio_dispensaciones(3), 
                 solicitud_id, 
                 fn_numero_aleatorio_dispensaciones(2), 
                 fn_numero_aleatorio_dispensaciones(3), 
                 fn_numero_aleatorio_dispensaciones(20), 
                 fn_numero_aleatorio_decimales_dispensaciones(1000.00),
                 fn_fecha_aleatoria_dispensacion());

            SET i = i + 1;
        END WHILE;
		-- Actualizar un registro específico
        UPDATE tbd_dispensaciones
        SET Estatus = 'Parcialmente abastecida', 
            Tipo = 'Mixta', 
            TotalMedicamentosEntregados = 20, 
            Total_costo = 200.00
        WHERE ID = 1;

        -- Eliminar un registro específico
        DELETE FROM tbd_dispensaciones 
        WHERE ID = 2;
    ELSE
        SELECT 'La contraseña es incorrecta' AS ErrorMessage;
    END IF;
END