-- Script de procedimientos previos para el llenado de la tabla  tbd_dispensaciones 


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 21 de Agosto de 2024 




-- 1 Poblacion de personal medico ----------------------------------------------------------------

CREATE DEFINER=`jonathan.ibarra`@`%` PROCEDURE `sp_poblar_personal_medico`(v_password varchar(20))
BEGIN
    IF v_password = 'xyz#$%' THEN
    
    START TRANSACTION;
		-- Inserta los datos de la persona antes de sus datos cómo empleado del Hospital
		INSERT INTO tbb_personas VALUES (DEFAULT, "Dr.", "Alejandro", "Barrera", "Fernández",
        "BAFA810525HVZLRR05", "M", "O+", "1981-05-25", DEFAULT, DEFAULT,NULL);
        -- Insertamos los datos médicos del empledo
        INSERT INTO tbb_personal_medico VALUES (last_insert_id(), 13, "25515487", "Médico","Pediatría", 
        "2012-08-22 08:50:25", "2015-09-16 09:10:52", NULL, 35000,DEFAULT,NULL);
        
        -- Inserta los datos de la persona antes de sus datos cómo empleado del Hospital
		INSERT INTO tbb_personas VALUES (DEFAULT, "Dra.", "María José", "Álvarez", "Fonseca",
        "ALFM900620MPLLNR2A", "F", "O-", "1990-06-20", DEFAULT, DEFAULT,NULL);
        -- Insertamos los datos médicos del empledo
        INSERT INTO tbb_personal_medico VALUES (last_insert_id(), 11, "11422587", "Médico",NULL, 
        "2018-05-10 08:50:25", "2018-05-10 09:10:52", NULL, 10000,DEFAULT,NULL);
        
        -- Inserta los datos de la persona antes de sus datos cómo empleado del Hospital
		INSERT INTO tbb_personas VALUES (DEFAULT, "Dr.", "Alfredo", "Carrasco", "Lechuga",
        "CALA710115HCSRCL25", "M", "AB-", "1971-01-15", DEFAULT, DEFAULT,NULL);
        -- Insertamos los datos médicos del empledo
        INSERT INTO tbb_personal_medico VALUES (last_insert_id(), 1, "3256884", "Administrativo",NULL, 
        "2000-01-01 11:50:25", "2000-01-02 09:00:00", NULL, 40000,DEFAULT,NULL);
        
        -- Inserta los datos de la persona antes de sus datos cómo empleado del Hospital
		INSERT INTO tbb_personas VALUES (DEFAULT, "Lic.", "Fernanda", "García", "Méndez",
        "ABCD", "N/B", "A+", "1995-05-10", DEFAULT, DEFAULT,NULL);
        -- Insertamos los datos médicos del empledo
        INSERT INTO tbb_personal_medico VALUES (last_insert_id(), 9, "1458817", "Apoyo",NULL, 
        "2008-01-01 11:51:25", "2008-01-02 19:00:00", NULL, 8000,DEFAULT,NULL);
        
        -- Actualizamos el salario del director general
        UPDATE tbb_personal_medico SET salario= 45000 WHERE cedula_profesional="3256884";
         
		-- Eliminamos a un empleado
        DELETE FROM tbb_personal_medico WHERE cedula_profesional=1458817;
	
    COMMIT;
 


    ELSE
        -- Mensaje de error si la contraseña es incorrecta
        SELECT "La contraseña es incorrecta, no puedo insertar datos en la Base de Datos" AS ErrorMessage;
    END IF;
END


-- 2 poblacion de receta medica ----------------------------------------------------------------

CREATE DEFINER=`marvin.tolentino`@`localhost` PROCEDURE `sp_poblar_recetas`(v_password varchar(20))
BEGIN
IF v_password = "141002" THEN
	SET SQL_SAFE_UPDATES = 0;

	delete from tbd_recetas_medicas;
	alter table tbd_recetas_medicas auto_increment = 1;
	INSERT INTO tbd_recetas_medicas VALUES 
	(1,'Juan Pérez',
    35, 'Dr. García',
    '2024-06-06', '2024-06-06',
    'Gripe común', 'Paracetamol, Ibuprofeno',
    'Tomar una tableta de Paracetamol cada 6 horas y una tableta de Ibuprofeno cada 8 horas durante 3 días.'),
    (2,'Mario López',
    55, 'Dr. Goku',
    '2024-05-04', '2024-06-06',
    'Hipertensión arterial', 'Losartán, Amlodipino', 
    'Tomar una tableta de Losartán y una tableta de Amlodipino diariamente antes del desayuno.'),
	(3,
    'María López', 45, 
    'Dr. Martínez', 
    '2024-06-05', '2024-06-06', 
    'Hipertensión arterial', 'Losartán, Amlodipino', 
    'Tomar una tableta de Losartán y una tableta de Amlodipino diariamente antes del desayuno.'),
    (4,
    'Yair Tolentino', 21, 
    'Dr. Jesus', 
    '2024-06-05', '2024-06-06', 
    'Sindrome de Dawn', 'Ibuprofeno, Aspirinas', 
    'Tomar una tableta de aspirina y una tableta de ibuprofeno antes de dormir'),
    (5,
	 'Ana García', 30,
	 'Dr. Rodríguez',
	 '2024-06-10', '2024-06-10',
	 'Infección de garganta',
	 'Amoxicilina, Ibuprofeno',
	 'Tomar una tableta de Amoxicilina cada 8 horas y una tableta de Ibuprofeno cada 6 horas durante 5 días.'),
	(6,
	 'Pedro Ramírez', 40,
	 'Dr. Gómez',
	 '2024-06-12', '2024-06-12',
	 'Diabetes tipo 2',
	 'Metformina, Glibenclamida',
	 'Tomar una tableta de Metformina y una tableta de Glibenclamida antes de cada comida principal.'),
	(7,
	 'Luisa Martínez', 50,
	 'Dr. Sánchez',
	 '2024-06-14', '2024-06-14',
	 'Osteoartritis',
	 'Paracetamol, Meloxicam',
	 'Tomar una tableta de Paracetamol cada 6 horas y una tableta de Meloxicam diariamente.'),
	(8,
	 'Carlos Hernández', 60,
	 'Dr. Pérez',
	 '2024-06-15', '2024-06-15',
	 'Dolor de espalda crónico',
	 'Ibuprofeno, Naproxeno',
	 'Tomar una tableta de Ibuprofeno cada 8 horas y una tableta de Naproxeno cada 12 horas.'),
	(9,
	 'Laura Ramírez', 25,
	 'Dr. Díaz',
	 '2024-06-16', '2024-06-16',
	 'Migraña',
	 'Sumatriptán, Paracetamol',
	 'Tomar una tableta de Sumatriptán al inicio de la migraña y una tableta de Paracetamol cada 6 horas si persiste el dolor.'),
	(10,
	 'Javier Pérez', 48,
	 'Dr. Ramírez',
	 '2024-06-18', '2024-06-18',
	 'Gastritis crónica',
	 'Omeprazol, Ranitidina',
	 'Tomar una cápsula de Omeprazol antes del desayuno y una tableta de Ranitidina antes de la cena.');
		
    
	UPDATE tbd_recetas_medicas SET paciente_nombre = 'Pedro González' WHERE id = 1;
    UPDATE tbd_recetas_medicas SET paciente_nombre = 'Marvin Perez' WHERE id = 2;
	UPDATE tbd_recetas_medicas SET medicamentos = 'Marihuanol, Clonazepan', diagnostico ='VIH' WHERE id = 2;
	UPDATE tbd_recetas_medicas SET indicaciones = 'Reposo' WHERE id = 3;
    UPDATE tbd_recetas_medicas SET medicamentos = 'Clonazepan, inyeccion letal', diagnostico ='VIH' WHERE id = 4;
    
		
	
    
else
	select "La contraseña es incorrecta"  AS ErrorMessage;
END IF;

END

-- 3 poblacion de solicitudes --------------------------------------------------------

CREATE DEFINER=`Carlos.Hernandez`@`%` PROCEDURE `sp_poblar_solicitudes`(v_password VARCHAR(10))
BEGIN
    IF v_password = 'xYz$123' THEN

        -- Insertar registros predefinidos
        INSERT INTO tbd_solicitudes 
            (Paciente_ID, Medico_ID, Servicio_ID, Prioridad, Descripcion, Estatus, Estatus_Aprobacion, Fecha_Registro, Fecha_Actualizacion)
        VALUES 
            (1, 1, 1, 'Moderada', 'Revisión médica anual para monitorear mi salud general.', 'Registrada', DEFAULT, NOW(), DEFAULT),
            (2, 2, 2, 'Emergente', 'Tratamiento médico para mejorar mi bienestar.', 'Programada', DEFAULT, NOW(), DEFAULT),
            (3, 3, 3, 'Alta', 'Consulta especializada para manejar una condición específica.', 'Reprogramada', DEFAULT, NOW(), DEFAULT),
            (4, 4, 4, 'Normal', 'Revisión mensual para monitorear mi condición cardíaca.', 'En Proceso', DEFAULT, NOW(), DEFAULT),
            (5, 5, 5, 'Urgente', 'Revisión médica para ver mis niveles de salud.', 'Realizada', DEFAULT, NOW(), DEFAULT);

        -- Actualizar registros específicos
        UPDATE tbd_solicitudes
        SET Prioridad = 'Normal'
        WHERE ID = 1;
        
        UPDATE tbd_solicitudes
        SET Estatus = 'Cancelada'
        WHERE ID = 2;


    ELSE
        SELECT 'La contraseña es incorrecta, no puede mostrar el estatus de la Base de Datos' AS ErrorMessage;
    END IF;
END


