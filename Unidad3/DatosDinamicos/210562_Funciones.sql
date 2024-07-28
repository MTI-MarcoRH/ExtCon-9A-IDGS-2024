-- SCRIP DE CREACIÓN DE LAS FUNCIONE NECESARIAS PARA LA POBLACION DINAMICA DE LA  TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 28 de Julio del 2024

-- Funciones de la Tabla: tbb_personas

-- 1.- Función:"fn_bandera_porcentaje":
/*Genera un valor aleatorio entre 0 y 100 usando fn_numero_aleatorio_rangos(0, 100).
    Compara este valor aleatorio con el porcentaje proporcionado (v_porcentaje). 
    Si el valor aleatorio es menor o igual al porcentaje, establece la bandera v_bandera como true;
    de lo contrario, la bandera se mantiene como false.*/

    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_bandera_porcentaje`(v_porcentaje INT) RETURNS int
        DETERMINISTIC
    BEGIN
    DECLARE v_valor INT DEFAULT (fn_numero_aleatorio_rangos(0,100));
    DECLARE v_bandera BOOLEAN DEFAULT false;

    IF v_valor <= v_porcentaje THEN 
        SET v_bandera = true;
    END IF;
    RETURN v_bandera;
    END ;;
    DELIMITER ;
-- 2.- Función
DELIMITER ;;
DELIMITER ;
-- 3.- Función
DELIMITER ;;
DELIMITER ;
-- 4.- Función
DELIMITER ;;
DELIMITER ;
-- 5.- Función
DELIMITER ;;
DELIMITER ;