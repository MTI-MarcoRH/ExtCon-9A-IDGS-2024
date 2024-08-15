-- SCRIPT DE LAS FUNCIONES DE LA TABLA 'tbd_lotes_medicamentos'

-- ELABORADO POR: MYRIAM VALDERRABANO CORTES
-- GRADO Y GRUPO: 9°
-- PROGRAMA EDUCATIVO: INGENIERÍA EN DESARROLLO Y GESTIÓN DE SOFTWARE
-- FECHA DE ELABORACIÓN: 03 DE AGOSTO DE 2024


-- --------------------------- FUNCION PARA UNA FECHA ALEATORIA 

CREATE DEFINER=`myriam.valderrabano`@`%` FUNCTION `fn_fecha_aleatoria`() RETURNS datetime
    DETERMINISTIC
BEGIN
    DECLARE fecha_actual DATETIME;
    DECLARE fecha_min DATETIME;
    DECLARE dias_diferencia INT;
    DECLARE dias_random INT;
    DECLARE fecha_resultado DATETIME;

    SET fecha_actual = NOW();

    SET fecha_min = DATE_SUB(fecha_actual, INTERVAL 1 YEAR);

    SET dias_diferencia = DATEDIFF(fecha_actual, fecha_min);

    SET dias_random = FLOOR(RAND() * dias_diferencia);

    SET fecha_resultado = DATE_ADD(fecha_min, INTERVAL dias_random DAY);

    SET fecha_resultado = DATE_ADD(fecha_resultado, INTERVAL FLOOR(RAND() * 24) HOUR);
    SET fecha_resultado = DATE_ADD(fecha_resultado, INTERVAL FLOOR(RAND() * 60) MINUTE);
    SET fecha_resultado = DATE_ADD(fecha_resultado, INTERVAL FLOOR(RAND() * 60) SECOND);

    RETURN fecha_resultado;
END



-- ----------------------------- FUNCION PARA GENERAR LA CLAVE DEL LOTE 

CREATE DEFINER=`myriam.valderrabano`@`%` FUNCTION `fn_generar_clave`() RETURNS varchar(6) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE clave VARCHAR(6);
    SET clave = CONCAT(
        CHAR(FLOOR(65 + (RAND() * 26))), -- Letra 
        CHAR(FLOOR(65 + (RAND() * 26))), 
        CHAR(FLOOR(65 + (RAND() * 26))), 
        FLOOR(RAND() * 10), -- Número
        FLOOR(RAND() * 10), 
        FLOOR(RAND() * 10)  
    );
    RETURN clave;
END


-- --------------------------- FUNCION PARA GENERAR EL COSTO DEL LOTE 
CREATE DEFINER=`myriam.valderrabano`@`%` FUNCTION `fn_generar_costo`(max_val DECIMAL(10,2)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    RETURN 1 + (RAND() * (max_val - 1));
END


-- --------------------------- FUNCION PARA GENERAR LA UBICACION ALEATORIA

CREATE DEFINER=`myriam.valderrabano`@`%` FUNCTION `fn_ubicacion_aleatoria`() RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE letra CHAR(1);
    DECLARE ubicacion VARCHAR(20);

    -- Generar una letra aleatoria entre A y Z
    SET letra = CHAR(FLOOR(65 + (RAND() * 26)));

    -- Crear la ubicación en el formato 'Almacen X'
    SET ubicacion = CONCAT('Almacen ', letra);

    RETURN ubicacion;
END

-- ------------------------------ FUNCION QUE GENERA UN NUMERO ALEATORIO

CREATE DEFINER=`myriam.valderrabano`@`%` FUNCTION `fn_numero_aleatorio`(maximo INT) RETURNS int
    DETERMINISTIC
BEGIN
  DECLARE numeroAleatorio INT;
    
    -- Generar número aleatorio entre 1 y maximo
    SET numeroAleatorio = FLOOR(RAND() * maximo) + 1;

    RETURN numeroAleatorio;
END