CREATE DEFINER=`marvin.tolentino`@`localhost` PROCEDURE `sp_poblar_recetas_basico`(v_password varchar(20))
BEGIN
    IF v_password = "141002" THEN
        SET SQL_SAFE_UPDATES = 0;

        DELETE FROM tbd_recetas_medicas;
        ALTER TABLE tbd_recetas_medicas AUTO_INCREMENT = 1;
        
         -- Insertamos los nuevos datos en la tabla
        INSERT INTO tbd_recetas_medicas 
        (paciente_nombre, paciente_edad, sexo, medico_nombre, fecha, fecha_actualizacion, diagnostico, medicamentos, indicaciones, id_paciente, id_medico) 
        VALUES 
        ('Juan Pérez', 35, 'Masculino', 'Dr. García', '2024-06-06', NULL, 'Gripe común', 'Paracetamol, Ibuprofeno', 'Tomar una tableta de Paracetamol cada 6 horas y una tableta de Ibuprofeno cada 8 horas durante 3 días.', 10, 19),
        ('Mario López', 55, 'Masculino', 'Dr. Goku', '2024-05-04', NULL, 'Hipertensión arterial', 'Losartán, Amlodipino', 'Tomar una tableta de Losartán y una tableta de Amlodipino diariamente antes del desayuno.', 11, 19),
        ('María López', 45, 'Femenino', 'Dr. Martínez', '2024-06-05', NULL, 'Hipertensión arterial', 'Losartán, Amlodipino', 'Tomar una tableta de Losartán y una tableta de Amlodipino diariamente antes del desayuno.', 13, 20),
        ('Yair Tolentino', 21, 'Masculino', 'Dr. Jesus', '2024-06-05', NULL, 'Sindrome de Dawn', 'Ibuprofeno, Aspirinas', 'Tomar una tableta de aspirina y una tableta de ibuprofeno antes de dormir', 14, 20),
        ('Ana García', 30, 'Femenino', 'Dr. Rodríguez', '2024-06-10', NULL, 'Infección de garganta', 'Amoxicilina, Ibuprofeno', 'Tomar una tableta de Amoxicilina cada 8 horas y una tableta de Ibuprofeno cada 6 horas durante 5 días.', 15, 19),
        ('Pedro Ramírez', 40, 'Masculino', 'Dr. Gómez', '2024-06-12', NULL, 'Diabetes tipo 2', 'Metformina, Glibenclamida', 'Tomar una tableta de Metformina y una tableta de Glibenclamida antes de cada comida principal.', 16, 20),
        ('Luisa Martínez', 50, 'Femenino', 'Dr. Sánchez', '2024-06-14', NULL, 'Osteoartritis', 'Paracetamol, Meloxicam', 'Tomar una tableta de Paracetamol cada 6 horas y una tableta de Meloxicam diariamente.', 17, 19),
        ('Carlos Hernández', 60, 'Masculino', 'Dr. Pérez', '2024-06-15', NULL, 'Dolor de espalda crónico', 'Ibuprofeno, Naproxeno', 'Tomar una tableta de Ibuprofeno cada 8 horas y una tableta de Naproxeno cada 12 horas.', 18, 20),
        ('Laura Ramírez', 25, 'Femenino', 'Dr. Díaz', '2024-06-16', NULL, 'Migraña', 'Sumatriptán, Paracetamol', 'Tomar una tableta de Sumatriptán al inicio de la migraña y una tableta de Paracetamol cada 6 horas si persiste el dolor.', 11, 19),
        ('Javier Pérez', 48, 'Masculino', 'Dr. Ramírez', '2024-06-18', NULL, 'Gastritis crónica', 'Omeprazol, Ranitidina', 'Tomar una cápsula de Omeprazol antes del desayuno y una tableta de Ranitidina antes de la cena.', 10, 20);

      
       -- Actulizacion de campos de la tabla
        UPDATE tbd_recetas_medicas SET paciente_nombre = 'Pedro González' WHERE id = 1;
        UPDATE tbd_recetas_medicas SET paciente_nombre = 'Marvin Perez' WHERE id = 2;
        UPDATE tbd_recetas_medicas SET medicamentos = 'Marihuanol, Clonazepan', diagnostico = 'VIH' WHERE id = 2;
        UPDATE tbd_recetas_medicas SET indicaciones = 'Reposo' WHERE id = 3;
        DELETE FROM tbd_recetas_medicas WHERE id = 1;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password incorrecto';
    END IF;
END