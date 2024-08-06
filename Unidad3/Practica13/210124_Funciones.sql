-- SCRIPT DE CRECACIÓN DE FUNCIONES

-- Elaborado por: Armando Carrasco Vargas
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  04 de Agosto de 2023


-
------------------------ Funcion para la seleccion de un rango de numeros ------------------------

CREATE DEFINER=`armando.carrasco`@`%` FUNCTION `fn_numero_aleatorio_rangos`(v_limite_inferior int, v_limite_superior INT) RETURNS int
    DETERMINISTIC
BEGIN
     DECLARE v_numero_generado INT;
    SET v_numero_generado = FLOOR(RAND() * (v_limite_superior - v_limite_inferior + 1) + v_limite_inferior);
    RETURN v_numero_generado;
END
