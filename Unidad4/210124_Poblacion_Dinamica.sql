-- SCRIPT DE CREACIÓN Y POBLACIÓN DE TABLAS ASIGNADAS DE MANERA DINAMICA

-- Elaborado por: Armando Carrasco Vargas
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  04 de Agosto de 2023

-- Queries para revisión y población de la tabla: Estudios

-- 1. Verificar la construcción de las tablas
DESC tbd_resultados_estudios; 

-- 2. Poblar de manera estática las tablas
call sp_poblar_personal_medico("xyz#$%");
call sp_poblar_pacientes("1234");
call sp_poblar_estudios("123");
CALL sp_poblar_resultados_estudios_dinamica(10, '1234');

-- 3. Verificamos el registro de los eventos en bitácora para resultados de estudios
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_resultados_estudios" ORDER BY ID DESC;

-- 4. Realizamos una consulta JOIN para visualizar los datos poblados en resultados de estudios
SELECT re.ID, re.Folio, re.Resultados, re.Observaciones, re.Estatus, 
CONCAT_WS(' ', NULLIF(pac.Titulo, ""), pac.Nombre, pac.Primer_Apellido, pac.Segundo_Apellido) as NombreCompletoPaciente,
CONCAT_WS(' ', NULLIF(pm.Titulo, ""), pm.Nombre, pm.Primer_Apellido, pm.Segundo_Apellido) as NombreCompletoMedico,
es.Tipo as TipoEstudio
FROM tbd_resultados_estudios re
JOIN tbb_personas pac ON re.Paciente_ID = pac.ID
JOIN tbb_personas pm ON re.Personal_Medico_ID = pm.ID
JOIN tbc_estudios es ON re.Estudio_ID = es.ID;


---- SCRIPT DE POBLACION DINAMICA------------
DELIMITER $$
CREATE DEFINER=`armando.carrasco`@`%` PROCEDURE `sp_poblar_resultados_estudios_dinamica`(IN cantidad INT, IN v_password VARCHAR(60))
BEGIN
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_paciente INT;
    DECLARE v_medico INT;
    DECLARE v_estudio INT;
    DECLARE v_estatus ENUM('Pendiente', 'En Proceso', 'Completado', 'Aprobado', 'Rechazado');
    DECLARE v_resultados TEXT;
    DECLARE v_observaciones TEXT;

    IF v_password = '1234' THEN
        WHILE v_i < cantidad DO
            -- Seleccionar aleatoriamente un paciente, un médico y un estudio
            SET v_paciente = (SELECT Persona_ID FROM tbb_pacientes ORDER BY RAND() LIMIT 1);
            SET v_medico = (SELECT Persona_ID FROM tbb_personal_medico ORDER BY RAND() LIMIT 1);
            SET v_estudio = (SELECT ID FROM tbc_estudios ORDER BY RAND() LIMIT 1);

            -- Seleccionar aleatoriamente un estatus
            SET v_estatus = ELT(fn_numero_aleatorio_rangos(1, 5), 'Pendiente', 'En Proceso', 'Completado', 'Aprobado', 'Rechazado');

            -- Seleccionar aleatoriamente resultados y observaciones
            SET v_resultados = ELT(fn_numero_aleatorio_rangos(1, 3), 
                'Resultados del estudio: Normal',
                'Resultados del estudio: Anomalías detectadas',
                'Resultados del estudio: Requiere seguimiento adicional'
            );

            SET v_observaciones = ELT(fn_numero_aleatorio_rangos(1, 3), 
                'Observaciones: Ninguna',
                'Observaciones: Paciente necesita volver en 6 meses',
                'Observaciones: Requiere tratamiento inmediato'
            );

            -- Insertar el nuevo registro en la tabla tbd_resultados_estudios
            INSERT INTO tbd_resultados_estudios (
                Paciente_ID, Personal_Medico_ID, Estudio_ID, Folio, Resultados, Observaciones, Estatus, Fecha_Registro
            ) VALUES (
                v_paciente, v_medico, v_estudio, UUID(), v_resultados, v_observaciones, v_estatus, DEFAULT
            );

            SET v_i = v_i + 1;
        END WHILE;
    ELSE
        -- Mensaje de error si la contraseña es incorrecta
        SELECT 'La contraseña es incorrecta, no puede realizar cambios en la Base de Datos' AS ErrorMessage;
    END IF;
END$$
DELIMITER ;