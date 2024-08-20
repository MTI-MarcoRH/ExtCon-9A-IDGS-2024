-- SCRIPT DE CREACIÓN DE LAS FUNCIONES NECESARIAS PARA LA POBLACION DINAMICA DE LA TABLA ASIGNADA

-- Elaborado por: Justin Martin Muñoz Escorcia
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Funciones de la Tabla: Pacientes y seguimiento pacientes

-- 1.- Función: "fn_genera_estatusmedico"
/*Genera un estatus medico de paciente aleatoreo dentro de los 4 posibles.*/


CREATE DEFINER=`justin.muñoz`@`%` FUNCTION `fn_genera_estatusmedico`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE estatusmedico_generada VARCHAR(60) DEFAULT NULL;
    SET estatusmedico_generada  = ELT(FLOOR(1 + RAND() * 4), 
                'Recuperado','En tratamiento','Controlado','En observación');
    RETURN estatusmedico_generada ;
    END




-- 2.- Función: "fn_genera_estatusvida"
/*Genera el estatus vida de los pacientes de manera aleatoria de entre los 4 estatus posibles.*/


CREATE DEFINER=`justin.muñoz`@`%` FUNCTION `fn_genera_estatusvida`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE estatusvida_generada VARCHAR(60) DEFAULT NULL;
    SET estatusvida_generada  = ELT(FLOOR(1 + RAND() * 4), 
                'Vivo','Finado','Coma','Vegetativo');
    RETURN estatusvida_generada ;
    END





-- 3.- Función: "fn_genera_Observacion"
/*Genera una Observacion random de entre las 50 posibles para el seguimiento del paciente.*/





CREATE DEFINER=`justin.muñoz`@`%` FUNCTION `fn_genera_Observacion`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE Observacion_generada VARCHAR(60) DEFAULT NULL;
    SET Observacion_generada  = ELT(FLOOR(1 + RAND() * 50), 
                'Ta malo','Temperatura alta','Sin observaciones alarmantes','fuera de peligro'
                "Presión arterial elevada", "Fiebre persistente reciente", "Ritmo cardíaco irregular", "Dolor abdominal agudo",
                "Hinchazón en extremidades inferiores", "Pérdida de apetito súbita", "Cianosis en labios", "Rash cutáneo difuso",
                "Náuseas y vómitos frecuentes", "Dificultad para respirar", "Fatiga inexplicable persistente", "Tos seca persistente",
                "Sangrado nasal recurrente", "Sudoración excesiva nocturna", "Dolor en el pecho", "Pérdida de peso inexplicable",
                "Edema en la cara", "Ictericia en piel y ojos", "Cefalea intensa recurrente", "Alteración en la visión",
                "Dolor lumbar crónico", "Eruptiones en piel localizadas", "Confusión mental reciente", "Presencia de sangre en heces",
                "Palpitaciones frecuentes", "Zumbido en los oídos", "Dificultad para tragar", "Hiperpigmentación en la piel",
                "Aumento de la frecuencia urinaria", "Sibilancias al respirar", "Síncope ocasional", "Hipo persistente", "Cansancio extremo matutino",
                "Prurito en piel generalizado", "Hemorragia en encías", "Pérdida de memoria reciente", "Sensación de mareo constante", "Dificultad en la marcha",
                "Desorientación espacial", "Dolor en articulaciones", "Falta de coordinación motora", "Cambios en el estado de ánimo", "Trastornos en el sueño",
                "Dolor en el cuello", "Aumento en el ritmo respiratorio", "Dificultad en la concentración");
    RETURN Observacion_generada ;
    END





-- 4.- Función: "fn_genera_tipo_seguro"
/*Genera el tipo de seguro de los pacientes de manera aleatoria de entre los 3 tipos posibles.*/




    CREATE DEFINER=`justin.muñoz`@`%` FUNCTION `fn_genera_tipo_seguro`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE tipo_seguro_generada VARCHAR(60) DEFAULT NULL;
    SET tipo_seguro_generada  = ELT(FLOOR(1 + RAND() * 3), 
                'Seguro Básico','Seguro Completo','Seguro Especial');
    RETURN tipo_seguro_generada ;
    END