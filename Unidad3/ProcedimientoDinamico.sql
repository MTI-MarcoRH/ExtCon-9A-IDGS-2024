CREATE DEFINER=`marvin.tolentino`@`localhost` PROCEDURE `sp_poblar_recetas`(v_password varchar(20))
BEGIN
    IF v_password = "141002" THEN
        SET SQL_SAFE_UPDATES = 0;


        /*Borrar datos de la tabla */    
        DELETE FROM tbd_recetas_medicas;
        /*resetear el auto increment para que inicie desde 1*/
        ALTER TABLE tbd_recetas_medicas AUTO_INCREMENT = 1;
        
        INSERT INTO tbd_recetas_medicas 
        (paciente_nombre, paciente_edad, sexo, medico_nombre, fecha, fecha_actualizacion, diagnostico, medicamentos, indicaciones, id_paciente, id_medico) 
        VALUES 
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 10),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 10),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 10),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 19),
            '2024-06-06', NULL, 'Gripe común', 'Paracetamol, Ibuprofeno', 
            'Tomar una tableta de Paracetamol cada 6 horas y una tableta de Ibuprofeno cada 8 horas durante 3 días.', 
            10, 19
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 11),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 11),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 11),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 20),
            '2024-05-04', NULL, 'Hipertensión arterial', 'Losartán, Amlodipino', 
            'Tomar una tableta de Losartán y una tableta de Amlodipino diariamente antes del desayuno.', 
            11, 20
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 13),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 13),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 13),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 19),
            '2024-06-05', NULL, 'Hipertensión arterial', 'Losartán, Amlodipino', 
            'Tomar una tableta de Losartán y una tableta de Amlodipino diariamente antes del desayuno.', 
            13, 19
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 14),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 14),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 14),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 20),
            '2024-06-05', NULL, 'Sindrome de Dawn', 'Ibuprofeno, Aspirinas', 
            'Tomar una tableta de aspirina y una tableta de ibuprofeno antes de dormir', 
            14, 20
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 15),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 15),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 15),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 20),
            '2024-06-10', NULL, 'Infección de garganta', 'Amoxicilina, Ibuprofeno', 
            'Tomar una tableta de Amoxicilina cada 8 horas y una tableta de Ibuprofeno cada 6 horas durante 5 días.', 
            15, 20
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 16),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 16),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 16),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 19),
            '2024-06-12', NULL, 'Diabetes tipo 2', 'Metformina, Glibenclamida', 
            'Tomar una tableta de Metformina y una tableta de Glibenclamida antes de cada comida principal.', 
            16, 19
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 17),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 17),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 17),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 20),
            '2024-06-14', NULL, 'Osteoartritis', 'Paracetamol, Meloxicam', 
            'Tomar una tableta de Paracetamol cada 6 horas y una tableta de Meloxicam diariamente.', 
            17, 20
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 18),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 18),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 18),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 20),
            '2024-06-15',NULL, 'Dolor de espalda crónico', 'Ibuprofeno, Naproxeno', 
            'Tomar una tableta de Ibuprofeno cada 8 horas y una tableta de Naproxeno cada 12 horas.', 
            18, 20
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 10),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 10),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 10),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 20),
            '2024-06-16', NULL, 'Migraña', 'Sumatriptán, Paracetamol', 
            'Tomar una tableta de Sumatriptán al inicio de la migraña y una tableta de Paracetamol cada 6 horas si persiste el dolor.', 
            10, 20
        ),
        (
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 10),
            (SELECT TIMESTAMPDIFF(YEAR, Fecha_Nacimiento, CURDATE()) FROM tbb_personas WHERE ID = 10),
            (SELECT CASE Genero 
                    WHEN 'M' THEN 'Masculino' 
                    WHEN 'F' THEN 'Femenino' 
                    ELSE 'No Binario' 
                   END 
             FROM tbb_personas WHERE ID = 10),
            (SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) FROM tbb_personas WHERE ID = 19),
            '2024-06-18', NULL, 'Gastritis crónica', 'Omeprazol, Ranitidina', 
            'Tomar una cápsula de Omeprazol antes del desayuno y una tableta de Ranitidina antes de la cena.', 
            10, 19
        );
        
        UPDATE tbd_recetas_medicas SET paciente_nombre = 'Pedro González' WHERE id = 1;
        UPDATE tbd_recetas_medicas SET paciente_nombre = 'Marvin Perez' WHERE id = 2;
        UPDATE tbd_recetas_medicas SET medicamentos = 'Marihuanol, Clonazepan', diagnostico = 'VIH' WHERE id = 2;
        UPDATE tbd_recetas_medicas SET indicaciones = 'Reposo' WHERE id = 3;
        DELETE from tbd_recetas_medicas where id = 1;

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password incorrecto';
    END IF;
END