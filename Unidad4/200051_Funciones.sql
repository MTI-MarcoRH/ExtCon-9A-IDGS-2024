TABLA TBD CIRUGIA CONSUMIBLES 


CREATE FUNCTION fn_fecha_aleatoria() 
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE random_days INT;
    DECLARE random_date DATE;

    -- Genera un número aleatorio de días entre 0 y 365 para obtener una fecha en el último año
    SET random_days = FLOOR(RAND() * 365);

    -- Calcula la fecha aleatoria sumando los días aleatorios a la fecha actual
    SET random_date = CURDATE() - INTERVAL random_days DAY;

    RETURN random_date;
END;
