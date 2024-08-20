-- SCRIPT DE CREACIÓN DE EL PROCEDIMIENTO ALMACENADO DE LA TABLA ASIGNADA

-- Elaborado por: Elí Aidan Melo Calva
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Procedimiento almacenado dinamico de las Tabla:

-- tbb_nacimientos

CREATE DEFINER=`eli.aidan`@`%` PROCEDURE `sp_poblar_nacimientos_dinamicos`(v_cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_nombre_padre VARCHAR(100);
    DECLARE v_nombre_madre VARCHAR(100);
    DECLARE v_signos_vitales VARCHAR(255);
    DECLARE v_calificacion_apgar INT DEFAULT 0;
    DECLARE v_observaciones VARCHAR(255);
    DECLARE v_genero CHAR(1);
    DECLARE v_fecha_registro DATETIME DEFAULT NOW();
    
    WHILE (i <= v_cantidad) DO
     
        SET v_genero = ELT(fn_numero_aleatorio_rangos(1, 2), 'M', 'F');
    
        -- Generar los nombres del padre y la madre
        SET v_nombre_padre = fn_genera_nombre('M'); -- Generar nombre del padre
        SET v_nombre_madre = fn_genera_nombre('F'); -- Generar nombre de la madre
    
        -- Generar signos vitales, calificación APGAR y observaciones
        SET v_signos_vitales = fn_Signos_vitales();
        SET v_calificacion_apgar = fn_Calificacion_APGAR();
        SET v_observaciones = fn_Observaciones();
        SET v_genero = ELT(fn_numero_aleatorio_rangos(1, 2), 'M', 'F');
        
        -- Insertar los datos en la tabla tbb_nacimientos
        INSERT INTO tbb_nacimientos (
            ID, Padre, Madre, Signos_vitales, Estatus, Calificacion_APGAR, Observaciones, Genero, Fecha_Registro, Fecha_Actualizacion
        ) VALUES (
            DEFAULT, v_nombre_padre, v_nombre_madre, v_signos_vitales, DEFAULT, v_calificacion_apgar, v_observaciones, v_genero, v_fecha_registro, NULL
        );
    
        -- Verificación de inserción
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar en tbb_nacimientos';
        END IF;

        SET i = i + 1;
    END WHILE;
END