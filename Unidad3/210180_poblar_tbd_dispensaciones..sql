-- Script de poblar de la tabla tbd_dispensaciones 


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 21 de julio de 2024 

CREATE DEFINER=`Cristian.Ojeda`@`%` PROCEDURE `sp_poblar_dispensacion`(IN v_password VARCHAR(20))
BEGIN
    IF v_password = 'xYz$123' THEN
        -- Insertar cinco registros predefinidos con RecetaMedica_id o Solicitud_id, pero no ambos
        INSERT INTO tbd_dispensaciones 
            (RecetaMedica_id, PersonalMedico_id, Solicitud_id, Estatus, Tipo, TotalMedicamentosEntregados, Total_costo)
        VALUES 
            (2, 2, NULL, 'Abastecida', 'Pública', 10, 100.00),  -- Verifica que RecetaMedica_id = 2 y PersonalMedico_id = 2 existan
            (NULL, 3, 4, 'Parcialmente abastecida', 'Privada', 5, 50.00 ),  -- Verifica que PersonalMedico_id = 3 y Solicitud_id = 4 existan
            (3, 1, NULL, 'Abastecida', 'Mixta', 15, 150.00 ),  -- Verifica que RecetaMedica_id = 3 y PersonalMedico_id = 1 existan
            (NULL, 1, 2, 'Parcialmente abastecida', 'Pública', 8, 80.00),  -- Verifica que PersonalMedico_id = 1 y Solicitud_id = 2 existan
            (5, 2, NULL, 'Abastecida', 'Privada', 12, 120.00);  -- Verifica que RecetaMedica_id = 5 y PersonalMedico_id = 2 existan
    
        -- Actualizar un registro específico predefinido
        UPDATE tbd_dispensaciones
        SET Estatus = 'Parcialmente abastecida', 
            Tipo = 'Mixta', 
            TotalMedicamentosEntregados = 20, 
            Total_costo = 200.00
        WHERE ID = 1;  -- Asegúrate de que el ID = 1 existe en la tabla tbd_dispensaciones

        -- Eliminar un registro específico predefinido
        DELETE FROM tbd_dispensaciones 
        WHERE ID = 2;  -- Asegúrate de que el ID = 2 existe en la tabla tbd_dispensaciones
    
    ELSE
        SELECT 'La contraseña es incorrecta' AS ErrorMessage;
    END IF;
END