-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 02 de agosto de 2024 


CREATE DEFINER=`alexis.gomez`@`%` FUNCTION `fn_fecha_aleatoria_departamentos_servicios`() RETURNS datetime
    DETERMINISTIC
BEGIN
    DECLARE fecha_max DATETIME;
    DECLARE fecha_min DATETIME;
    DECLARE fecha_random DATETIME;
    DECLARE rango_dias INT;
    DECLARE rango_horas INT;
    DECLARE rango_minutos INT;

    -- Obtener la fecha actual
    SET fecha_max = NOW();
    
    -- Obtener la fecha de hace un año
    SET fecha_min = DATE_SUB(fecha_max, INTERVAL 1 YEAR);

    -- Calcular el rango en días, horas y minutos
    SET rango_dias = TIMESTAMPDIFF(DAY, fecha_min, fecha_max);
    SET rango_horas = rango_dias * 24;
    SET rango_minutos = rango_horas * 60;

    -- Generar la fecha aleatoria dentro del rango
    SET fecha_random = DATE_ADD(fecha_min, INTERVAL FLOOR(RAND() * rango_minutos) MINUTE);
    
    RETURN fecha_random;
END