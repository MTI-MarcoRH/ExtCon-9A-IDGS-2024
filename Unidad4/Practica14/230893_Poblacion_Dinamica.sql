-- SCRIPT DE POBLACIÓN DINAMICA DE TABLAS ASIGNADAS

-- Elaborado por: Brayan Gutiérrez Ramírez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  20 de Agosto de 2024

-- Se necesita llevar acabo este proceso para poder poblar de manera dinamica las tablas asignadas
-- limpiar bd
call sp_limpiar_bd('xYz$123');

--  1 poblar pacientes 
call sp_poblar_pacientes_dinamico('1234', 200); -- como el compañero no tiene una poblacion dinamica se realiza una con datos aleatorios
select * from tbb_pacientes;

-- 2 poblar espacios medicos
call sp_poblar_espacios('xYz$123');
select*from tbc_espacios;

-- 3 poblar las cirugias
call sp_poblar_cirugias_dinamico('100');
select * from tbb_cirugias;

-- 4 poblar personal medico
call sp_poblar_personal_medico_dinamico('100','Médico');
select * from tbb_personal_medico;

-- 4 poblar cirugias personal medico
call sp_poblar_cirugias_personal_medico_dinamico(100);
select * from tbd_cirugias_personal_medico;

-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_cirugias"  ORDER BY ID DESC; -- ver cosulta general
SELECT * FROM tbi_bitacora WHERE tabla = "tbb_cirugias" AND Operacion IN ('DELETE')  ORDER BY ID DESC; -- solo ver el delete
-- 4. Verificamos el registro de los eventos en bitacora de cirugias personal medico 
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_cirugias_personal_medico" ORDER BY ID DESC;
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_cirugias_personal_medico" AND Operacion IN ('DELETE')  ORDER BY ID DESC; -- ver solo el delete



-------------------- Poblar de manera dinamica la tabla de cirugias ----------------------------------
DELIMITER $$
CREATE DEFINER=`brayan.gutierrez`@`%` PROCEDURE `sp_poblar_cirugias_dinamico`(v_cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_tipo_cirugia VARCHAR(250);
    DECLARE v_nombre_cirugia VARCHAR(150);
    DECLARE v_descripcion TEXT;
    DECLARE v_nivel_urgencia VARCHAR(50);
    DECLARE v_horario TIME;
    DECLARE v_observaciones TEXT;
    DECLARE v_valoracion_medica TEXT;
    DECLARE v_estatus VARCHAR(50);
    DECLARE v_consumible VARCHAR(200);
    DECLARE v_fecha_programacion DATE;
    DECLARE v_fecha_realizacion DATE;
    DECLARE v_fecha_registro DATETIME DEFAULT NULL;
    -- ------------------------------------
    DECLARE v_paciente_id INT;
    DECLARE v_espacio_medico_id INT;
    
    -- Crea una variable para guardar el ID de la persona y espacio médico aleatorios
    DECLARE v_paciente_cursor CURSOR FOR SELECT Persona_ID FROM tbb_pacientes ORDER BY RAND() LIMIT 1;
    DECLARE v_espacio_cursor CURSOR FOR SELECT ID FROM tbc_espacios where Tipo = "Quirófano"  ORDER BY RAND() LIMIT 1;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_paciente_id = NULL, v_espacio_medico_id = NULL;

    WHILE (i <= v_cantidad) DO
        -- Obtener paciente y espacio médico aleatorios
        OPEN v_paciente_cursor;
        FETCH v_paciente_cursor INTO v_paciente_id;
        CLOSE v_paciente_cursor;
        
        OPEN v_espacio_cursor;
        FETCH v_espacio_cursor INTO v_espacio_medico_id;
        CLOSE v_espacio_cursor;
        
        -- Generar datos para la cirugía
        SET v_fecha_registro = CURDATE();
        SET v_tipo_cirugia = ELT(fn_numero_aleatorio_rangos(1, 4), "Ortopédica", "Ginecológica", "Cardíaca", "Neurológica");
        -- SELECCIONAR NIVEL DE URGENCIA ALEATORIA
        SET v_nivel_urgencia = ELT(fn_numero_aleatorio_rangos(1,3), "Bajo", "Medio", "Alto");
        -- SELECCIONAR HORARIO ALEATORIO DE LA CIRUGIA
        SET v_horario = fn_cirugia_horario_aleatorio('00:00:00', '23:59:59');
        -- ASIGNAR AL AZAR VALORACION MEDICA DE LA CIRUGIA
        SET v_valoracion_medica = fn_cirugia_valoracion_medica();
        -- ASIGNAR ESTATUS A CIRUGIA
        SET v_estatus = ELT(fn_numero_aleatorio_rangos(1,4),"Programada", "En curso", "Completada", "Cancelada");
        -- ASIGNAR AL AZAR FECHA DE PROGRAMACION DE CIRUGIA
        SET v_fecha_programacion =  fn_cirugia_fecha_aleatoria('1980-01-01', '2001-01-01');
        -- ASIGNAR AL AZAR FECHA DE REALIZACACION DE CIRUGIA
        SET v_fecha_realizacion = fn_cirugia_fecha_aleatoria('2002-01-01', '2005-01-01');
        -- Asignar una descripción basada en el tipo de cirugía
        CASE v_tipo_cirugia
            WHEN 'Ortopédica' THEN
                SET v_nombre_cirugia = "Reemplazo de Rodilla";
                SET v_descripcion = "Cirugía para reemplazar una articulación de rodilla dañada con una prótesis.";
                SET v_observaciones = "Paciente con antecedentes de artritis severa.";
                SET v_consumible = "Prótesis de rodilla, Instrumental quirúrgico";
            WHEN 'Ginecológica' THEN
                SET v_nombre_cirugia = "Cesárea";
                SET v_descripcion = "Cirugía para el nacimiento de un bebé a través de una incisión en el abdomen y el útero de la madre.";
                SET v_observaciones = "Paciente con antecedentes de parto complicado.";
                SET v_consumible = "Instrumental quirúrgico, Equipo de monitoreo fetal";
            WHEN 'Cardíaca' THEN
                SET v_nombre_cirugia = "Bypass Coronario";
                SET v_descripcion = "Cirugía para redirigir la sangre alrededor de una arteria coronaria bloqueada o parcialmente bloqueada.";
                SET v_observaciones = "Paciente con antecedentes de enfermedad coronaria.";
                SET v_consumible = "Bypass, Instrumental quirúrgico";
            WHEN 'Neurológica' THEN
                SET v_nombre_cirugia = "Resección de Tumor Cerebral";
                SET v_descripcion = "Cirugía para remover un tumor localizado en el lóbulo frontal del cerebro.";
                SET v_observaciones = "Paciente con síntomas de presión intracraneal.";
                SET v_consumible = "Instrumental neuroquirúrgico, Sistema de navegación";
            ELSE
                SET v_descripcion = "Descripción genérica para otro tipo de cirugía.";
        END CASE;
        
        -- Insertar la cirugía en la tabla
        INSERT INTO tbb_cirugias (Paciente_ID, Espacio_Medico_ID, Tipo, Nombre, Descripcion, Nivel_Urgencia, Horario, Observaciones, Valoracion_Medica, Estatus, Consumible, Fecha_Programacion, Fecha_Realizacion, Fecha_Registro, Fecha_Actualizacion) 
        VALUES (v_paciente_id, v_espacio_medico_id, v_tipo_cirugia, v_nombre_cirugia, v_descripcion, v_nivel_urgencia, v_horario, v_observaciones, v_valoracion_medica, v_estatus, v_consumible, v_fecha_programacion, v_fecha_realizacion, v_fecha_registro, NOW());
        
        -- Actualizar datos
             UPDATE tbb_cirugias SET Estatus= 'Completada' WHERE ID = '1';
             UPDATE tbb_cirugias SET Estatus= 'Completada' WHERE ID = '2';
			-- Eliminanar las cirugias con el nombre que contenga Reemplazo de Rodilla
           DELETE FROM tbb_cirugias 
		   WHERE Nombre IN ('Reemplazo de Rodilla');


    
        SET i = i + 1;
    END WHILE;
END
$$
DELIMITER ;


-------- Poblar de manera dinamica la tabla de cirugias personal medico-------------------------------
DELIMITER $$
CREATE DEFINER=`brayan.gutierrez`@`%` PROCEDURE `sp_poblar_cirugias_personal_medico_dinamico`(v_cantidad INT)
BEGIN

DECLARE i INT DEFAULT 1;
DECLARE v_personal_medico_id INT;
DECLARE v_cirugia_id INT;
DECLARE v_rol VARCHAR(150);
DECLARE v_fecha_realizacion DATE;
DECLARE v_fecha_registro DATETIME DEFAULT NULL;

-- Crea una variable para guardar el ID de la persona y espacio médico aleatorios
    DECLARE v_personal_medico_cursor CURSOR FOR SELECT Persona_ID FROM tbb_personal_medico ORDER BY RAND() LIMIT 1;
    DECLARE v_cirugia_cursor CURSOR FOR SELECT ID FROM tbb_cirugias ORDER BY RAND() LIMIT 1;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_personal_medico_id = NULL, v_cirugia_id = NULL;

WHILE (i <= v_cantidad) DO
        -- Obtener paciente y espacio médico aleatorios
        OPEN v_personal_medico_cursor;
        FETCH v_personal_medico_cursor INTO v_personal_medico_id;
        CLOSE v_personal_medico_cursor;
        
        OPEN v_cirugia_cursor;
        FETCH v_cirugia_cursor INTO v_cirugia_id;
        CLOSE v_cirugia_cursor;
        
         SET v_fecha_registro = CURDATE();
         SET v_rol = ELT(fn_numero_aleatorio_rangos(1,9),"Cirujano Principal", "Anestesiólogo", "Enfermera Instrumentista",
         "Enfermera Circulante","Técnico en Anestesia", "Técnico Quirúrgico", "Cirujano Residente", "Radiólogo Intervencionista",
         "Perfusionista");
         
          -- Insertar la cirugía en la tabla
        INSERT INTO tbd_cirugias_personal_medico (ID, Personal_Medico_ID, Cirugia_ID, Rol, Estatus, Fecha_Registro, Fecha_Actualizacion) 
        VALUES (DEFAULT, v_personal_medico_id, v_cirugia_id, v_rol, DEFAULT, v_fecha_registro, NOW()   );
		
        -- Actualizar datos
             UPDATE tbd_cirugias_personal_medico SET Estatus = 0  WHERE ID = '1';
        -- Eliminar los datos de cirugias personal medico que contengan 'Técnico Quirúrgico', 'Perfusionista'
		 DELETE FROM tbd_cirugias_personal_medico 
		   WHERE Rol IN ('Técnico Quirúrgico', 'Perfusionista');
        
        SET i = i + 1;
    END WHILE;

END

$$
DELIMITER ;

-------------------- Poblar de manera dinamica la tabla de pacientes ----------------------------------
DELIMITER $$
CREATE DEFINER=`justin.muñoz`@`%` PROCEDURE `sp_poblar_pacientes_dinamico`(
    IN v_password VARCHAR(10),
    IN v_cantidad INT
   
)
    DETERMINISTIC
BEGIN
 DECLARE v_nss VARCHAR(15) DEFAULT NULL;
    DECLARE v_contador INT DEFAULT 0;
    
    IF v_password = "1234" THEN
        WHILE v_contador < v_cantidad DO
            -- Insertamos los datos de la persona del paciente
            INSERT INTO tbb_personas 
            (Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
            VALUES
            (CASE WHEN v_contador % 4 = 0 THEN 'Sra.' WHEN v_contador % 4 = 1 THEN NULL WHEN v_contador % 4 = 2 THEN 'Dr.' ELSE 'Lic.' END, 
             CASE WHEN v_contador % 4 = 0 THEN 'María' WHEN v_contador % 4 = 1 THEN 'Ana' WHEN v_contador % 4 = 2 THEN 'Carlos' ELSE 'Laura' END, 
             CASE WHEN v_contador % 4 = 0 THEN 'López' WHEN v_contador % 4 = 1 THEN 'Hernández' WHEN v_contador % 4 = 2 THEN 'García' ELSE 'Martínez' END, 
             CASE WHEN v_contador % 4 = 0 THEN 'Martínez' WHEN v_contador % 4 = 1 THEN 'Ruiz' WHEN v_contador % 4 = 2 THEN 'Rodríguez' ELSE 'Gómez' END, 
             CONCAT('CURP', v_contador), 
             CASE WHEN v_contador % 2 = 0 THEN 'F' ELSE 'M' END, 
             CASE WHEN v_contador % 4 = 0 THEN 'A+' WHEN v_contador % 4 = 1 THEN 'B+' WHEN v_contador % 4 = 2 THEN 'AB+' ELSE 'O-' END, 
             DATE_SUB(CURDATE(), INTERVAL v_contador*365 DAY), 
             b'1', 
             NOW(), 
             NULL);
			 set v_nss=fn_genera_nss();
            -- Insertamos los datos del paciente asociado a la persona
            INSERT INTO tbb_pacientes 
            VALUES (
                LAST_INSERT_ID(),
               v_nss,
                CASE WHEN v_contador % 4 = 2 THEN 'Seguro Popular' ELSE 'Sin Seguro' END,
                NOW(),
                DEFAULT,
                'Vivo',
                1,
                NOW(),
                NULL
            );

            -- Incrementamos el contador
            SET v_contador = v_contador + 1;
        END WHILE;

    ELSE
        SELECT "La contraseña es incorrecta" AS mensaje;
    END IF;
END
$$
DELIMITER ;


-------------------- Poblar espacios medicos ----------------------------------
DELIMITER $$
CREATE DEFINER=`bruno.lemus`@`%` PROCEDURE `sp_poblar_espacios`(v_password VARCHAR(20))
BEGIN
	DECLARE id_espacio_superior_1 INT DEFAULT 0;
    DECLARE id_espacio_superior_2 INT DEFAULT 0;
    IF v_password = "xYz$123" THEN
        -- Insertar varios registros en la tabla tbd_espacio
        
        
        -- INSERTAMOS EL EDIFICIO 1 - Medicina General
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Edificio', 'Medicina General',1 ,NULL,DEFAULT, DEFAULT);
        SET id_espacio_superior_1= last_insert_id();
		
        -- Espacios de Nivel 2 
       INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Piso', 'Planta Baja',56 ,id_espacio_superior_1,DEFAULT,DEFAULT);
        SET id_espacio_superior_2= last_insert_id();
        -- Espacios de Nivel 3
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Consultorio', 'A-101',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-102',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-103',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-104',17 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-105',17 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Quirófano', 'A-106',16 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Quirófano', 'A-107',16 ,id_espacio_superior_2,DEFAULT, DEFAULT), 
        ('Sala de Espera', 'A-108',16 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Sala de Espera', 'A-109',16 ,id_espacio_superior_2,DEFAULT, DEFAULT);
           
             
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Piso', 'Planta Alta',56, id_espacio_superior_1,DEFAULT, DEFAULT);
        SET id_espacio_superior_2= last_insert_id();
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Habitación', 'A-201',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-202',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-203',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-204',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-205',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Laboratorio', 'A206',23 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Capilla', 'A-207',56 ,id_espacio_superior_2,DEFAULT, DEFAULT), 
        ('Recepción', 'A-208',1 ,id_espacio_superior_2,DEFAULT, DEFAULT);
        
        /*
        -- INSERTAMOS EL EDIFICIO 2 - Medicina de Especialidad
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Estatus, Capacidad, Espacio_Superior_ID) VALUES
        ('Oficina', 'Oficina Quirúrgica', 'Recursos Humanos', 'Activo', 10, 'Piso 3, Edificio Principal');
        -- INSERTAMOS EL EDFICIO 3 -  Areas Administrativas
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Estatus, Capacidad, Espacio_Superior_ID) VALUES
        ('Oficina', 'Oficina Quirúrgica', 'Recursos Humanos', 'Activo', 10, 'Piso 3, Edificio Principal');
        */
      


        -- Realizar algunas actualizaciones o eliminaciones si es necesario
        UPDATE tbc_espacios SET Estatus= 'En remodelación' WHERE nombre = 'A-105';
        UPDATE tbc_espacios SET Capacidad = 80 WHERE nombre = 'A-109';
        
        DELETE FROM tbc_espacios WHERE nombre = 'A-207';
        

    ELSE
        SELECT "La contraseña es incorrecta, no puedo proceder con la inserción de registros" AS ErrorMessage;
    END IF;
END
$$
DELIMITER ;

--------------------------------Poblar personal medico de manera dinamica --------------------------------------
DELIMITER $$
CREATE DEFINER=`jonathan.ibarra`@`%` PROCEDURE `sp_poblar_personal_medico_dinamico`(total_registros_a_insertar int, v_tipo VARCHAR(50))
BEGIN
    DECLARE fecha_actual DATE;
    DECLARE fecha_limite_27_anios DATE;
    DECLARE fecha_limite_65_anios DATE;
    DECLARE contador INT DEFAULT 1;
    DECLARE genero_persona CHAR(1);
    DECLARE fecha_nacimiento_persona DATE;
    DECLARE nombre_persona VARCHAR(50);
    DECLARE primer_apellido_persona VARCHAR(50);
    DECLARE segundo_apellido_persona VARCHAR(50);
    DECLARE entidad_federativa_nacimiento VARCHAR(50);
    DECLARE pivote_grupo_sanguineo INT;
    DECLARE grupo_sanguineo CHAR(2);
    DECLARE tipo_sanguineo_completo VARCHAR(5);
    DECLARE tipo_sangre CHAR(1);
    DECLARE fecha_valida BOOLEAN DEFAULT FALSE;
    DECLARE fecha_registro DATETIME;
    DECLARE edad_al_registro INT;
    DECLARE v_persona_id INT DEFAULT 0;
    DECLARE v_total_departamentos INT DEFAULT (SELECT COUNT(*) FROM tbc_departamentos WHERE estatus = b'1');
    DECLARE v_pos_departamento INT DEFAULT NULL;
    DECLARE v_departamento_id INT DEFAULT NULL;
    DECLARE v_fecha_contratacion DATETIME DEFAULT NULL;
    DECLARE v_bandera_tiene_especialidad BOOLEAN DEFAULT NULL;
    DECLARE v_nombre_especialidad VARCHAR(60) DEFAULT NULL;
    DECLARE v_titulo VARCHAR(20) DEFAULT NULL;
    DECLARE v_bandera_fechar_valida BOOLEAN DEFAULT FALSE;
    DECLARE v_fecha_inicio_actividades_hospital DATE DEFAULT "2001-01-01";
    DECLARE v_bandera_fecha_contratacion_valida BOOLEAN DEFAULT FALSE;
    DECLARE v_edad_contratacion INT DEFAULT NULL;
    DECLARE v_edad_registro INT DEFAULT NULL;
    
    -- Obtener la fecha actual
    SET fecha_actual = CURDATE();
    
    -- Calcular la fecha límite para 27 años atrás
    SET fecha_limite_27_anios = DATE_SUB(fecha_actual, INTERVAL 27 YEAR);
    
    -- Calcular la fecha límite para 65 años atrás
    SET fecha_limite_65_anios = DATE_SUB(fecha_actual, INTERVAL 65 YEAR);

    WHILE contador <= total_registros_a_insertar DO
        -- Generar el género de la persona
        SET genero_persona = ELT(fn_numero_aleatorio_rangos(1,2), "M", "F");
        
        -- Generar la fecha de nacimiento de la persona
        SET fecha_nacimiento_persona = fn_genera_fecha_nacimiento(fecha_limite_65_anios, fecha_limite_27_anios);
        SET nombre_persona = fn_genera_nombre(genero_persona);
        SET primer_apellido_persona = fn_genera_apellido();
        SET segundo_apellido_persona = fn_genera_apellido();
        
        -- Generar la entidad federativa de nacimiento de la persona
        SET entidad_federativa_nacimiento = ELT(fn_numero_aleatorio_rangos(1, 32),
            'Aguascalientes', 'Baja California', 'Baja California Sur', 'Campeche', 'Coahuila', 'Colima', 'Chiapas', 'Chihuahua', 'Ciudad de México', 'Durango',
            'Guanajuato', 'Guerrero', 'Hidalgo', 'Jalisco', 'México', 'Michoacán', 'Morelos', 'Nayarit', 'Nuevo León', 'Oaxaca', 'Puebla', 'Querétaro', 'Quintana Roo',
            'San Luis Potosí', 'Sinaloa', 'Sonora', 'Tabasco', 'Tamaulipas', 'Tlaxcala', 'Veracruz', 'Yucatán', 'Zacatecas', 'Nacido en el Extranjero');
        
        -- Generar Grupo y Tipo Sanguíneo 
        SET pivote_grupo_sanguineo = fn_numero_aleatorio_rangos(0, 1000);
        
        IF pivote_grupo_sanguineo BETWEEN 0 AND 3 THEN 
            SET grupo_sanguineo = 'AB';
            SET tipo_sangre = '-';
        ELSEIF pivote_grupo_sanguineo BETWEEN 4 AND 10 THEN 
            SET grupo_sanguineo = 'B';
            SET tipo_sangre = '-';
        ELSEIF pivote_grupo_sanguineo BETWEEN 11 AND 21 THEN 
            SET grupo_sanguineo = 'A';
            SET tipo_sangre = '-';
        ELSEIF pivote_grupo_sanguineo BETWEEN 21 AND 34 THEN 
            SET grupo_sanguineo = 'O';
            SET tipo_sangre = '-';
        ELSEIF pivote_grupo_sanguineo BETWEEN 35 AND 106 THEN 
            SET grupo_sanguineo = 'AB';
            SET tipo_sangre = '+';
        ELSEIF pivote_grupo_sanguineo BETWEEN 107 AND 357 THEN 
            SET grupo_sanguineo = 'B';
            SET tipo_sangre = '+';
        ELSEIF pivote_grupo_sanguineo BETWEEN 358 AND 633 THEN 
            SET grupo_sanguineo = 'A';
            SET tipo_sangre = '+';
        ELSE
            SET grupo_sanguineo = 'O';
            SET tipo_sangre = '+';
        END IF;
        
        -- Concatenar para tener el grupo sanguineo completo
        SET tipo_sanguineo_completo = CONCAT(grupo_sanguineo, tipo_sangre);
        
        
        -- Calcular la fecha de registro de la persona
        WHILE NOT fecha_valida DO
            SET fecha_registro = fn_fechahora_aleatoria_rangos(v_fecha_inicio_actividades_hospital, fecha_actual, '08:00:00', '20:00:00');
            SET edad_al_registro = fn_calcula_edad_fecha_especifica(fecha_nacimiento_persona, fecha_registro);
            IF fecha_registro > fecha_nacimiento_persona AND edad_al_registro >= 27 THEN 
                SET fecha_valida = TRUE; 
            END IF;
        END WHILE;


   -- Insertar datos en la tabla tbb_personas
        INSERT INTO tbb_personas
        (`ID`, `Titulo`, `Nombre`, `Primer_Apellido`, `Segundo_Apellido`, `CURP`, `Genero`, `Grupo_Sanguineo`, `Fecha_Nacimiento`, `Estatus`, `Fecha_Registro`, `Fecha_Actualizacion`)
        VALUES
        (DEFAULT, NULL, nombre_persona, primer_apellido_persona, segundo_apellido_persona, fn_genera_curp(nombre_persona, primer_apellido_persona, segundo_apellido_persona, fecha_nacimiento_persona, genero_persona, entidad_federativa_nacimiento), genero_persona, tipo_sanguineo_completo, fecha_nacimiento_persona, DEFAULT, fecha_registro, NULL);




        -- Guardamos el ID de la persona insertada para reutilizarlo.
    SET v_persona_id = last_insert_id();
    
    -- Insertar los datos laborales del empleado
    -- Elegimos el id del departamento al que esta adscrito el empleado 
    SET v_pos_departamento = fn_numero_aleatorio_rangos(1, v_total_departamentos)-1;
    SET v_departamento_id = (SELECT ID FROM tbc_departamentos ORDER BY ID LIMIT v_pos_departamento,1);
    
    
      IF v_tipo IS NULL THEN 
		SET v_tipo = ELT(fn_numero_aleatorio_rangos(1,7), "Médico", "Enfermero", "Administrativo", 
        "Directivo", "Apoyo", "Residente", "Interno");
    END IF;
    
    
    
    -- Considerando que el 25% de los Médicos contratados  y el 10% residentes tienen especialidad
    IF v_tipo = "Médico" THEN 
		SET v_bandera_tiene_especialidad = fn_bandera_porcentaje(25);
		IF v_bandera_tiene_especialidad THEN 
            SET v_nombre_especialidad = fn_genera_especialidad();
		ELSE 
			SET v_nombre_especialidad = "Medicina General";
		END IF;
        IF genero_persona = "M" THEN
			SET v_titulo = "Dr.";
		ELSE
			SET v_titulo = "Dra.";
		END IF;
	ELSEIF v_tipo ="Residente" THEN   -- Alumnos de Posgrado que ya tiene la carrera de medicina general
        --  y estan en fase de termino de su especialidad
		SET v_bandera_tiene_especialidad = fn_bandera_porcentaje(10);
		IF v_bandera_tiene_especialidad THEN 
            SET v_nombre_especialidad = fn_genera_especialidad();
            IF genero_persona = "M" THEN
				SET v_titulo = "Dr.";
			ELSE
				SET v_titulo = "Dra.";
			END IF;
		ELSE 
			SET v_nombre_especialidad = "Medicina General";
		END IF;
	ELSEIF v_tipo ="Interno" THEN 
		SET v_nombre_especialidad ="Medicina General";   -- Los médicos internos son estudiantes sin graduarse
        -- de la carrera de medicina
        SET v_titulo = "Pste.";
    
	ELSE 
		SET v_nombre_especialidad = NULL;
	END IF; 
    
    WHILE NOT v_bandera_fecha_contratacion_valida DO 
		-- Calcular la fecha de contratación
		SET v_fecha_contratacion = fn_fechahora_aleatoria_rangos(v_fecha_inicio_actividades_hospital,fecha_actual, "08:00:00", "20:00:00" );
        SET v_edad_contratacion  =  fn_calcula_edad_fecha_especifica(fecha_nacimiento_persona, v_fecha_contratacion);
        
        IF (v_edad_contratacion BETWEEN 27 AND 65) AND (v_edad_contratacion >= 27) AND (v_fecha_contratacion >= v_fecha_inicio_actividades_hospital) 
        AND  (v_fecha_contratacion >= fecha_registro) THEN
			SET v_bandera_fecha_contratacion_valida=TRUE;
		END IF;
	END WHILE;
    -- Le actualizamos el titulo al médico
    UPDATE tbb_personas SET titulo = v_titulo WHERE id = v_persona_id;
    
    INSERT INTO tbb_personal_medico(
        `Persona_ID`,
        `Departamento_ID`,
        `Cedula_Profesional`,
        `Tipo`,
        `Especialidad`,
        `Fecha_Registro`,
        `Fecha_Contratacion`,
        `Fecha_Termino_Contrato`,
        `Salario`,
        `Estatus`,
        `Fecha_Actualizacion`)
    VALUES(
        v_persona_id, 
        v_departamento_id, 
        fn_genera_cedula_profesional(), 
        v_tipo,
        v_nombre_especialidad,
        fecha_registro,
        v_fecha_contratacion,
        NULL,
        fn_genera_sueldos(v_tipo),
        DEFAULT,       
        NULL);

    SET v_tipo = NULL;
    SET v_titulo = NULL;
    
    SET v_bandera_fecha_contratacion_valida=FALSE;

            -- Resetear la bandera para la próxima iteración
    SET fecha_valida = FALSE;
        
        -- Incrementar el contador
    SET contador = contador + 1;

END WHILE;
    
    
END
$$
DELIMITER ;