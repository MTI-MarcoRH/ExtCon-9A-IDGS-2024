-- SCRIPT DE POBLACION

-- Elaborado por: Daniela Aguilar Torres
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024
-- Tabla de Consumibles TBC 
-- DATOS ESTATICOS 

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


-- TABLA DERIVADA TBD CIRUGIAS CONSUMIBLES ----------------------------------------------------------------------------------

CREATE DEFINER=`daniela.aguilar`@`%` PROCEDURE `sp_poblar_cirugia_consumibles`(
    IN p_accion ENUM('INSERTAR', 'ACTUALIZAR', 'ELIMINAR'),
    IN p_id INT,
    IN p_cirugia_id INT,
    IN p_consumible_id INT,
    IN p_cantidad_utilizada INT
)
BEGIN
    IF p_accion = 'INSERTAR' THEN
        INSERT INTO tbd_cirugia_consumibles (Cirugia_ID, Consumible_ID, Cantidad_Utilizada, Fecha_Registro)
        VALUES (p_cirugia_id, p_consumible_id, p_cantidad_utilizada, NOW());
    ELSEIF p_accion = 'ACTUALIZAR' THEN
        UPDATE tbd_cirugia_consumibles
        SET Cirugia_ID = p_cirugia_id,
            Consumible_ID = p_consumible_id,
            Cantidad_Utilizada = p_cantidad_utilizada,
            Fecha_Registro = NOW()
        WHERE ID = p_id;
    ELSEIF p_accion = 'ELIMINAR' THEN
        DELETE FROM tbd_cirugia_consumibles
        WHERE ID = p_id;
    END IF;
END
--------------------------------------------------------------------------------------------------------

-- Verificar Población para una Cirugía Específica
SELECT
    cc.ID,
    c.Nombre AS Nombre_Cirugia,
    co.Nombre AS Nombre_Consumible,
    cc.Cantidad_Utilizada,
    cc.Fecha_Registro
FROM
    tbd_cirugia_consumibles cc
JOIN
    tbb_cirugias c ON cc.Cirugia_ID = c.ID
JOIN
    tbc_consumibles co ON cc.Consumible_ID = co.ID
WHERE
    cc.Cirugia_ID = 1;

-- Verificar Todos los Consumibles Utilizados en Todas las Cirugías
SELECT
    co.Nombre AS Nombre_Consumible,
    SUM(cc.Cantidad_Utilizada) AS Cantidad_Total_Utilizada
FROM
    tbd_cirugia_consumibles cc
JOIN
    tbc_consumibles co ON cc.Consumible_ID = co.ID
GROUP BY
    co.Nombre;

---- REGISTROS RECIENTES 
SELECT
    cc.ID,
    c.Nombre AS Nombre_Cirugia,
    co.Nombre AS Nombre_Consumible,
    cc.Cantidad_Utilizada,
    cc.Fecha_Registro
FROM
    tbd_cirugia_consumibles cc
JOIN
    tbb_cirugias c ON cc.Cirugia_ID = c.ID
JOIN
    tbc_consumibles co ON cc.Consumible_ID = co.ID
ORDER BY
    cc.Fecha_Registro DESC;
