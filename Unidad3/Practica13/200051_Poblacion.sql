-- SCRIPT DE POBLACION

-- Elaborado por: Daniela Aguilar Torres
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024


CREATE DEFINER=`daniela.aguilar`@`%` PROCEDURE `sp_poblar_consumibles`(IN v_password VARCHAR(20))
BEGIN
    DECLARE v_estatus ENUM('Activo', 'Inactivo', 'En Revisión') DEFAULT 'Activo';

    IF v_password = 'xYz$123' THEN
        -- Insertar en la tabla tbc_consumibles
        INSERT INTO tbc_consumibles 
        (Nombre, Descripcion, Tipo, Departamento_ID, Cantidad, Estatus, Fecha_Registro, Fecha_Actualizacion, Observaciones, Espacio_Medico) 
        VALUES 
        ('Guantes', 'Guantes latex', 'Protección', 10, 500, 'Activo', NOW(), NOW(), 'Revisar antes de entrar', 'Emergencias'),
        ('Gasas', 'Gasas estériles', 'Material Médico', 10, 1000, 'Activo', NOW(), NOW(), 'Mantener en ambiente seco', 'Urgencias'),
        ('Jeringas', 'Jeringas desechables', 'Material Médico', 10, 800, 'Activo', NOW(), NOW(), 'Manipular con cuidado', 'Consultas Externas'),
        ('Vendas', 'Vendas elásticas', 'Material Médico', 10, 1200, 'Activo', NOW(), NOW(), 'Utilizar para vendajes compresivos', 'Emergencias'),
        ('Analgésico', 'Medicamento', 'Farmacia', 51, 500, 'Activo', NOW(), NOW(), 'Mantener en lugar fresco y seco', 'Consultas Externas');

        -- Actualizar un registro en la tabla tbc_consumibles
        UPDATE tbc_consumibles 
        SET Cantidad = 600, Fecha_Actualizacion = NOW() 
        WHERE Nombre = 'Guantes';

        -- Eliminar un registro en la tabla tbc_consumibles
        DELETE FROM tbc_consumibles 
        WHERE Nombre = 'Analgésico';

    ELSE
        -- Mensaje de error en caso de contraseña incorrecta
        SELECT 'La contraseña es incorrecta' AS ErrorMessage;
    END IF;
END
