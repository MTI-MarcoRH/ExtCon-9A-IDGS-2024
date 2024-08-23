-- FUNCION GENERAR DIA DE LA SEMANA
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_dia_semana_horarios`() RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE dia_semana VARCHAR(20);
    SET dia_semana = CASE FLOOR(1 + (RAND() * 7))
        WHEN 1 THEN 'Lunes'
        WHEN 2 THEN 'Martes'
        WHEN 3 THEN 'Miércoles'
        WHEN 4 THEN 'Jueves'
        WHEN 5 THEN 'Viernes'
        WHEN 6 THEN 'Sábado'
        ELSE 'Domingo'
    END;
    RETURN dia_semana;
END

-- FUNCION GENERAR ESPECIALIDAD
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_especialidad_horarios`() RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE especialidad VARCHAR(100);
    SET especialidad = CASE FLOOR(1 + (RAND() * 5))
        WHEN 1 THEN 'Cardiología'
        WHEN 2 THEN 'Dermatología'
        WHEN 3 THEN 'Neurología'
        WHEN 4 THEN 'Pediatría'
        ELSE 'Ortopedia'
    END;
    RETURN especialidad;
END


-- FUNCION GENERAR HORA INICIO
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_hora_inicio_horarios`() RETURNS time
    DETERMINISTIC
BEGIN
    RETURN SEC_TO_TIME(FLOOR(RAND() * 28800 + 25200));  -- Genera una hora entre las 07:00:00 y las 15:00:00
END

-- FUNCION GENERAR HORA FIN
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_hora_fin_horarios`() RETURNS time
    DETERMINISTIC
BEGIN
    RETURN SEC_TO_TIME(FLOOR(RAND() * 28800 + 54000));  -- Genera una hora entre las 15:00:00 y las 23:00:00
END

-- FUNCION GENERAR NOMBRE
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_nombre_horarios`() RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(50);
    
    SET nombre = CASE FLOOR(1 + (RAND() * 10))
        WHEN 1 THEN 'Juan Perez'
        WHEN 2 THEN 'María Lopez'
        WHEN 3 THEN 'Carlos Hernandez'
        WHEN 4 THEN 'Nely Marquez'
        WHEN 5 THEN 'David Benavidez'
        WHEN 6 THEN 'Marco Sosa'
        WHEN 7 THEN 'Diego Oliver'
        WHEN 8 THEN 'Jose Gomex'
        WHEN 9 THEN 'Marta Alvarez'
        ELSE 'Sofía Vergara'
    END;
    
    RETURN nombre;
END


-- FUNCION GENERAR TIPO HORARIO
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_tipo_horarios`() RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE tipo_horario VARCHAR(20);
    SET tipo_horario = CASE FLOOR(1 + (RAND() * 4))
        WHEN 1 THEN 'Diario'
        WHEN 2 THEN 'Semanal'
        WHEN 3 THEN 'Quincenal'
        ELSE 'Mensual'
    END;
    RETURN tipo_horario;
END


-- FUNCION GENERAR TURNO
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_turno_horarios`() RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE turno VARCHAR(20);
    SET turno = CASE FLOOR(1 + (RAND() * 3))
        WHEN 1 THEN 'Matutino'
        WHEN 2 THEN 'Vespertino'
        ELSE 'Nocturno'
    END;
    RETURN turno;
END