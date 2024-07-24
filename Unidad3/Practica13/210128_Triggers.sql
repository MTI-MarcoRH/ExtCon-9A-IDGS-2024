-- TRIGGERS DE TABLAS ASIGNADAS

-- Elaborado por: Jonathan Enrique Ibarra Canales
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de Personal Médico
-- 1) AFTER INSERT PERSONAL MÉDICO

DELIMITER &&
CREATE DEFINER=`jonathan.ibarra`@`%` TRIGGER `tbb_personal_medico_AFTER_INSERT` AFTER INSERT ON `tbb_personal_medico` FOR EACH ROW BEGIN
    DECLARE persona_nombre_completo VARCHAR(255);
    DECLARE departamento_nombre VARCHAR(255);

    -- Obtener el nombre completo de la persona
    SELECT CONCAT_WS(' ',Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) 
    INTO persona_nombre_completo 
    FROM tbb_personas 
    WHERE ID = NEW.Persona_ID;
    
    -- Obtener el nombre del departamento
    SELECT nombre 
    INTO departamento_nombre 
    FROM tbc_departamentos 
    WHERE ID = NEW.Departamento_ID;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES
    (
        DEFAULT,
        current_user(),
        'Create',
        'tbb_personal_medico',
        CONCAT_WS(' ',
            'Se ha creado nuevo personal medico con los siguientes datos:', '\n',
            'Nombre de la Persona: ', persona_nombre_completo, '\n',
            'Nombre del Departamento: ', departamento_nombre, '\n',
            'Especialidad: ', NEW.Especialidad, '\n',
            'Tipo: ', NEW.Tipo, '\n',
            'Cedula Profesional: ', NEW.Cedula_Profesional, '\n',
            'Estatus: ', NEW.Estatus, '\n',
            'Fecha de Contratación: ', NEW.Fecha_Contratacion, '\n',
            'Salario: ', NEW.Salario, '\n',
            'Fecha de Actualización: ', NEW.Fecha_Actualizacion, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END

&&
DELIMITER ;




-- 2. BEFORE UPDATE PERSONAL MÉDICO
DELIMITER &&
CREATE DEFINER=`jonathan.ibarra`@`%` TRIGGER `tbb_personal_medico_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_personal_medico` FOR EACH ROW BEGIN
	SET new.Fecha_Actualizacion = current_timestamp();
END
&&
DELIMITER ;


-- 3. AFTER UPDATE PERSONAL MÉDICO
DELIMITER &&
CREATE DEFINER=`jonathan.ibarra`@`%` TRIGGER `tbb_personal_medico_AFTER_UPDATE` AFTER UPDATE ON `tbb_personal_medico` FOR EACH ROW BEGIN
 DECLARE old_persona_nombre_completo VARCHAR(255);
    DECLARE new_persona_nombre_completo VARCHAR(255);
    DECLARE old_departamento_nombre VARCHAR(255);
    DECLARE new_departamento_nombre VARCHAR(255);

    -- Obtener el nombre completo de la persona antes de la actualización
    SELECT CONCAT_WS(' ', Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) 
    INTO old_persona_nombre_completo 
    FROM tbb_personas 
    WHERE ID = OLD.Persona_ID;
    
    -- Obtener el nombre completo de la persona después de la actualización
    SELECT CONCAT_WS(' ', Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) 
    INTO new_persona_nombre_completo 
    FROM tbb_personas 
    WHERE ID = NEW.Persona_ID;

    -- Obtener el nombre del departamento antes de la actualización
    SELECT nombre 
    INTO old_departamento_nombre 
    FROM tbc_departamentos 
    WHERE ID = OLD.Departamento_ID;
    
    -- Obtener el nombre del departamento después de la actualización
    SELECT nombre 
    INTO new_departamento_nombre 
    FROM tbc_departamentos 
    WHERE ID = NEW.Departamento_ID;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES
    (
        DEFAULT,
        current_user(),
        'Update',
        'tbb_personal_medico',
        concat_ws(' ',
            'Se ha modificado el personal médico con los siguientes datos:', '\n',
            'Nombre de la Persona: ', old_persona_nombre_completo, ' -> ', new_persona_nombre_completo, '\n',
            'Nombre del Departamento: ', old_departamento_nombre, ' -> ', new_departamento_nombre, '\n',
            'Especialidad: ', OLD.Especialidad, ' -> ', NEW.Especialidad, '\n',
            'Tipo: ', OLD.Tipo, ' -> ', NEW.Tipo, '\n',
            'Cédula Profesional: ', OLD.Cedula_Profesional, ' -> ', NEW.Cedula_Profesional, '\n',
            'Estatus: ', OLD.Estatus, ' -> ', NEW.Estatus, '\n',
            'Fecha de Contratación: ', OLD.Fecha_Contratacion, ' -> ', NEW.Fecha_Contratacion, '\n',
            'Salario: ', OLD.Salario, ' -> ', NEW.Salario, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END
&&
DELIMITER ;


-- 4. AFTER DELETE PERSONAL MÉDICO
DELIMITER &&
CREATE DEFINER=`jonathan.ibarra`@`%` TRIGGER `tbb_personal_medico_AFTER_DELETE` AFTER DELETE ON `tbb_personal_medico` FOR EACH ROW BEGIN
 DECLARE persona_nombre_completo VARCHAR(255);
    DECLARE departamento_nombre VARCHAR(255);

    -- Obtener el nombre completo de la persona
    SELECT CONCAT_WS(' ', Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido) 
    INTO persona_nombre_completo 
    FROM tbb_personas 
    WHERE ID = OLD.Persona_ID;
    
    -- Obtener el nombre del departamento
    SELECT nombre 
    INTO departamento_nombre 
    FROM tbc_departamentos 
    WHERE ID = OLD.Departamento_ID;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora VALUES
    (
        DEFAULT,
        current_user(),
        'Delete',
        'tbb_personal_medico',
        CONCAT_WS(' ',
            'Se ha eliminado personal médico existente con los siguientes datos:',
            '\nNombre de la Persona: ', persona_nombre_completo,
            '\nNombre del Departamento: ', departamento_nombre,
            '\nEspecialidad: ', OLD.Especialidad,
            '\nTipo: ', OLD.Tipo,
            'Cédula Profesional: ', OLD.Cedula_Profesional,
            '\nEstatus: ', OLD.Estatus,
            '\nFecha de Contratación: ', OLD.Fecha_Contratacion,
            '\nSalario: ', OLD.Salario
        ),
        DEFAULT,
        DEFAULT
    );
END
&&
DELIMITER ;


-- Triggers para la tabla de DEPARTAMENTOS

-- 1) AFTER INSERT DEPARTAMENTOS
DELIMITER &&
CREATE DEFINER=`jonathan.ibarra`@`%` TRIGGER `tbc_departamentos_AFTER_INSERT` AFTER INSERT ON `tbc_departamentos` FOR EACH ROW BEGIN
    DECLARE persona_responsable_nombre_completo VARCHAR(255);
    DECLARE departamento_superior_nombre VARCHAR(255);
    DECLARE area_medica_nombre VARCHAR(255);

    -- Obtener el nombre de la persona responsable
    IF NEW.Responsable_ID IS NOT NULL THEN
        SELECT CONCAT_WS(' ',Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido)
        INTO persona_responsable_nombre_completo
        FROM tbb_personas
        WHERE ID = NEW.Responsable_ID;
    ELSE
        SET persona_responsable_nombre_completo = 'No se registro Responsable';
    END IF;

    -- Obtener el nombre del departamento superior
    IF NEW.Departamento_Superior_ID IS NOT NULL THEN
        SELECT Nombre
        INTO departamento_superior_nombre
        FROM tbc_departamentos
        WHERE ID = NEW.Departamento_Superior_ID;
    ELSE
        SET departamento_superior_nombre = 'No se registro departamento Superior';
    END IF;

    -- Obtener el nombre del área médica
    IF NEW.AreaMedica_ID IS NOT NULL THEN
        SELECT Nombre
        INTO area_medica_nombre
        FROM tbc_areas_medicas
        WHERE ID = NEW.AreaMedica_ID;
    ELSE
        SET area_medica_nombre = 'No se registro area Médica';
    END IF;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES
    (
        DEFAULT,
        current_user(),
        'Create',
        'tbc_departamentos',
        CONCAT_WS(' ',
            'Se ha creado nuevo departamento con los siguientes datos:', '\n',
            'Nombre del Departamento: ', NEW.Nombre, '\n',
            'Area Medica: ', area_medica_nombre, '\n',
            'Departamento Superior: ', departamento_superior_nombre, '\n',
            'Responsable: ', persona_responsable_nombre_completo, '\n',
            'Estatus: ', NEW.Estatus, '\n',
            'Fecha de Registro: ', NEW.Fecha_Registro, '\n',
            'Fecha de Actualización: ', NEW.Fecha_Actualizacion, '\n'
        ),
        DEFAULT,
        DEFAULT
    );
END

&&
DELIMITER ;

-- 2. BEFORE UPDATE DEPARTAMENTOS
DELIMITER &&
CREATE DEFINER=`root`@`localhost` TRIGGER `tbc_departamentos_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_departamentos` FOR EACH ROW BEGIN
	SET new.Fecha_Actualizacion = current_timestamp();
END

&&
DELIMITER ;

-- 3. AFTER UPDATE DEPARTAMENTOS
DELIMITER &&
CREATE DEFINER=`root`@`localhost` TRIGGER `tbc_departamentos_AFTER_UPDATE` AFTER UPDATE ON `tbc_departamentos` FOR EACH ROW BEGIN
	
    DECLARE old_area_medica_nombre VARCHAR(255);
    DECLARE new_area_medica_nombre VARCHAR(255);
    DECLARE old_departamento_superior_nombre VARCHAR(255);
    DECLARE new_departamento_superior_nombre VARCHAR(255);
    DECLARE old_responsable_nombre_completo VARCHAR(255);
    DECLARE new_responsable_nombre_completo VARCHAR(255);


    -- Obtener el nombre del área médica antes de la actualización
    IF OLD.AreaMedica_ID IS NOT NULL THEN
        SELECT nombre
        INTO old_area_medica_nombre
        FROM tbc_areas_medicas
        WHERE ID = OLD.AreaMedica_ID;
    ELSE
        SET old_area_medica_nombre = 'No se registro área médica';
    END IF;

    -- Obtener el nombre del área médica después de la actualización
    IF NEW.AreaMedica_ID IS NOT NULL THEN
        SELECT nombre
        INTO new_area_medica_nombre
        FROM tbc_areas_medicas
        WHERE ID = NEW.AreaMedica_ID;
    ELSE
        SET new_area_medica_nombre = 'No se registro área médica';
    END IF;

    -- Obtener el nombre del departamento superior antes de la actualización
    IF OLD.Departamento_Superior_ID IS NOT NULL THEN
        SELECT nombre
        INTO old_departamento_superior_nombre
        FROM tbc_departamentos
        WHERE ID = OLD.Departamento_Superior_ID;
    ELSE
        SET old_departamento_superior_nombre = 'No se registro departamento Superior';
    END IF;

    -- Obtener el nombre del departamento superior después de la actualización
    IF NEW.Departamento_Superior_ID IS NOT NULL THEN
        SELECT nombre
        INTO new_departamento_superior_nombre
        FROM tbc_departamentos
        WHERE ID = NEW.Departamento_Superior_ID;
    ELSE
        SET new_departamento_superior_nombre = 'No se registro departamento Superior';
    END IF;

    -- Obtener el nombre del responsable antes de la actualización
    IF OLD.Responsable_ID IS NOT NULL THEN
        SELECT CONCAT_WS(' ',Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido)
        INTO old_responsable_nombre_completo
        FROM tbb_personas
        WHERE ID = OLD.Responsable_ID;
    ELSE
        SET old_responsable_nombre_completo = 'N/A';
    END IF;

    -- Obtener el nombre del responsable después de la actualización
    IF NEW.Responsable_ID IS NOT NULL THEN
        SELECT CONCAT_WS(' ',Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido)
        INTO new_responsable_nombre_completo
        FROM tbb_personas
        WHERE ID = NEW.Responsable_ID;
    ELSE
        SET new_responsable_nombre_completo = 'N/A';
    END IF;

    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES
    (
        DEFAULT,
        current_user(),
        'Update',
        'tbc_departamentos',
        CONCAT_WS(' ',
            'Se ha modificado el departamento con los siguientes datos:', '\n',
            'Nombre del departamento: ', OLD.Nombre, ' -> ', NEW.Nombre, '\n',
            'Area Medica: ', old_area_medica_nombre, ' -> ', new_area_medica_nombre, '\n',
             'Departamento Superior: ', old_departamento_superior_nombre, ' -> ', new_departamento_superior_nombre, '\n',
			'Estatus: ', OLD.Estatus, ' -> ', NEW.Estatus, '\n',
            'Fecha de actualizacion: ', NEW.Fecha_Actualizacion
               ),
        DEFAULT,
        DEFAULT
    );
END

&&
DELIMITER ;

-- 4. AFTER DELETE DEPARTAMENTOS

DELIMITER &&

CREATE DEFINER=`root`@`localhost` TRIGGER `tbc_departamentos_BEFORE_DELETE` BEFORE DELETE ON `tbc_departamentos` FOR EACH ROW BEGIN

    DECLARE area_medica_nombre VARCHAR(255);
    DECLARE departamento_superior_nombre VARCHAR(255);
    DECLARE responsable_nombre_completo VARCHAR(255);



    -- Obtener el nombre del área médica
    
     IF OLD.AreaMedica_ID IS NOT NULL THEN
        SELECT nombre
        INTO area_medica_nombre
        FROM tbc_areas_medicas
        WHERE ID = OLD.AreaMedica_ID;
    ELSE
        SET area_medica_nombre = 'No se registro área médica';
    END IF;   



    -- Obtener el nombre del departamento superior
    IF OLD.Departamento_Superior_ID IS NOT NULL THEN
        SELECT nombre
        INTO departamento_superior_nombre
        FROM tbc_departamentos
        WHERE ID = OLD.Departamento_Superior_ID;
    ELSE
        SET departamento_superior_nombre = 'No se registro departamento Superior';
    END IF;
    


    -- Obtener el nombre del responsable
    
	IF OLD.Responsable_ID IS NOT NULL THEN
        SELECT CONCAT_WS(' ',Nombre, ' ', Primer_Apellido, ' ', Segundo_Apellido)
        INTO responsable_nombre_completo
        FROM tbb_personas
        WHERE ID = OLD.Responsable_ID;
    ELSE
        SET responsable_nombre_completo = 'N/A';
    END IF;
 



    -- Insertar en la bitácora
    INSERT INTO tbi_bitacora
    VALUES
    (
        DEFAULT,
        current_user(),
        'Delete',
        'tbc_departamentos',
        CONCAT_WS(' ',
            'Se ha eliminado el departamento con los siguientes datos:', '\n',
            'Nombre del Departamento: ', old.Nombre, '\n',
            'Area Medica: ', area_medica_nombre, '\n',
            'Departamento Superior: ', departamento_superior_nombre, '\n',
            'Responsable: ', responsable_nombre_completo, '\n'
	
        ),
        DEFAULT,
        DEFAULT
    );
END
&&
DELIMITER ;