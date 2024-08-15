-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Carlos Martin Hernández de Jesús
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  04 de Julio de 2024

-- Como probarlo
SELECT fn_numero_aleatorio_rangos(10, 50);

-- ------------------------ Funcion de rango de numeros ------------------------

CREATE DEFINER=`Carlos.Hernandez`@`%` FUNCTION `fn_numero_aleatorio_rangos`(v_limite_inferior int, v_limite_superior INT) RETURNS int
    DETERMINISTIC
BEGIN
     DECLARE v_numero_generado INT;
    SET v_numero_generado = FLOOR(RAND() * (v_limite_superior - v_limite_inferior + 1) + v_limite_inferior);
    RETURN v_numero_generado;
END