-- Script de POBLACION DE SERVICIOS MEDICOS Y DEPARTAMENTOS SERVICIOS
-- ALEXIS GOMEZ
-- Grado y Grupo: 9 A
-- Ingenieria de Desarrollo  y Gestion de Software
 



CREATE DEFINER=`alexis.gomez`@`%` PROCEDURE `sp_poblar_servicios_medicos`(v_password VARCHAR(20))
BEGIN
 IF v_password = "1234" THEN
        -- Insertar nuevos registros en tbc_servicio_medico
        INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
        VALUES ('Consulta Médica General', 'Revisión general del paciente por parte de un médico autorizado', 'Horario de Atención de 08:00 a 20:00');

        -- Se asignan los servicios al departamento que los brinda
        INSERT INTO tbd_departamentos_servicios VALUES
        (17, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT, NULL),
        (40, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT, NULL);
		
        
        
        INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
        VALUES ('Consulta Médica Especializada', 'Revisión médica de especialidad', 'Previa cita, asignada despúes de una revisión general');
        
         -- Se asignan los servicios al departamento que los brinda
        INSERT INTO tbd_departamentos_servicios VALUES
        (10, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (11, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (12, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (13, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (14, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (15, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL);
        
		
        
        INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
        VALUES ('Consulta Médica a Domicilio', 'Revision médica en el domicilio del paciente', 'Solo para casos de extrema urgencia');
        
		INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
		VALUES ('Examen Físico Completo', 'Examen detallado de salud física del paciente', 'Asistir con ropa lijera y 6 a 8 de horas
        de ayuno previo');

		INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
		VALUES ('Extracción de Sangre', 'Toma de muestra para análisis de sangre', 'Ayuno previo, muestras antes de las 10:00 a.m.');
        
        -- Se agrega un nuevo servicio medico
        INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
        VALUES ('Parto Natural', 'Asistencia en el proceso de alumbramiento de un bebé', 'Sin observaciones');
        -- Asignamos el departamento que brinda ese servicio.
        INSERT INTO tbd_departamentos_servicios VALUES
        (13, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (14, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL);
               
        
        INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
        VALUES ('Estudio de Desarrollo Infantil', 'Valoración de Crecimiento del Infante', 'Mediciones de Talla, Peso y Nutrición');
        INSERT INTO tbd_departamentos_servicios VALUES
        (13, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL);
        
        INSERT INTO tbc_servicios_medicos (nombre, descripcion, observaciones)
        VALUES ('Toma de Signos Vitales', 'Registro de Talla, Peso, Temperatura, Oxigenación en la Sangre , Frecuencia Cardiaca 
        (Sistólica y  Diastólica, Frecuencia Respiratoria', 'Necesarias para cualquier servicio médico.');
        INSERT INTO tbd_departamentos_servicios VALUES
        (13, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL), 
        (14, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (12, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (25, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL),
        (23, last_insert_id(), "Ayuno previo de 1 hr.", "Sin restricciones", DEFAULT, DEFAULT,NULL);
        
        DELETE FROM tbd_departamentos_servicios WHERE departamento_id=25;
        UPDATE tbd_departamentos_servicios SET Estatus=b'0' WHERE departamento_id=23;
        
        
        
        

        -- Actualizar un registro en tbc_servicio_medico
        UPDATE tbc_servicios_medicos 
        SET nombre="Estudio de Química Sanguínea" WHERE nombre='Extracción de Sangre';
        
        -- Eliminar un registro en tbc_servicio_medico
        DELETE FROM tbc_servicios_medicos WHERE nombre = 'Consulta Médica a Domicilio';
        
        
        
        

    ELSE 
        SELECT "La contraseña es incorrecta, no se puede realizar modificación en la tabla Servicio Medico" AS ErrorMessage;
    END IF;
END