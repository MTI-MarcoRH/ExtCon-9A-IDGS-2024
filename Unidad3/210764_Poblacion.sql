-- Script de poblar de la tabla tbc_organos

-- Elaborado por : Karen Alyn Fosado Rodriguez
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 22 de julio de 2024 

CREATE DEFINER=`Alyn.Fosado`@`%` PROCEDURE `sp_poblar_organos`(
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE v_correct_password VARCHAR(255) DEFAULT 'xYz$123';
    
    -- Verificamos la contraseña
    IF p_password = v_correct_password THEN
        
        -- Inserción de registros de prueba variados
        INSERT INTO tbc_organos (
            Nombre, Aparato_Sistema, Detalles_Adicionales, Disponibilidad, Tipo, 
            Fecha_Extraccion, Edad_Donante, Grupo_Sanguineo, Estado_Salud, 
            Enfermedades_Transmisibles, Fecha_Registro, Estatus
        ) VALUES 
            ('Cerebro', 'Nervioso', 'Órgano principal del sistema nervioso.', 'Disponible', 'Vital', 
             '2024-08-01 10:30:00', 35, 'O+', 'Excelente', 1, CURRENT_TIMESTAMP(), b'1'),
             
            ('Corazón', 'Circulatorio', 'Órgano muscular que bombea sangre a través del sistema circulatorio.', 'Disponible', 'Vital', 
             '2024-07-20 14:15:00', 45, 'A+', 'Bueno', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Pulmón', 'Respiratorio', 'Órgano que permite la oxigenación de la sangre.', 'Disponible', 'Vital', 
             '2024-06-10 09:00:00', 30, 'B+', 'Regular', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Hígado', 'Digestivo', 'Órgano que procesa nutrientes y desintoxica sustancias.', 'Reservado', 'Vital', 
             '2024-08-05 11:45:00', 50, 'AB+', 'Bueno', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Riñón', 'Urinario', 'Órgano que filtra desechos de la sangre y produce orina.', 'No Disponible', 'Vital', 
             '2024-08-15 08:00:00', 40, 'O-', 'Excelente', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Músculo Biceps', 'Muscular', 'Músculo del brazo que permite la flexión.', 'Disponible', 'No Vital', 
             '2024-07-01 12:30:00', 28, 'A-', 'Bueno', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Hueso Fémur', 'Esquelético', 'Hueso largo del muslo.', 'Disponible', 'No Vital', 
             '2024-06-25 15:00:00', 22, 'B-', 'Regular', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Glándula Tiroides', 'Endocrino', 'Glándula que regula el metabolismo.', 'Reservado', 'No Vital', 
             '2024-07-30 13:45:00', 55, 'AB-', 'Bueno', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Bazo', 'Linfático', 'Órgano que filtra la sangre y participa en la respuesta inmunitaria.', 'Disponible', 'No Vital', 
             '2024-08-10 07:30:00', 60, 'O+', 'Pobre', 0, CURRENT_TIMESTAMP(), b'1'),
             
            ('Ojo', 'Sensorial', 'Órgano de la visión.', 'Disponible', 'Vital', 
             '2024-08-18 16:00:00', 20, 'A+', 'Excelente', 0, CURRENT_TIMESTAMP(), b'1');
             
    ELSE
        -- Si la contraseña no es correcta, lanzamos un error
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Contraseña incorrecta';
    END IF;
END