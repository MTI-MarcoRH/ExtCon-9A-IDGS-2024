-- SCRIP DE CREACIÓN DE LOS TRIGGERS DE LA TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 23 de Julio del 2024

-- Triggers de la Tabla: tbb_personas


-- 1.- Trigger AFTER INSERT on tbb_personas
DELIMITER $$

CREATE DEFINER=`jose.gomez`@`%` TRIGGER `tbb_personas_AFTER_INSERT` 
AFTER INSERT ON `tbb_personas` 
FOR EACH ROW 
BEGIN
    -- Declaramos variables para almacenar el nombre completo de la persona y el estatus
    DECLARE nombre_persona VARCHAR(255);
    DECLARE v_estatus VARCHAR(20) DEFAULT 'Activo';

    -- Validamos el estatus del registro y le asignamos una etiqueta para la descripción
    IF NOT new.Estatus THEN
        SET v_estatus = 'Inactivo';
    END IF;

    -- Obtenemos el nombre completo de la persona recién insertada
    SET nombre_persona = (SELECT CONCAT_WS(" ", p.Nombre, p.Primer_Apellido, p.Segundo_Apellido)
                         FROM tbb_personas p
                         WHERE p.id = NEW.ID);

    -- Registramos la inserción de una nueva persona en la bitácora
    INSERT INTO tbi_bitacora VALUES (
        DEFAULT, current_user(), 'Create', 'tbb_personas',
        CONCAT_WS(" ", 'Se ha agregado una nueva PERSONA con el ID: ', NEW.ID, '\n',
                 'Nombre: ', nombre_persona, '\n',
                 'Titulo: ', NEW.Titulo, '\n',
                 'Primer Apellido: ', NEW.Primer_Apellido, '\n',
                 'Segundo Apellido: ', NEW.Segundo_Apellido, '\n',
                 'CURP: ', NEW.CURP, '\n',
                 'Genero: ', NEW.Genero, '\n',
                 'Grupo Sanguineo: ', NEW.Grupo_Sanguineo, '\n',
                 'Fecha de Nacimiento: ', NEW.Fecha_Nacimiento, '\n',
                 'Estatus: ', v_estatus),
        DEFAULT, DEFAULT
    );
END $$

DELIMITER ;

-- 2) BEFORE UPDATE
DELIMITER $$
CREATE DEFINER=`jose.gomez`@`%` TRIGGER `tbb_personas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_personas` FOR EACH ROW BEGIN
    SET NEW.Fecha_actualizacion = CURRENT_TIMESTAMP();
END $$ 
DELIMITER ;

-- 3.- Trigger AFTER UPDATE on tbb_personas
DELIMITER $$

CREATE DEFINER=`jose.gomez`@`%` TRIGGER `tbb_personas_AFTER_UPDATE` 
AFTER UPDATE ON `tbb_personas` 
FOR EACH ROW 
BEGIN
    -- Declaramos variables para almacenar los nombres completos y estatus antiguos y nuevos
    DECLARE nombre_persona_old VARCHAR(255);
    DECLARE nombre_persona_new VARCHAR(255);
    DECLARE v_estatus_old VARCHAR(20) DEFAULT 'Activo';
    DECLARE v_estatus_new VARCHAR(20) DEFAULT 'Activo';

    -- Validamos el estatus del registro antiguo y nuevo y les asignamos una etiqueta para la descripción
    IF NOT OLD.Estatus THEN
        SET v_estatus_old = 'Inactivo';
    END IF;

    IF NOT NEW.Estatus THEN
        SET v_estatus_new = 'Inactivo';
    END IF;

    -- Obtenemos el nombre completo de la persona antes y después de la actualización
    SET nombre_persona_old = CONCAT_WS(" ", OLD.Nombre, OLD.Primer_Apellido, OLD.Segundo_Apellido);
    SET nombre_persona_new = CONCAT_WS(" ", NEW.Nombre, NEW.Primer_Apellido, NEW.Segundo_Apellido);

    -- Registramos en la bitácora la actualización de una persona
    INSERT INTO tbi_bitacora VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Update',
        'tbb_personas',
        CONCAT_WS(
            " ",
            'Se han actualizado los datos de la PERSONA con el ID:', OLD.ID, '\n',
            'Nombre Antiguo:', nombre_persona_old, '\n',
            'Nombre Nuevo:', nombre_persona_new, '\n',
            'Titulo:', NEW.Titulo, '\n',
            'Primer Apellido:', NEW.Primer_Apellido, '\n',
            'Segundo Apellido:', NEW.Segundo_Apellido, '\n',
            'CURP:', NEW.CURP, '\n',
            'Genero:', NEW.Genero, '\n',
            'Grupo Sanguineo:', NEW.Grupo_Sanguineo, '\n',
            'Fecha de Nacimiento:', NEW.Fecha_Nacimiento, '\n',
            'Estatus Antiguo:', v_estatus_old, '\n',
            'Estatus Nuevo:', v_estatus_new
        ),
        DEFAULT, DEFAULT
    );
END $$

DELIMITER ;

-- 4.- Trigger AFTER DELETE on tbb_personas
DELIMITER $$

CREATE DEFINER=`jose.gomez`@`%` TRIGGER `tbb_personas_AFTER_DELETE` 
AFTER DELETE ON `tbb_personas` 
FOR EACH ROW 
BEGIN
    -- Declaramos variable para almacenar el estatus
    DECLARE v_estatus VARCHAR(20) DEFAULT 'Activo';
    
    -- Validamos el estatus del registro y le asignamos una etiqueta para la descripción
    IF NOT OLD.Estatus THEN
        SET v_estatus = 'Inactivo';
    END IF;

    -- Registramos en la bitácora la eliminación de una persona
    INSERT INTO tbi_bitacora VALUES (
        DEFAULT, 
        CURRENT_USER(), 
        'Delete', 
        'tbb_personas', 
        CONCAT_WS(
            ' ', 
            'Se ha eliminado la PERSONA con el ID:', OLD.ID, '\n'
            'Nombre:', OLD.Nombre, '\n'
            'Primer Apellido:', OLD.Primer_Apellido, '\n'
            'Segundo Apellido:', OLD.Segundo_Apellido, '\n'
            'CURP:', OLD.CURP, '\n'
            'Genero:', OLD.Genero, '\n',
            'Grupo Sanguineo:', OLD.Grupo_Sanguineo, '\n'
            'Fecha de Nacimiento:', OLD.Fecha_Nacimiento, '\n'
            'Estatus:', v_estatus
        ),
        DEFAULT, DEFAULT
    );
END $$

DELIMITER ;
