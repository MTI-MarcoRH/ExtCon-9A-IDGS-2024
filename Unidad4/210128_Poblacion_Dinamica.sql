-- SCRIPT DE CREACIÓN DE PROCEDIMIENTO DE POBLADO DINAMICO

-- Elaborado por: Jonathan Enrique Ibarra Canales
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  4 de Agosto de 2024



DELIMITER &&
DROP procedure IF EXISTS `sp_poblar_personal_medico_dinamico`;
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
&&
DELIMITER ;