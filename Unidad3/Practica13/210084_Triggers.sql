-- Script de Triggers de la tabla tbb_citas_medicas


-- Elaborado por : Janeth Ahuacatitla Amixtlan
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 23 de julio de 2024 


-- Triggers para la tabla de Citas Médicas
-- 1) BEFORE INSERT
CREATE DEFINER=`janeth.ahuacatitla`@`%` TRIGGER `tbb_citas_medicas_BEFORE_INSERT` BEFORE INSERT ON `tbb_citas_medicas` FOR EACH ROW BEGIN
	set new.folio = UUID(); 
END


-- 2) AFTER INSERT
CREATE DEFINER=`janeth.ahuacatitla`@`%` TRIGGER `tbb_citas_medicas_AFTER_INSERT` AFTER INSERT ON `tbb_citas_medicas` FOR EACH ROW BEGIN
    DECLARE v_personal_medico_nombre VARCHAR(255);
    DECLARE v_paciente_nombre VARCHAR(255);
    DECLARE v_servicio_medico_nombre VARCHAR(255);
    DECLARE v_espacio_nombre VARCHAR(100);

    -- Obtener nombres completos para Personal Médico y Paciente
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_personal_medico_nombre 
    FROM tbb_personas 
    WHERE ID = NEW.Personal_medico_ID;
    
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_paciente_nombre 
    FROM tbb_personas 
    WHERE ID = NEW.Paciente_ID;
    
    -- Obtener nombres de Servicio Médico y Espacio
    SELECT Nombre INTO v_servicio_medico_nombre 
    FROM tbc_servicios_medicos 
    WHERE ID = NEW.Servicio_Medico_ID;
    
    SELECT Nombre INTO v_espacio_nombre 
    FROM tbc_espacios 
    WHERE ID = NEW.Espacio_ID;

    -- Registrar la inserción de una nueva cita médica en la bitácora
    INSERT INTO tbi_bitacora VALUES (
       DEFAULT, current_user(), 'Create', 'tbb_citas_medicas',
       CONCAT_WS(" ", 'Se ha agregado una nueva CITA MÉDICA con el ID: ', NEW.ID, '\n',
                 'Personal Médico: ', v_personal_medico_nombre, '\n',
                 'Paciente: ', v_paciente_nombre, '\n',
                 'Servicio Médico: ', v_servicio_medico_nombre, '\n',
                 'Folio: ', NEW.Folio, '\n',
                 'Tipo: ', NEW.Tipo, '\n',
                 'Espacio: ', v_espacio_nombre, '\n',
                 'Fecha Programada: ', NEW.Fecha_Programada, '\n',
                 'Fecha Inicio: ', NEW.Fecha_Inicio, '\n',
                 'Fecha Termino: ', NEW.Fecha_Termino, '\n',
                 'Estatus: ', NEW.estatus, '\n',
                 'Observaciones: ', NEW.Observaciones),
       DEFAULT, DEFAULT
    );
END


-- 3) BEFORE UPDATE
CREATE DEFINER=`janeth.ahuacatitla`@`%` TRIGGER `tbb_citas_medicas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_citas_medicas` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp(); 
END


-- 4) AFTER UPDATE
CREATE DEFINER=`janeth.ahuacatitla`@`%` TRIGGER `tbb_citas_medicas_AFTER_UPDATE` AFTER UPDATE ON `tbb_citas_medicas` FOR EACH ROW BEGIN
    DECLARE v_personal_medico_nombre_old VARCHAR(255);
    DECLARE v_personal_medico_nombre_new VARCHAR(255);
    DECLARE v_paciente_nombre_old VARCHAR(255);
    DECLARE v_paciente_nombre_new VARCHAR(255);
    DECLARE v_servicio_medico_nombre_old VARCHAR(255);
    DECLARE v_servicio_medico_nombre_new VARCHAR(255);
    DECLARE v_espacio_nombre_old VARCHAR(100);
    DECLARE v_espacio_nombre_new VARCHAR(100);

    -- Obtener nombres completos para Personal Médico y Paciente (antes y después)
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_personal_medico_nombre_old 
    FROM tbb_personas 
    WHERE ID = OLD.Personal_medico_ID;
    
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_personal_medico_nombre_new 
    FROM tbb_personas 
    WHERE ID = NEW.Personal_medico_ID;
    
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_paciente_nombre_old 
    FROM tbb_personas 
    WHERE ID = OLD.Paciente_ID;
    
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_paciente_nombre_new 
    FROM tbb_personas 
    WHERE ID = NEW.Paciente_ID;
    
    SELECT Nombre INTO v_servicio_medico_nombre_old 
    FROM tbc_servicios_medicos 
    WHERE ID = OLD.Servicio_Medico_ID;
    
    SELECT Nombre INTO v_servicio_medico_nombre_new 
    FROM tbc_servicios_medicos 
    WHERE ID = NEW.Servicio_Medico_ID;
    
    SELECT Nombre INTO v_espacio_nombre_old 
    FROM tbc_espacios 
    WHERE ID = OLD.Espacio_ID;
    
    SELECT Nombre INTO v_espacio_nombre_new 
    FROM tbc_espacios 
    WHERE ID = NEW.Espacio_ID;

    -- Registrar la actualización de la cita médica en la bitácora
    INSERT INTO tbi_bitacora VALUES (
       DEFAULT, current_user(), 'Update', 'tbb_citas_medicas',
       CONCAT_WS(" ", 'Se ha actualizado la CITA MÉDICA con el ID: ', NEW.ID, '\n',
                 'Personal Médico (anterior): ', v_personal_medico_nombre_old, '\n',
                 'Personal Médico (nuevo): ', v_personal_medico_nombre_new, '\n',
                 'Paciente (anterior): ', v_paciente_nombre_old, '\n',
                 'Paciente (nuevo): ', v_paciente_nombre_new, '\n',
                 'Servicio Médico (anterior): ', v_servicio_medico_nombre_old, '\n',
                 'Servicio Médico (nuevo): ', v_servicio_medico_nombre_new, '\n',
                 'Folio (anterior): ', OLD.Folio, '\n',
                 'Folio (nuevo): ', NEW.Folio, '\n',
                 'Tipo (anterior): ', OLD.Tipo, '\n',
                 'Tipo (nuevo): ', NEW.Tipo, '\n',
                 'Espacio (anterior): ', v_espacio_nombre_old, '\n',
                 'Espacio (nuevo): ', v_espacio_nombre_new, '\n',
                 'Fecha Programada (anterior): ', OLD.Fecha_Programada, '\n',
                 'Fecha Programada (nuevo): ', NEW.Fecha_Programada, '\n',
                 'Fecha Inicio (anterior): ', OLD.Fecha_Inicio, '\n',
                 'Fecha Inicio (nuevo): ', NEW.Fecha_Inicio, '\n',
                 'Fecha Termino (anterior): ', OLD.Fecha_Termino, '\n',
                 'Fecha Termino (nuevo): ', NEW.Fecha_Termino, '\n',
                 'Estatus (anterior): ', OLD.estatus, '\n',
                 'Estatus (nuevo): ', NEW.estatus, '\n',
                 'Observaciones (anterior): ', OLD.Observaciones, '\n',
                 'Observaciones (nuevo): ', NEW.Observaciones),
       DEFAULT, DEFAULT
    );
END


-- 5) AFTER DELETE
CREATE DEFINER=`janeth.ahuacatitla`@`%` TRIGGER `tbb_citas_medicas_AFTER_DELETE` AFTER DELETE ON `tbb_citas_medicas` FOR EACH ROW BEGIN
    DECLARE v_personal_medico_nombre VARCHAR(255);
    DECLARE v_paciente_nombre VARCHAR(255);
    DECLARE v_servicio_medico_nombre VARCHAR(255);
    DECLARE v_espacio_nombre VARCHAR(100);

    -- Obtener nombres completos para Personal Médico y Paciente (del eliminado)
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_personal_medico_nombre 
    FROM tbb_personas 
    WHERE ID = OLD.Personal_medico_ID;
    
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) INTO v_paciente_nombre 
    FROM tbb_personas 
    WHERE ID = OLD.Paciente_ID;
    
    SELECT Nombre INTO v_servicio_medico_nombre 
    FROM tbc_servicios_medicos 
    WHERE ID = OLD.Servicio_Medico_ID;
    
    SELECT Nombre INTO v_espacio_nombre 
    FROM tbc_espacios 
    WHERE ID = OLD.Espacio_ID;

    -- Registrar la eliminación de la cita médica en la bitácora
    INSERT INTO tbi_bitacora VALUES (
       DEFAULT, current_user(), 'Delete', 'tbb_citas_medicas',
       CONCAT_WS(" ", 'Se ha eliminado la CITA MÉDICA con el ID: ', OLD.ID, '\n',
                 'Personal Médico: ', v_personal_medico_nombre, '\n',
                 'Paciente: ', v_paciente_nombre, '\n',
                 'Servicio Médico: ', v_servicio_medico_nombre, '\n',
                 'Folio: ', OLD.Folio, '\n',
                 'Tipo: ', OLD.Tipo, '\n',
                 'Espacio: ', v_espacio_nombre, '\n',
                 'Fecha Programada: ', OLD.Fecha_Programada, '\n',
                 'Fecha Inicio: ', OLD.Fecha_Inicio, '\n',
                 'Fecha Termino: ', OLD.Fecha_Termino, '\n',
                 'Estatus: ', OLD.estatus, '\n',
                 'Observaciones: ', OLD.Observaciones),
       DEFAULT, DEFAULT
    );
END

