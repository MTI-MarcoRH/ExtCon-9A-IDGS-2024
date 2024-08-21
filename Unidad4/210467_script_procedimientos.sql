-- SCRIPT DEL POBLACION DINÁMICA DE LA TABLA 'tbd_lotes_medicamentos'

-- ELABORADO POR: MYRIAM VALDERRABANO CORTES
-- GRADO Y GRUPO: 9°
-- PROGRAMA EDUCATIVO: INGENIERÍA EN DESARROLLO Y GESTIÓN DE SOFTWARE
-- FECHA DE ELABORACIÓN: 03 DE AGOSTO DE 2024


-- PERSONAL MEDICO (ESTATICA)
call sp_poblar_personal_medico("xyz#$%");

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
    
/*INSERT INTO tbb_personal_medico (Persona_ID, Departamento_ID, Especialidad, Tipo, 
Cedula_Profesional, Fecha_Contratacion, Salario, Fecha_Actualizacion) 
VALUES (4, 4, 'Dermatología', 'Médico Especialista', 'JKLM112233', '2024-06-06 13:00:00', 8000.00, NOW());

-- Insertar un quinto registro de personal médico
INSERT INTO tbb_personal_medico (Persona_ID, Departamento_ID, Especialidad, Tipo, 
Cedula_Profesional, Fecha_Contratacion, Salario, Fecha_Actualizacion) 
VALUES (5, 5, 'Oftalmología', 'Médico General', 'NOPQ445566', '2024-06-06 14:00:00', 6500.00, NOW());

INSERT INTO tbb_personal_medico (Persona_ID, Departamento_ID, Especialidad, Tipo,
 Cedula_Profesional, Fecha_Contratacion, Salario, Fecha_Actualizacion) 
VALUES (1, 3, 'Cardiología', 'Médico Residente', 
'ABCD123456', '2024-06-06 10:00:00', 5000.00, NOW());

-- Insertar otro registro de personal médico
INSERT INTO tbb_personal_medico (Persona_ID, Departamento_ID, Especialidad, Tipo,
 Cedula_Profesional, Fecha_Contratacion, Salario, Fecha_Actualizacion) 
VALUES (2, 2, 'Pediatría', 'Médico Titular', 
'WXYZ987654', '2024-06-06 11:00:00', 7000.00, NOW());

-- Insertar un tercer registro de personal médico
INSERT INTO tbb_personal_medico (Persona_ID, Departamento_ID, Especialidad, Tipo, 
Cedula_Profesional, Fecha_Contratacion, Salario, Fecha_Actualizacion) 
VALUES (3, 1, 'Ginecología', 'Médico Adjunto', 'FGHJ456789', '2024-06-06 12:00:00', 6000.00, NOW());

UPDATE tbb_personal_medico 
SET Salario = 5500.00, Fecha_Actualizacion = NOW() 
WHERE ID = 1;

-- Actualizar el estatus del personal médico con Cedula_Profesional 'WXYZ987654'
UPDATE tbb_personal_medico 
SET Estatus = 'Inactivo', Fecha_TerminacionContrato = NOW(), Fecha_Actualizacion = NOW() 
WHERE Cedula_Profesional = 'WXYZ987654';

-- Eliminar el registro de personal médico con ID 3
DELETE FROM tbb_personal_medico 
WHERE ID = 3;

-- Eliminar el personal médico con Cedula_Profesional 'FGHJ456789'
DELETE FROM tbb_personal_medico 
WHERE Cedula_Profesional = 'FGHJ456789';
*/


    ELSE
        -- Mensaje de error si la contraseña es incorrecta
        SELECT "La contraseña es incorrecta, no puedo insertar datos en la Base de Datos" AS ErrorMessage;
    END IF;
END

-- --------------------------------------------------------------------------------------------------

-- MEDICAMENTOS (ESTATICA)
call sp_poblar_medicamentos('xYz$123');

CREATE DEFINER=`Cristian.Ojeda`@`%` PROCEDURE `sp_poblar_medicamentos`(IN v_password VARCHAR(20))
BEGIN
 IF v_password = 'xYz$123' THEN
  -- Inserción de cinco registros reales
    INSERT INTO tbc_medicamentos (Nombre_comercial, Nombre_generico, Via_administracion, Presentacion, Tipo, Cantidad, Volumen)
    VALUES
    ('Tylenol', 'Paracetamol', 'Oral', 'Comprimidos', 'Analgesicos', 100, 0.0),
    ('Amoxil', 'Amoxicilina', 'Oral', 'Capsulas', 'Antibioticos', 50, 0.0),
    ('Zoloft', 'Sertralina', 'Oral', 'Comprimidos', 'Antidepresivos', 200, 0.0),
    ('Claritin', 'Loratadina', 'Oral', 'Grageas', 'Antihistaminicos', 150, 0.0),
    ('Advil', 'Ibuprofeno', 'Oral', 'Comprimidos', 'Antiinflamatorios', 300, 0.0);

    -- Actualización de uno de los registros
    UPDATE tbc_medicamentos
    SET Cantidad = 120, Volumen = 10.0, Fecha_actualizacion = CURRENT_TIMESTAMP
    WHERE Nombre_comercial = 'Tylenol';

    -- Eliminación de uno de los registros
    -- DELETE FROM tbc_medicamentos
    -- WHERE Nombre_comercial = 'Amoxil';
  END IF;


END