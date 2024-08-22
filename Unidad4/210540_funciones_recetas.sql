/*
-> Script de funciones 
->Elaborado por: Marvin Yair Tolentino Perez 
-> Grado: 9, Grupo: A 
-> Ingenieria en gestion y desarrollo de software 
-> Fecha de Elaboracion: 20/07/2024
*/


CREATE DEFINER=`root`@`localhost` FUNCTION `generar_diagnosticos`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE diagnostico VARCHAR(255);
    SET diagnostico = CASE FLOOR(1 + RAND() * 20)
        WHEN 1 THEN 'Gripe'
        WHEN 2 THEN 'Diabetes Tipo 2'
        WHEN 3 THEN 'Hipertensión Arterial'
        WHEN 4 THEN 'Asma'
        WHEN 5 THEN 'Artritis Reumatoide'
        WHEN 6 THEN 'EPOC'
        WHEN 7 THEN 'Insuficiencia Cardíaca'
        WHEN 8 THEN 'Migraña'
        WHEN 9 THEN 'Osteoporosis'
        WHEN 10 THEN 'Anemia'
        WHEN 11 THEN 'Cáncer de Piel'
        WHEN 12 THEN 'Gastritis'
        WHEN 13 THEN 'Bronquitis'
        WHEN 14 THEN 'Depresión'
        WHEN 15 THEN 'Alergia Alimentaria'
        WHEN 16 THEN 'Apnea del Sueño'
        WHEN 17 THEN 'Fibromialgia'
        WHEN 18 THEN 'Síndrome del Intestino Irritable'
        WHEN 19 THEN 'Hipotiroidismo'
        WHEN 20 THEN 'Hepatitis C'
    END;
    RETURN diagnostico;
END

/*-------------------------------------------*/

CREATE DEFINER=`root`@`localhost` FUNCTION `generar_indicaciones`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE indicacion VARCHAR(255);
    SET indicacion = CASE FLOOR(1 + RAND() * 20)
        WHEN 1 THEN 'Tomar 1 tableta cada 8 horas.'
        WHEN 2 THEN 'Aplicar la pomada dos veces al día.'
        WHEN 3 THEN 'Evitar el consumo de alcohol.'
        WHEN 4 THEN 'No exponer la zona afectada al sol.'
        WHEN 5 THEN 'Realizar ejercicios de respiración diaria.'
        WHEN 6 THEN 'Tomar abundante agua.'
        WHEN 7 THEN 'Acudir a consulta de control en una semana.'
        WHEN 8 THEN 'Evitar el consumo de alimentos grasos.'
        WHEN 9 THEN 'Descansar durante 48 horas.'
        WHEN 10 THEN 'Mantener la herida limpia y seca.'
        WHEN 11 THEN 'Aplicar hielo en la zona afectada.'
        WHEN 12 THEN 'Tomar el medicamento con alimentos.'
        WHEN 13 THEN 'Usar ropa cómoda y ligera.'
        WHEN 14 THEN 'Realizar caminatas de 30 minutos diarias.'
        WHEN 15 THEN 'Evitar el estrés y las situaciones tensas.'
        WHEN 16 THEN 'No saltarse ninguna dosis.'
        WHEN 17 THEN 'Tomar la medicación antes de dormir.'
        WHEN 18 THEN 'Revisar la presión arterial diariamente.'
        WHEN 19 THEN 'Evitar el uso de productos perfumados en la piel.'
        WHEN 20 THEN 'Guardar reposo en cama durante 5 días.'
    END;
    RETURN indicacion;
END

/*-------------------------------------------*/
CREATE DEFINER=`root`@`localhost` FUNCTION `generar_indicaciones_medicamentos`() RETURNS text CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE indicaciones_m TEXT DEFAULT '';
    DECLARE i INT DEFAULT 0;
    DECLARE num_opciones INT DEFAULT 20;
    DECLARE rnd INT;

    -- Generar un número aleatorio entre 1 y 20
    SET rnd = FLOOR(1 + (RAND() * num_opciones));

    -- Seleccionar una indicación basada en el número aleatorio
    SET indicaciones_m = CASE rnd
        WHEN 1 THEN 'Tomar una pastilla con agua después del desayuno.'
        WHEN 2 THEN 'Tomar dos pastillas con agua antes de acostarse.'
        WHEN 3 THEN 'Tomar una pastilla con alimentos durante la comida.'
        WHEN 4 THEN 'Tomar una pastilla cada 8 horas con un vaso de agua.'
        WHEN 5 THEN 'Tomar dos pastillas con el estómago vacío por la mañana.'
        WHEN 6 THEN 'Tomar una pastilla con un vaso de leche antes de dormir.'
        WHEN 7 THEN 'Tomar una pastilla con un poco de comida cada 6 horas.'
        WHEN 8 THEN 'Tomar dos pastillas por la mañana y una por la noche.'
        WHEN 9 THEN 'Tomar una pastilla con un vaso grande de agua después de comer.'
        WHEN 10 THEN 'Tomar una pastilla con una comida ligera por la tarde.'
        WHEN 11 THEN 'Tomar una pastilla con el desayuno y otra con la cena.'
        WHEN 12 THEN 'Tomar una pastilla justo antes de ir a la cama.'
        WHEN 13 THEN 'Tomar una pastilla después de una comida pesada.'
        WHEN 14 THEN 'Tomar dos pastillas con un vaso de agua cada 12 horas.'
        WHEN 15 THEN 'Tomar una pastilla con la comida principal del día.'
        WHEN 16 THEN 'Tomar una pastilla con el almuerzo y otra antes de dormir.'
        WHEN 17 THEN 'Tomar una pastilla con un vaso de jugo por la mañana.'
        WHEN 18 THEN 'Tomar una pastilla con cada comida principal del día.'
        WHEN 19 THEN 'Tomar una pastilla por la mañana y otra por la tarde.'
        WHEN 20 THEN 'Tomar dos pastillas antes de acostarse con un vaso de agua.'
        ELSE 'Indicaciones no disponibles.'
    END;

    RETURN indicaciones_m;
END


/*-------------------------------------------*/

CREATE DEFINER=`root`@`localhost` FUNCTION `generar_observaciones`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE observacion VARCHAR(255);
    SET observacion = CASE FLOOR(1 + RAND() * 20)
        WHEN 1 THEN 'El paciente presenta síntomas leves.'
        WHEN 2 THEN 'Necesita seguimiento en una semana.'
        WHEN 3 THEN 'Recomendar reposo absoluto.'
        WHEN 4 THEN 'Posible reacción alérgica a medicamentos.'
        WHEN 5 THEN 'Los signos vitales son estables.'
        WHEN 6 THEN 'Necesidad de exámenes adicionales.'
        WHEN 7 THEN 'El tratamiento ha mostrado mejoría.'
        WHEN 8 THEN 'Riesgo de complicaciones si no se sigue el tratamiento.'
        WHEN 9 THEN 'Se observó aumento de presión arterial.'
        WHEN 10 THEN 'Dolor persistente en la zona afectada.'
        WHEN 11 THEN 'El paciente debe evitar esfuerzos físicos.'
        WHEN 12 THEN 'Signos de deshidratación.'
        WHEN 13 THEN 'Requiere consulta con especialista.'
        WHEN 14 THEN 'El paciente muestra ansiedad moderada.'
        WHEN 15 THEN 'El tratamiento debe continuar por dos semanas más.'
        WHEN 16 THEN 'Alergia al polvo detectada.'
        WHEN 17 THEN 'El paciente se encuentra en recuperación.'
        WHEN 18 THEN 'Necesario ajustar la dosis del medicamento.'
        WHEN 19 THEN 'Debe mantenerse hidratado.'
        WHEN 20 THEN 'No hay signos de infección.'
    END;
    RETURN observacion;
END