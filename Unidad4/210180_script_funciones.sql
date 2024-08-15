-- Script de creacion de funciones para la tabla de tbd_dispensaciones


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 02 de agosto de 2024 

CREATE DEFINER=`Cristian.Ojeda`@`%` FUNCTION `fn_numero_aleatorio_dispensaciones`(max INT) RETURNS int
    DETERMINISTIC
BEGIN
    RETURN FLOOR(1 + (RAND() * max));
END

-- -------------------------------------------------Funcion de rango de numeros decimales -------------------------------------------------

CREATE DEFINER=`Cristian.Ojeda`@`%` FUNCTION `fn_numero_aleatorio_decimales_dispensaciones`(maximo DECIMAL(10,2)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
  DECLARE numeroAleatorio DECIMAL(10,2);
    
    -- Generar número aleatorio con decimales entre 1 y el valor máximo dado
    SET numeroAleatorio = RAND() * maximo;

    RETURN numeroAleatorio;
END



-- -----------------------------------------------Funcion de fecha de registro aleatoria ----------------------------------------
CREATE DEFINER=`Cristian.Ojeda`@`localhost` FUNCTION `fn_fecha_aleatoria_dispensacion`() RETURNS datetime
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
