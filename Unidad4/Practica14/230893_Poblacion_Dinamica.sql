-- SCRIPT DE POBLACIÓN DINAMICA DE TABLAS ASIGNADAS

-- Elaborado por: Brayan Gutiérrez Ramírez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  20 de Agosto de 2024

-- Se necesita llevar acabo este proceso para poder poblar de manera dinamica las tablas asignadas
-- limpiar bd
call sp_limpiar_bd('xYz$123');

--  1 poblar pacientes 
call sp_poblar_pacientes_dinamico('1234', 200); -- como el compañero no tiene una poblacion dinamica se realiza una con datos aleatorios
select * from tbb_pacientes;

-- 2 poblar espacios medicos
call sp_poblar_espacios('xYz$123');
select*from tbc_espacios;

-- 3 poblar las cirugias
call sp_poblar_cirugias_dinamico('100');
select * from tbb_cirugias;

-- 4 poblar personal medico
call sp_poblar_personal_medico_dinamico('100','Médico');
select * from tbb_personal_medico;

-- 4 poblar cirugias personal medico
call sp_poblar_cirugias_personal_medico_dinamico(100);
select * from tbd_cirugias_personal_medico;

-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_cirugias"  ORDER BY ID DESC; -- ver cosulta general
SELECT * FROM tbi_bitacora WHERE tabla = "tbb_cirugias" AND Operacion IN ('DELETE')  ORDER BY ID DESC; -- solo ver el delete
-- 4. Verificamos el registro de los eventos en bitacora de cirugias personal medico 
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_cirugias_personal_medico" ORDER BY ID DESC;
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_cirugias_personal_medico" AND Operacion IN ('DELETE')  ORDER BY ID DESC; -- ver solo el delete



-- Poblar de manera dinamica la tabla de cirugias
DELIMITER $$
CREATE DEFINER=`brayan.gutierrez`@`%` PROCEDURE `sp_poblar_cirugias_dinamico`(v_cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_tipo_cirugia VARCHAR(250);
    DECLARE v_nombre_cirugia VARCHAR(150);
    DECLARE v_descripcion TEXT;
    DECLARE v_nivel_urgencia VARCHAR(50);
    DECLARE v_horario TIME;
    DECLARE v_observaciones TEXT;
    DECLARE v_valoracion_medica TEXT;
    DECLARE v_estatus VARCHAR(50);
    DECLARE v_consumible VARCHAR(200);
    DECLARE v_fecha_programacion DATE;
    DECLARE v_fecha_realizacion DATE;
    DECLARE v_fecha_registro DATETIME DEFAULT NULL;
    -- ------------------------------------
    DECLARE v_paciente_id INT;
    DECLARE v_espacio_medico_id INT;
    
    -- Crea una variable para guardar el ID de la persona y espacio médico aleatorios
    DECLARE v_paciente_cursor CURSOR FOR SELECT Persona_ID FROM tbb_pacientes ORDER BY RAND() LIMIT 1;
    DECLARE v_espacio_cursor CURSOR FOR SELECT ID FROM tbc_espacios where Tipo = "Quirófano"  ORDER BY RAND() LIMIT 1;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_paciente_id = NULL, v_espacio_medico_id = NULL;

    WHILE (i <= v_cantidad) DO
        -- Obtener paciente y espacio médico aleatorios
        OPEN v_paciente_cursor;
        FETCH v_paciente_cursor INTO v_paciente_id;
        CLOSE v_paciente_cursor;
        
        OPEN v_espacio_cursor;
        FETCH v_espacio_cursor INTO v_espacio_medico_id;
        CLOSE v_espacio_cursor;
        
        -- Generar datos para la cirugía
        SET v_fecha_registro = CURDATE();
        SET v_tipo_cirugia = ELT(fn_numero_aleatorio_rangos(1, 4), "Ortopédica", "Ginecológica", "Cardíaca", "Neurológica");
        -- SELECCIONAR NIVEL DE URGENCIA ALEATORIA
        SET v_nivel_urgencia = ELT(fn_numero_aleatorio_rangos(1,3), "Bajo", "Medio", "Alto");
        -- SELECCIONAR HORARIO ALEATORIO DE LA CIRUGIA
        SET v_horario = fn_cirugia_horario_aleatorio('00:00:00', '23:59:59');
        -- ASIGNAR AL AZAR VALORACION MEDICA DE LA CIRUGIA
        SET v_valoracion_medica = fn_cirugia_valoracion_medica();
        -- ASIGNAR ESTATUS A CIRUGIA
        SET v_estatus = ELT(fn_numero_aleatorio_rangos(1,4),"Programada", "En curso", "Completada", "Cancelada");
        -- ASIGNAR AL AZAR FECHA DE PROGRAMACION DE CIRUGIA
        SET v_fecha_programacion =  fn_cirugia_fecha_aleatoria('1980-01-01', '2001-01-01');
        -- ASIGNAR AL AZAR FECHA DE REALIZACACION DE CIRUGIA
        SET v_fecha_realizacion = fn_cirugia_fecha_aleatoria('2002-01-01', '2005-01-01');
        -- Asignar una descripción basada en el tipo de cirugía
        CASE v_tipo_cirugia
            WHEN 'Ortopédica' THEN
                SET v_nombre_cirugia = "Reemplazo de Rodilla";
                SET v_descripcion = "Cirugía para reemplazar una articulación de rodilla dañada con una prótesis.";
                SET v_observaciones = "Paciente con antecedentes de artritis severa.";
                SET v_consumible = "Prótesis de rodilla, Instrumental quirúrgico";
            WHEN 'Ginecológica' THEN
                SET v_nombre_cirugia = "Cesárea";
                SET v_descripcion = "Cirugía para el nacimiento de un bebé a través de una incisión en el abdomen y el útero de la madre.";
                SET v_observaciones = "Paciente con antecedentes de parto complicado.";
                SET v_consumible = "Instrumental quirúrgico, Equipo de monitoreo fetal";
            WHEN 'Cardíaca' THEN
                SET v_nombre_cirugia = "Bypass Coronario";
                SET v_descripcion = "Cirugía para redirigir la sangre alrededor de una arteria coronaria bloqueada o parcialmente bloqueada.";
                SET v_observaciones = "Paciente con antecedentes de enfermedad coronaria.";
                SET v_consumible = "Bypass, Instrumental quirúrgico";
            WHEN 'Neurológica' THEN
                SET v_nombre_cirugia = "Resección de Tumor Cerebral";
                SET v_descripcion = "Cirugía para remover un tumor localizado en el lóbulo frontal del cerebro.";
                SET v_observaciones = "Paciente con síntomas de presión intracraneal.";
                SET v_consumible = "Instrumental neuroquirúrgico, Sistema de navegación";
            ELSE
                SET v_descripcion = "Descripción genérica para otro tipo de cirugía.";
        END CASE;
        
        -- Insertar la cirugía en la tabla
        INSERT INTO tbb_cirugias (Paciente_ID, Espacio_Medico_ID, Tipo, Nombre, Descripcion, Nivel_Urgencia, Horario, Observaciones, Valoracion_Medica, Estatus, Consumible, Fecha_Programacion, Fecha_Realizacion, Fecha_Registro, Fecha_Actualizacion) 
        VALUES (v_paciente_id, v_espacio_medico_id, v_tipo_cirugia, v_nombre_cirugia, v_descripcion, v_nivel_urgencia, v_horario, v_observaciones, v_valoracion_medica, v_estatus, v_consumible, v_fecha_programacion, v_fecha_realizacion, v_fecha_registro, NOW());
        
        -- Actualizar datos
             UPDATE tbb_cirugias SET Estatus= 'Completada' WHERE ID = '1';
             UPDATE tbb_cirugias SET Estatus= 'Completada' WHERE ID = '2';
			-- Eliminanar las cirugias con el nombre que contenga Reemplazo de Rodilla
           DELETE FROM tbb_cirugias 
		   WHERE Nombre IN ('Reemplazo de Rodilla');


    
        SET i = i + 1;
    END WHILE;
END
$$
DELIMITER ;


-- Poblar de manera dinamica la tabla de cirugias personal medico
DELIMITER $$
CREATE DEFINER=`brayan.gutierrez`@`%` PROCEDURE `sp_poblar_cirugias_personal_medico_dinamico`(v_cantidad INT)
BEGIN

DECLARE i INT DEFAULT 1;
DECLARE v_personal_medico_id INT;
DECLARE v_cirugia_id INT;
DECLARE v_rol VARCHAR(150);
DECLARE v_fecha_realizacion DATE;
DECLARE v_fecha_registro DATETIME DEFAULT NULL;

-- Crea una variable para guardar el ID de la persona y espacio médico aleatorios
    DECLARE v_personal_medico_cursor CURSOR FOR SELECT Persona_ID FROM tbb_personal_medico ORDER BY RAND() LIMIT 1;
    DECLARE v_cirugia_cursor CURSOR FOR SELECT ID FROM tbb_cirugias ORDER BY RAND() LIMIT 1;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_personal_medico_id = NULL, v_cirugia_id = NULL;

WHILE (i <= v_cantidad) DO
        -- Obtener paciente y espacio médico aleatorios
        OPEN v_personal_medico_cursor;
        FETCH v_personal_medico_cursor INTO v_personal_medico_id;
        CLOSE v_personal_medico_cursor;
        
        OPEN v_cirugia_cursor;
        FETCH v_cirugia_cursor INTO v_cirugia_id;
        CLOSE v_cirugia_cursor;
        
         SET v_fecha_registro = CURDATE();
         SET v_rol = ELT(fn_numero_aleatorio_rangos(1,9),"Cirujano Principal", "Anestesiólogo", "Enfermera Instrumentista",
         "Enfermera Circulante","Técnico en Anestesia", "Técnico Quirúrgico", "Cirujano Residente", "Radiólogo Intervencionista",
         "Perfusionista");
         
          -- Insertar la cirugía en la tabla
        INSERT INTO tbd_cirugias_personal_medico (ID, Personal_Medico_ID, Cirugia_ID, Rol, Estatus, Fecha_Registro, Fecha_Actualizacion) 
        VALUES (DEFAULT, v_personal_medico_id, v_cirugia_id, v_rol, DEFAULT, v_fecha_registro, NOW()   );
		
        -- Actualizar datos
             UPDATE tbd_cirugias_personal_medico SET Estatus = 0  WHERE ID = '1';
        -- Eliminar los datos de cirugias personal medico que contengan 'Técnico Quirúrgico', 'Perfusionista'
		 DELETE FROM tbd_cirugias_personal_medico 
		   WHERE Rol IN ('Técnico Quirúrgico', 'Perfusionista');
        
        SET i = i + 1;
    END WHILE;

END

$$
DELIMITER ;
