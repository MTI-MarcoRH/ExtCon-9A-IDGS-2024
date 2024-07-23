-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Carlos Martin Hernández de Jesús
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de Solicitudes
-- 1) AFTER INSERT SOLICITUDES
DELIMITER &&
CREATE DEFINER=`Carlos.Hernandez`@`%` TRIGGER `tbd_solicitudes_AFTER_INSERT` AFTER INSERT ON `tbd_solicitudes` FOR EACH ROW BEGIN
   DECLARE nombre_paciente VARCHAR(150) DEFAULT NULL;
   DECLARE nombre_medico VARCHAR(100) DEFAULT NULL;
   DECLARE nombre_servicio VARCHAR(100) DEFAULT NULL;
   DECLARE v_estatus_aprobacion VARCHAR(20) DEFAULT 'Activo';

   -- Validamos el estatus del registro y le asignamos una etiqueta para la descripcion
   IF NOT NEW.Estatus_Aprobacion THEN
      SET v_estatus_aprobacion = 'Inactivo';
   END IF;

   -- Obtener el nombre del paciente recién insertado
   SET nombre_paciente = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                         FROM tbb_personas p
                         WHERE p.id = NEW.paciente_ID);

   -- Obtener el nombre del personal médico recién insertado
   SET nombre_medico = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                         FROM tbb_personas p
                         WHERE p.id = NEW.medico_ID);
                         
   -- Obtener el nombre del servicio recién insertado
   SET nombre_servicio = (SELECT nombre FROM tbc_servicios_medicos s WHERE s.id = NEW.servicio_ID);

   INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) VALUES (
      CURRENT_USER(), 
      'Create', 
      'tbd_solicitudes', 
      CONCAT_WS(" ", 'Se ha creado una nueva solicitud con los siguientes datos: ',
      'Nombre del Paciente: ', nombre_paciente, '\n',
      'Nombre del Medico: ', nombre_medico, '\n',
      'Nombre del Servicio: ', nombre_servicio, '\n',
      'Prioridad: ', NEW.Prioridad, '\n',
      'Descripcion: ', NEW.Descripcion, '\n',
      'Estatus de la solicitud: ', NEW.Estatus, '\n',
      'Estatus de Aprobación: ', v_estatus_aprobacion),
      DEFAULT,
      DEFAULT);
END
&&
DELIMITER ;

-- 2) BEFORE UPDATE
DELIMITER &&
CREATE DEFINER=`Carlos.Hernandez`@`%` TRIGGER `tbd_solicitudes_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_solicitudes` FOR EACH ROW BEGIN
   SET NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
END
&&
DELIMITER ;


-- 3) AFTER UPDATE
DELIMITER &&
&&
CREATE DEFINER=`Carlos.Hernandez`@`%` TRIGGER `tbd_solicitudes_AFTER_UPDATE` AFTER UPDATE ON `tbd_solicitudes` FOR EACH ROW BEGIN
   DECLARE nombre_paciente_new VARCHAR(150) DEFAULT NULL;
   DECLARE nombre_medico_new VARCHAR(100) DEFAULT NULL;
   DECLARE nombre_servicio_new VARCHAR(100) DEFAULT NULL;
   DECLARE nombre_paciente_old VARCHAR(150) DEFAULT NULL;
   DECLARE nombre_medico_old VARCHAR(100) DEFAULT NULL;
   DECLARE nombre_servicio_old VARCHAR(100) DEFAULT NULL;
   DECLARE v_estatus_aprobacion_old VARCHAR(20) DEFAULT 'Activo';
   DECLARE v_estatus_aprobacion_new VARCHAR(20) DEFAULT 'Activo';
   
   -- Validamos el estatus del registro antiguo y nuevo y les asignamos una etiqueta para la descripción
   IF NOT OLD.Estatus_Aprobacion THEN
      SET v_estatus_aprobacion_old = 'Inactivo';
   END IF;

   IF NOT NEW.Estatus_Aprobacion THEN
      SET v_estatus_aprobacion_new = 'Inactivo';
   END IF;

   -- Obtener el nombre del paciente antes y después de la actualización
   SET nombre_paciente_new = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                             FROM tbb_personas p
                             WHERE p.id = NEW.paciente_ID);
   SET nombre_paciente_old = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                             FROM tbb_personas p
                             WHERE p.id = OLD.paciente_ID);

   -- Obtener el nombre del personal medico antes y después de la actualización
   SET nombre_medico_new = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                           FROM tbb_personas p
                           WHERE p.id = NEW.medico_ID);
   SET nombre_medico_old = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                           FROM tbb_personas p
                           WHERE p.id = OLD.medico_ID);
                         
   -- Obtener el nombre del servicio antes y después de la actualización
   SET nombre_servicio_new = (SELECT nombre FROM tbc_servicios_medicos s WHERE s.id = NEW.servicio_ID);
   SET nombre_servicio_old = (SELECT nombre FROM tbc_servicios_medicos s WHERE s.id = OLD.servicio_ID);

   INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) VALUES (
      CURRENT_USER(), 
      'Update', 
      'tbd_solicitudes', 
      CONCAT_WS(" ", 'Se ha modificado una solicitud con los siguientes datos:',
      'Nombre del Paciente: ', nombre_paciente_old, ' - ', nombre_paciente_new, '\n',
      'Nombre del Medico: ', nombre_medico_old, ' - ', nombre_medico_new, '\n',
      'Nombre del Servicio: ', nombre_servicio_old, ' - ', nombre_servicio_new, '\n',
      'Prioridad: ', OLD.Prioridad, ' - ', NEW.Prioridad, '\n',
      'Descripcion: ', OLD.Descripcion, ' - ', NEW.Descripcion, '\n',
      'Estatus de la solicitud: ', OLD.Estatus, ' - ', NEW.Estatus, '\n',
      'Estatus de Aprobación: ', v_estatus_aprobacion_old, ' - ',v_estatus_aprobacion_new),
      DEFAULT,
      DEFAULT);
END
DELIMITER ;

-- 4) AFTER DELETE
DELIMITER &&
&&
CREATE DEFINER=`Carlos.Hernandez`@`%` TRIGGER `tbd_solicitudes_AFTER_DELETE` AFTER DELETE ON `tbd_solicitudes` FOR EACH ROW BEGIN
   DECLARE nombre_paciente VARCHAR(150) DEFAULT NULL;
   DECLARE nombre_medico VARCHAR(100) DEFAULT NULL;
   DECLARE nombre_servicio VARCHAR(100) DEFAULT NULL;
   DECLARE v_estatus_aprobacion VARCHAR(20) DEFAULT 'Activo';
   
   -- Validamos el estatus del registro y le asignamos una etiqueta para la descripción
   IF NOT OLD.Estatus_Aprobacion THEN
      SET v_estatus_aprobacion = 'Inactivo';
   END IF;

   -- Obtener el nombre del paciente eliminado
   SET nombre_paciente = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                         FROM tbb_personas p
                         WHERE p.id = OLD.paciente_ID);

   -- Obtener el nombre del médico eliminado
   SET nombre_medico = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                         FROM tbb_personas p
                         WHERE p.id = OLD.medico_ID);

   -- Obtener el nombre del servicio eliminado
   SET nombre_servicio = (SELECT nombre FROM tbc_servicios_medicos s WHERE s.id = OLD.servicio_ID);

   INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) VALUES (
      CURRENT_USER(), 
      'Delete', 
      'tbd_solicitudes', 
      CONCAT_WS(" ", 'Se ha eliminado una solicitud existente con los siguientes datos: ',
      'ID: ', OLD.ID, '\n',
      'Nombre del Paciente: ', nombre_paciente, '\n',
      'Nombre del Medico: ', nombre_medico, '\n',
      'Nombre del Servicio: ', nombre_servicio, '\n',
      'Prioridad: ', OLD.Prioridad, '\n',
      'Descripcion: ', OLD.Descripcion, '\n',
      'Estatus de la solicitud: ', OLD.Estatus, '\n',
      'Estatus de Aprobación: ', v_estatus_aprobacion),
      DEFAULT,
      DEFAULT);
END
DELIMITER ;




