-- SCRIP DE CREACIÓN DE EL PROCEDIMIENTO ALMACENADO DE LA TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 28 de Julio del 2024

-- Procedimiento almacenado de la Tabla: tbb_personas

CREATE DEFINER=`jose.gomez`@`%` PROCEDURE `sp_poblar_personas_dinamico`(v_cantidad int, v_tipo VARCHAR(50))
BEGIN

	DECLARE i INT DEFAULT 1;
    DECLARE v_genero CHAR DEFAULT NULL;
    DECLARE v_fecha_actual DATE;
    DECLARE v_fecha_limite_27 DATE;
    DECLARE v_fecha_limite_65 DATE;
    DECLARE v_fecha_nacimiento DATE;
    DECLARE v_efn VARCHAR(500);
    DECLARE v_nombre VARCHAR(100);
    DECLARE v_primer_apellido VARCHAR(100);
    DECLARE v_segundo_apellido VARCHAR(100);
    DECLARE v_tipo_sangre VARCHAR(50);
    DECLARE v_grupo_sanguineo VARCHAR(50);
    DECLARE v_pivote_sangre INT DEFAULT 0;
    DECLARE v_persona_id INT DEFAULT 0;
    DECLARE v_fecha_contratacion DATETIME DEFAULT NULL;
    DECLARE v_bandera_tiene_especialidad BOOLEAN DEFAULT NULL;
    DECLARE v_nombre_especialidad VARCHAR(60) DEFAULT NULL;
    DECLARE v_titulo VARCHAR(20) DEFAULT NULL;
    DECLARE v_fecha_registro DATETIME DEFAULT NULL;
    DECLARE v_bandera_fechar_valida BOOLEAN DEFAULT FALSE;
    DECLARE v_fecha_inicio_actividades_hospital DATE DEFAULT "2001-01-01";
    DECLARE v_bandera_fecha_contratacion_valida BOOLEAN DEFAULT FALSE;
    DECLARE v_edad_contratacion INT DEFAULT NULL;
    DECLARE v_edad_registro INT DEFAULT NULL;
    
    -- Obtener la fecha actual
    SET v_fecha_actual = CURDATE();
    
    -- Calcular la fecha límite para 27 años atrás
    SET v_fecha_limite_27 = DATE_SUB(v_fecha_actual, INTERVAL 27 YEAR);
    
    -- Calcular la fecha límite para 65 años atrás
    SET v_fecha_limite_65 = DATE_SUB(v_fecha_actual, INTERVAL 65 YEAR);
            
    WHILE(i <= v_cantidad) DO
	
    --  En caso de que no se defina el tipo de personal médico , elegir uno aleatorio
    IF v_tipo IS NULL THEN 
		SET v_tipo = ELT(fn_numero_aleatorio_rangos(1,7), "Médico", "Enfermero", "Administrativo", 
        "Directivo", "Apoyo", "Residente", "Interno");
    END IF;
    
    -- Generar el genero de la persona
    SET v_genero = ELT(fn_numero_aleatorio_rangos(1,2), "M", "F");
    
    -- Generar el fecha de nacimiento de la persona
    SET v_fecha_nacimiento = fn_genera_fecha_nacimiento(v_fecha_limite_65, v_fecha_limite_27);
    SET v_nombre = fn_genera_nombre(v_genero);
    SET v_primer_apellido = fn_genera_apellido();
    SET v_segundo_apellido = fn_genera_apellido();
    
    
    -- Generar la entidad federativa de nacimiento de la persona
    SET v_efn =  ELT(fn_numero_aleatorio_rangos(1,32),
    "Aguascalientes", "Baja California","Baja California Sur", "Campeche", "Coahuila", "Colima", "Chiapas", "Chihuahua", "Distrito Federal", "Durango",
    "Guanajuato", "Guerrero", "Hidalgo" , "Jalisco", "México", "Michoacán", "Morelos", "Nayarit", "Nuevo León", "Oaxaca", "Puebla", "Querétaro", "Quintana Roo",
    "San Luis Potosí", "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatán", "Zacatecas", "Nacido en el Extranjero");
    
        -- Generar Grupo y Tipo Sanguíneo 
        SET v_pivote_sangre = fn_numero_aleatorio_rangos(0,1000);

        IF v_pivote_sangre BETWEEN 0 AND 3 THEN 
            SET v_grupo_sanguineo = "AB-";
        ELSEIF v_pivote_sangre BETWEEN 4 AND 10 THEN 
            SET v_grupo_sanguineo = "B-";
        ELSEIF v_pivote_sangre BETWEEN 11 AND 21 THEN 
            SET v_grupo_sanguineo = "A-";
        ELSEIF v_pivote_sangre BETWEEN 21 AND 34 THEN 
            SET v_grupo_sanguineo = "O-";
        ELSEIF v_pivote_sangre BETWEEN 35 AND 106 THEN 
            SET v_grupo_sanguineo = "AB+";
        ELSEIF v_pivote_sangre BETWEEN 107 AND 357 THEN 
            SET v_grupo_sanguineo = "B+";
        ELSEIF v_pivote_sangre BETWEEN 358 AND 633 THEN 
            SET v_grupo_sanguineo = "A+";
        ELSE
            SET v_grupo_sanguineo = "O+";
        END IF;

    
    
    -- Calcular la fecha de registro de la persona considernado la regla de negocio que las personas no pueden ser registradas antes de haber nacido  y ninguna 
    -- fecha superior a la fecha actual 
    
    WHILE NOT v_bandera_fechar_valida DO
   		SET v_fecha_registro = fn_fechahora_aleatoria_rangos(v_fecha_inicio_actividades_hospital, v_fecha_actual, "08:00:00", "20:00:00");
		SET v_edad_registro = fn_calcula_edad_fecha_especifica(v_fecha_nacimiento, v_fecha_registro);
		IF v_fecha_registro > v_fecha_nacimiento  AND v_edad_registro >= 27 THEN 
           SET v_bandera_fechar_valida = TRUE; 
		END IF;
        
	END WHILE; 
        
    
    
    -- Insertar los datos personales
        INSERT INTO tbb_personas (ID, Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
        VALUES (DEFAULT, v_titulo, v_nombre, v_primer_apellido, v_segundo_apellido, fn_genera_curp(v_nombre, v_primer_apellido, v_segundo_apellido, v_fecha_nacimiento, v_genero, v_efn), v_genero, v_grupo_sanguineo, v_fecha_nacimiento, DEFAULT, v_fecha_registro, NULL);

    -- Guardamos el ID de la persona insertada para reutilizarlo.
    SET v_persona_id = last_insert_id();
    
    
    -- Considerando que el 25% de los Médicos contratados  y el 10% residentes tienen especialidad
    IF v_tipo = "Médico" THEN 
		SET v_bandera_tiene_especialidad = fn_bandera_porcentaje(25);
		IF v_bandera_tiene_especialidad THEN 
            SET v_nombre_especialidad = fn_genera_especialidad();
		ELSE 
			SET v_nombre_especialidad = "Medicina General";
		END IF;
        IF v_genero = "M" THEN
			SET v_titulo = "Dr.";
		ELSE
			SET v_titulo = "Dra.";
		END IF;
	ELSEIF v_tipo ="Residente" THEN   -- Alumnos de Posgrado que ya tiene la carrera de medicina general
        --  y estan en fase de termino de su especialidad
		SET v_bandera_tiene_especialidad = fn_bandera_porcentaje(10);
		IF v_bandera_tiene_especialidad THEN 
            SET v_nombre_especialidad = fn_genera_especialidad();
            IF v_genero = "M" THEN
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
		SET v_fecha_contratacion = fn_fechahora_aleatoria_rangos(v_fecha_inicio_actividades_hospital,v_fecha_actual, "08:00:00", "20:00:00" );
        SET v_edad_contratacion  =  fn_calcula_edad_fecha_especifica(v_fecha_nacimiento, v_fecha_contratacion);
        
        IF (v_edad_contratacion BETWEEN 27 AND 65) AND (v_edad_contratacion >= 27) AND (v_fecha_contratacion >= v_fecha_inicio_actividades_hospital) 
        AND  (v_fecha_contratacion >= v_fecha_registro) THEN
			SET v_bandera_fecha_contratacion_valida=TRUE;
		END IF;
	END WHILE;
    -- Le actualizamos el titulo al médico
    UPDATE tbb_personas SET titulo = v_titulo WHERE id = v_persona_id;
    

    SET v_tipo = NULL;
    SET v_titulo = NULL;
    SET v_bandera_fechar_valida = FALSE;
    SET v_bandera_fecha_contratacion_valida=FALSE;
    SET i =i +1;
	END WHILE;
END