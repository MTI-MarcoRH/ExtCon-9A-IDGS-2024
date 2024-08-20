-- SCRIPT DE CREACIÓN DE LAS FUNCIONES NECESARIAS PARA LA POBLACION DINAMICA DE LA TABLA ASIGNADA

-- Elaborado por: Brayan Gutierrez Ramirez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  20 de Agosto de 2024

-- Funciones de la Tabla: Cirugias y Cirugias personal medico

--------------------------------------- 1) fn_cirugia_fecha_aleatoria ----------------------------------------
CREATE DEFINER=`brayan.gutierrez`@`%` FUNCTION `fn_cirugia_fecha_aleatoria`(fecha_inicio DATE, fecha_fin DATE) RETURNS date
    DETERMINISTIC
BEGIN
    DECLARE v_dias INT;
    DECLARE v_fecha_aleatoria DATE;

    -- Calcula el número de días entre las dos fechas proporcionadas
    SET v_dias = DATEDIFF(fecha_fin, fecha_inicio);

    -- Genera un número aleatorio de días y añade a la fecha de inicio
    SET v_fecha_aleatoria = DATE_ADD(fecha_inicio, INTERVAL FLOOR(1 + RAND() * v_dias) DAY);

    RETURN v_fecha_aleatoria;
END

---------------------------- 2) fn_cirugia_horario_aleatorio --------------------------------------------
CREATE DEFINER=`brayan.gutierrez`@`%` FUNCTION `fn_cirugia_horario_aleatorio`(horaInicio TIME, horaFin TIME) RETURNS time
    DETERMINISTIC
BEGIN
DECLARE horaRegistro DATETIME;
 -- Generar hora de registro aleatoria dentro del rango de hora de entrada y salida
    SET horaRegistro = ADDTIME(horaInicio, SEC_TO_TIME(FLOOR(RAND() * TIME_TO_SEC(TIMEDIFF(horaFin, horaInicio)))));

RETURN horaRegistro;
END


--------------------------------------- 3) fn_cirugia_personal_rol --------------------------------------
CREATE DEFINER=`brayan.gutierrez`@`%` FUNCTION `fn_cirugia_personal_rol`() RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
 DECLARE v_rol_personal varchar(100) DEFAULT NULL;
        SET v_rol_personal = ELT(fn_numero_aleatorio_rangos(1,9),
           'Cirujano Principal', 'Anestesiólogo', 'Enfermera Instrumentista', 'Enfermera Circulante', 'Técnico en Anestesia', 
           'Técnico Quirúrgico', 'Cirujano Residente', 'Radiólogo Intervencionista', 'Perfusionista');
        RETURN v_rol_personal;
END

------------------------------------- 4) fn_cirugia_valoracion_medica ----------------------------------
CREATE DEFINER=`brayan.gutierrez`@`%` FUNCTION `fn_cirugia_valoracion_medica`() RETURNS text CHARSET utf8mb4
    DETERMINISTIC
BEGIN
        DECLARE v_valoracion_medica TEXT DEFAULT NULL;
        SET v_valoracion_medica = ELT(fn_numero_aleatorio_rangos(1,8), 
          "El paciente ha sido evaluado exhaustivamente antes de la cirugía.
          Todos los estudios preoperatorios se encuentran dentro de los parámetros normales.
          Se considera que el paciente está en condiciones adecuadas para el procedimiento.",
		   "El paciente presenta factores de riesgo significativos, como antecedentes de hipertensión y diabetes.
           Sin embargo, con las precauciones adecuadas y el monitoreo continuo, 
           se considera que el riesgo es elevado pero manejable.",
           "El paciente presenta un estado clínico estable con signos vitales dentro de los rangos normales.
           No se han identificado complicaciones agudas que contraindiquen el procedimiento programado.",
           "El paciente goza de buena salud general, con un historial médico sin complicaciones relevantes.
           Se espera una recuperación rápida y sin contratiempos.",
			"El paciente tiene un historial de enfermedades crónicas que podrían complicar el procedimiento.
            Sin embargo, las medidas preventivas han sido implementadas para minimizar los riesgos. 
            Se recomienda una vigilancia postoperatoria intensiva.",
            "El paciente ha completado con éxito la preparación preoperatoria.
            No se han identificado alergias o contraindicaciones. 
            La intervención puede proceder según lo programado.",
            "Tras una evaluación detallada, se concluye que el paciente tiene un riesgo quirúrgico bajo.
            Se anticipa un procedimiento sin complicaciones y una recuperación rápida.",
            "Dado el historial del paciente, se requerirá monitorización postoperatoria cercana,
            especialmente en las primeras 24 horas, para detectar cualquier signo de complicación.");
           
        RETURN v_valoracion_medica;
    END
