-- SCRIP DE CREACIÓN DE LAS FUNCIONE NECESARIAS PARA LA POBLACION DINAMICA DE LA  TABLA ASIGNADA

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Funciones de la Tabla: tbb_valoraciones_medicas


-- 1.- Función:"fn_indicador_aleatorio":
/*Genera un indicador aleatorio para cada valoacion, este va dell 1 al 4, siendo estos diferentes entre si*/
CREATE DEFINER=`romualdo`@`localhost` FUNCTION `fn_indicador_aleatorio`() RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE indicador VARCHAR(50);
    SET indicador = CASE FLOOR(1 + RAND() * 4)
        WHEN 1 THEN 'Peso'
        WHEN 2 THEN 'Altura'
        WHEN 3 THEN 'Presión'
        WHEN 4 THEN 'Frecuencia cardíaca'
        END;
    RETURN indicador;
END



-- 2.- Función:"fn_numero_aleatorio_rangos":
/*Genera un numero aleatoio que es utilizado para colocar el id del paciente (manera fictica)*/
CREATE DEFINER=`romualdo`@`localhost` FUNCTION `fn_numero_aleatorio_rangos`(min_value INT, max_value INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = FLOOR(min_value + (RAND() * (max_value - min_value + 1)));
    RETURN resultado;
END