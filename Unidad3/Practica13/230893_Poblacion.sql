-- SCRIPT DE POBLACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Brayan Gutiérrez Ramírez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Queries para revisión  y población de la tabla: Cirugías y Cirugías_Personal_Médico

-- 1. Verificar la construcción de la tabla
DESC tbb_cirugias;
DESC tbd_cirugias_personal_medico;

-- 1. LIMPIAR BD
call sp_limpiar_bd("xYz$123"); 
-- cambio la estructura de limpiar bd
 -- Eliminamos los datos de las tablas fuertes
    -- mis tablas ----------------------------------------
    DELETE FROM tbd_cirugias_personal_medico;
    ALTER TABLE tbd_cirugias_personal_medico auto_increment=1;
    DELETE FROM tbb_cirugias;
    ALTER TABLE tbb_cirugias auto_increment=1;
    -- ---------------------------------------------------

-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_cirugias("xyz#$%");
-- Tuve que modificar la estructura de poblar_cirugias para poder insertar datos en dicha tabla 
-- ---------------------------------------------------------------------------------------------
DELIMITER $$
CREATE DEFINER=`brayan.gutierrez`@`%` PROCEDURE `sp_poblar_cirugias`(v_password VARCHAR (20))
BEGIN

    DECLARE id_persona INT DEFAULT 0;
    DECLARE id_paciente INT DEFAULT 0;
    DECLARE id_paciente2 INT DEFAULT 0;
    DECLARE id_paciente3 INT DEFAULT 0;
     DECLARE id_paciente4 INT DEFAULT 0;
    DECLARE id_espacio_superior_1 INT DEFAULT 0;
    DECLARE id_espacio_superior_2 INT DEFAULT 0;
    DECLARE id_espacio_medico INT DEFAULT 0;
	DECLARE id_espacio_medico1 INT DEFAULT 0;
    DECLARE id_espacio_medico2 INT DEFAULT 0;
    DECLARE id_espacio_medico3 INT DEFAULT 0;

    IF v_password = "xyz#$%" THEN

        -- Inserta los datos de la persona antes de sus datos cómo empleado del Hospital
        INSERT INTO tbb_personas 
        (Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, 
        Fecha_Registro, Fecha_Actualizacion) 
        VALUES 
        ("Dr.", "Alejandro", "Barrera", "Fernández", "BAFA810525HVZLRR05", "M", "O+", "1981-05-25", DEFAULT, DEFAULT, NULL);
        SET id_persona = last_insert_id(); -- Captura el ID de la persona
        -- Insertamos los datos médicos del empleado
        INSERT INTO tbb_personal_medico 
        (Persona_ID, Departamento_ID, Cedula_Profesional, Tipo, Especialidad, Fecha_Registro, Fecha_Contratacion, 
        Fecha_Termino_Contrato, Salario, Estatus, Fecha_Actualizacion) 
        VALUES 
        (id_persona, 13, "25515487", "Médico", "Pediatría", "2012-08-22 08:50:25", "2015-09-16 09:10:52", NULL, 35000, DEFAULT, NULL);
		
         -- Inserta los datos de la persona antes de sus datos cómo empleado del Hospital
		INSERT INTO tbb_personas(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus,
        Fecha_Registro, Fecha_Actualizacion) 
        VALUES
        ("Dra.", "María José", "Álvarez", "Fonseca","ALFM900620MPLLNR2A", "F", "O-", "1990-06-20", DEFAULT, DEFAULT,NULL);
        set id_persona=last_insert_id();
        -- Insertamos los datos médicos del empledo
        INSERT INTO tbb_personal_medico
        (Persona_ID, Departamento_ID, Cedula_Profesional, Tipo, Especialidad, Fecha_Registro, Fecha_Contratacion, 
        Fecha_Termino_Contrato, Salario, Estatus, Fecha_Actualizacion) 
        VALUES 
        (id_persona, 11, "11422587", "Médico",NULL, 
        "2018-05-10 08:50:25", "2018-05-10 09:10:52", NULL, 10000,DEFAULT,NULL);
		
        INSERT INTO tbb_personas(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus,
        Fecha_Registro, Fecha_Actualizacion) 
        VALUES 
        ("Dr.", "Alfredo", "Carrasco", "Lechuga", "CALA710115HCSRCL25", "M", "AB-", "1971-01-15", DEFAULT, DEFAULT,NULL);
		set id_persona=last_insert_id();
        -- Insertamos los datos médicos del empledo
        INSERT INTO tbb_personal_medico
        (Persona_ID, Departamento_ID, Cedula_Profesional, Tipo, Especialidad, Fecha_Registro, Fecha_Contratacion, 
        Fecha_Termino_Contrato, Salario, Estatus, Fecha_Actualizacion) 
        VALUES
        (id_persona, 1, "3256884", "Administrativo",NULL, 
        "2000-01-01 11:50:25", "2000-01-02 09:00:00", NULL, 40000,DEFAULT,NULL);
        
-- -------------------------------------------------------------------------------------------------------------------------

        -- Insertamos los datos de la persona del primer paciente
        INSERT INTO tbb_personas 
        (Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento,
        Estatus, Fecha_Registro, Fecha_Actualizacion)
        VALUES
        ('Sra.', 'María', 'López', 'Martínez', 'LOMJ850202MDFRPL01', 'F', 'A+', '1985-02-02', b'1', NOW(), NULL);
        SET id_persona = last_insert_id(); -- Captura el ID de la persona del paciente
        INSERT INTO `tbb_pacientes` 
        (Persona_ID, NSS, Tipo_Seguro, Fecha_Ultima_Cita, Estatus_Medico, Estatus_Vida, Estatus, Fecha_Registro, Fecha_Actualizacion) 
        VALUES 
        (id_persona, NULL, 'Sin Seguro', '2009-03-17 17:31:00', DEFAULT, 'Vivo', 1, '2001-02-15 06:23:05', NULL);
        SET id_paciente = last_insert_id(); -- Captura el ID del paciente para usarlo más adelante
        
        -- Insertamos los datos de la persona del segundo paciente
		INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		(NULL, 'Ana', 'Hernández', 'Ruiz', 'HERA900303HDFRRL01', 'F', 'B+', '1990-03-03', b'1', NOW(), NULL);
		SET id_persona = last_insert_id();
        INSERT INTO `tbb_pacientes` VALUES (id_persona,NULL,'Sin Seguro','2019-05-01 13:15:29',default,'Vivo',1,'2020-06-28 18:46:37',NULL);
		SET id_paciente2 = last_insert_id();
        -- Insertamos los datos de la persona del tercer paciente
		INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		('Dr.', 'Carlos', 'García', 'Rodríguez', 'GARC950404HDFRRL06', 'M', 'AB+', '1995-04-04', b'1', NOW(), NULL);
        SET id_persona = last_insert_id();
		INSERT INTO `tbb_pacientes` VALUES (id_persona,'G9OA6QW29V8DVXS','Seguro Popular','2024-02-16 13:10:48',default,'Vivo',1,'2024-02-18 16:05:14',NULL);
		SET id_paciente3 = last_insert_id();
        -- Insertamos los datos de la persona del cuarto paciente
		INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		('Lic.', 'Laura', 'Martínez', 'Gómez', 'MALG000505MDFRRL07', 'F', 'O-', '2000-05-05', b'1', NOW(), NULL);
        SET id_persona = last_insert_id();
		INSERT INTO `tbb_pacientes` VALUES (id_persona,"12254185844-3",'Particular','2022-08-16 12:05:35',default,'Vivo',1,'2022-08-16 11:50:00',NULL);
		SET id_paciente4 = last_insert_id();
        
-- --------------------------------------------------------------------------------------------------------------------------------
        -- INSERTAMOS EL EDIFICIO 1 - Medicina General
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Edificio', 'Medicina General',1 ,NULL,DEFAULT, DEFAULT);
        SET id_espacio_superior_1 = last_insert_id();

        -- Espacios de Nivel 2 
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Piso', 'Planta Baja',56 ,id_espacio_superior_1,DEFAULT,DEFAULT);
        SET id_espacio_superior_2 = last_insert_id();

        -- Espacios de Nivel 3
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Quirófano', 'A-106',16 ,id_espacio_superior_2,DEFAULT, DEFAULT);
         SET id_espacio_medico = last_insert_id(); -- Captura el ID del espacio médico
         INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Quirófano', 'A-107',16 ,id_espacio_superior_2,DEFAULT, DEFAULT);
		set id_espacio_medico1 = last_insert_id();
		INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Quirófano', 'A-108',16 ,id_espacio_superior_2,DEFAULT, DEFAULT);
		set id_espacio_medico2 = last_insert_id();
		INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Quirófano', 'A-109',16 ,id_espacio_superior_2,DEFAULT, DEFAULT);
         SET id_espacio_medico3 = last_insert_id(); -- Captura el ID del espacio médico
        
               -- Inserta la cirugía en tbb_cirugias usando el ID correcto del paciente y del espacio médico
        INSERT INTO tbb_cirugias 
        (Paciente_ID, Espacio_Medico_ID, Tipo, Nombre, Descripcion, Nivel_Urgencia, Horario, Observaciones, Valoracion_Medica, Estatus, Consumible, Fecha_Programacion, Fecha_Realizacion, Fecha_Registro, Fecha_Actualizacion) 
        VALUES
        (id_paciente, 
        id_espacio_medico,
        'Ortopédica', 
        'Reemplazo de Rodilla', 
        'Cirugía para reemplazar una articulación de rodilla dañada con una prótesis.',
        'Alto', 
        '2024-06-20 09:00:00', 
        'Paciente con antecedentes de artritis severa.', 
        'Valoración preoperatoria completa, paciente en condiciones adecuadas.', 
        'Programada', 
        'Prótesis de rodilla, Instrumental quirúrgico',
        DEFAULT,
        DEFAULT,
        DEFAULT, 
        NOW()),
         (id_paciente2, 
        id_espacio_medico1,
         'Ginecológica', 
            'Cesárea', 
            'Cirugía para el nacimiento de un bebé a través de una incisión en el abdomen y el útero de la madre.',
            'Medio', 
            '2024-06-25 10:00:00', 
            'Paciente con antecedentes de parto complicado.', 
            'Valoración preoperatoria completa, paciente en condiciones adecuadas.', 
            'Programada', 
            'Instrumental quirúrgico, Equipo de monitoreo fetal',
			DEFAULT,
			DEFAULT,
            DEFAULT,
            NOW()),
            (id_paciente3, 
        id_espacio_medico2,
         'Cardíaca', 
            'Bypass Coronario', 
            'Cirugía para redirigir la sangre alrededor de una arteria coronaria bloqueada o parcialmente bloqueada.',
            'Alto', 
            '2024-07-15 08:00:00',
            'Paciente con antecedentes de enfermedad coronaria.', 
            'Valoración preoperatoria completa, riesgo elevado pero aceptable.', 
            'Programada', 
            'Bypass, Instrumental quirúrgico',
			DEFAULT,
			DEFAULT,
            DEFAULT, 
            NOW()),
            (id_paciente4,
            id_espacio_medico3,
			'Neurológica', 
            'Resección de Tumor Cerebral', 
            'Cirugía para remover un tumor localizado en el lóbulo frontal del cerebro.',
            'Medio', 
            '2024-08-10 13:00:00',
            'Paciente con síntomas de presión intracraneal.', 
            'Valoración preoperatoria completa, paciente estable.', 
            'Programada', 
            'Instrumental neuroquirúrgico, Sistema de navegación', 
			DEFAULT,
			DEFAULT,
            DEFAULT,
            NOW());
            
            -- Actualizar datos
             UPDATE tbb_cirugias SET Estatus= 'Completada' WHERE ID = '1';
             UPDATE tbb_cirugias SET Estatus= 'Completada' WHERE ID = '2';
			-- Eliminación
            DELETE FROM tbb_cirugias WHERE ID = '4';
        ELSE
        SELECT "La contraseña es incorrecta, no puedo proceder con la inserción de registros" AS ErrorMessage;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------------------------
-- 3 Poblar de manera estatica Cirugias personal medico
call sp_poblar_cirugias_personal_medico('xyz#$%');

-- ----------------------------------------------------------------------------------
DELIMITER $$
CREATE DEFINER=`brayan.gutierrez`@`%` PROCEDURE `sp_poblar_cirugias_personal_medico`(v_password VARCHAR(20))
BEGIN
    DECLARE id_personal_medico INT;
    DECLARE id_cirugia INT;
    DECLARE id_personal_medico1 INT;
    DECLARE id_cirugia1 INT;
    DECLARE id_personal_medico2 INT;
    DECLARE id_cirugia2 INT;

    

    IF v_password = "xyz#$%" THEN

        -- Obtener ID del personal médico usando la cédula
        SELECT Persona_ID INTO id_personal_medico
        FROM tbb_personal_medico
        WHERE Cedula_Profesional = '25515487';
		
        
        SELECT Persona_ID INTO id_personal_medico1
        FROM tbb_personal_medico
        WHERE Cedula_Profesional = '11422587'; 
		
        
        SELECT Persona_ID INTO id_personal_medico2
        FROM tbb_personal_medico
        WHERE Cedula_Profesional = '3256884';
        
        
        -- Obtener ID de la cirugía usando el nombre
        SELECT ID INTO id_cirugia
        FROM tbb_cirugias
        WHERE ID = '1';

        SELECT ID INTO id_cirugia1
        FROM tbb_cirugias
        WHERE ID = '2';

        SELECT ID INTO id_cirugia2
        FROM tbb_cirugias
        WHERE ID = '3';
        

         -- Insertar datos en tbd_cirugias_personal_medico
        INSERT INTO tbd_cirugias_personal_medico (
            Personal_Medico_ID, Cirugia_ID, Rol, Estatus, Fecha_Registro, Fecha_Actualizacion
        ) VALUES 
            (id_personal_medico, id_cirugia,"Cirujano Principal", b'1', DEFAULT, NOW()),
            (id_personal_medico1, id_cirugia1, "Anestesiólogo", b'1', DEFAULT, NOW()),
            (id_personal_medico2, id_cirugia2, "Técnico Quirúrgico", b'1', DEFAULT, NOW());
            
            -- Actualizar datos
             UPDATE tbd_cirugias_personal_medico SET Estatus = 0  WHERE ID = '1';
             
			-- Eliminación
            DELETE FROM tbd_cirugias_personal_medico WHERE ID = '3';
        ELSE
        SELECT "La contraseña es incorrecta, no puedo proceder con la inserción de registros" AS ErrorMessage;
    END IF;
END
$$
DELIMITER ;

-- ------------------------------------------------------------------------------------------------
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_cirugias" ORDER BY ID DESC;
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_cirugias_personal_medico" ORDER BY ID DESC;
-- 4. Realizamos una consulta para visualizar los datos poblados. 
SELECT * FROM tbb_cirugias;
SELECT * FROM tbd_cirugias_personal_medico; 