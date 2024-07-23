-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Bruno Lemus Gonzalez
-- Grado y Grupo:  9° A  
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de Espacios
-- 1) AFTER INSERT Espacios
CREATE DEFINER=`bruno.lemus`@`%` TRIGGER `tbc_espacios_AFTER_INSERT` AFTER INSERT ON `tbc_espacios` FOR EACH ROW BEGIN
    DECLARE v_estatus VARCHAR(20);
    DECLARE departamento_nombre VARCHAR(255);
    DECLARE espacio_superior_nombre VARCHAR(255);

   SET v_estatus = CASE 
                        WHEN NEW.Estatus = 'Activo' THEN 'Activo'
                        WHEN NEW.Estatus = 'Inactivo' THEN 'Inactivo'
                        WHEN NEW.Estatus = 'En remodelación' THEN 'En remodelación'
                        WHEN NEW.Estatus = 'Clausurado' THEN 'Clausurado'
                        WHEN NEW.Estatus = 'Reubicado' THEN 'Reubicado'
                        WHEN NEW.Estatus = 'Temporal' THEN 'Temporal'
                        ELSE 'Desconocido'
                    END;

    -- Obtener el nombre del departamento
    SET departamento_nombre = (SELECT Nombre FROM tbc_departamentos WHERE ID = NEW.Departamento_ID);
    
    -- Obtener el nombre del espacio superior
    SET espacio_superior_nombre = (SELECT Nombre FROM tbc_espacios WHERE ID = NEW.Espacio_superior_ID);

    -- Registrar la inserción del nuevo espacio en la bitácora
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) 
    VALUES (
        CURRENT_USER(), 
        'Create', 
        'tbc_espacios', 
        CONCAT_WS('\n',
            CONCAT('Se ha agregado un nuevo ESPACIO con el Nombre: ', NEW.Nombre),
            CONCAT('Tipo: ', NEW.Tipo),
            CONCAT('Departamento: ', IFNULL(departamento_nombre, 'Desconocido')),
            CONCAT('Estatus: ', v_estatus),
            CONCAT('Fecha de Registro: ', NEW.Fecha_Registro),
            CONCAT('Fecha de Actualización: ', IFNULL(NEW.Fecha_Actualizacion, 'NULL')),
            CONCAT('Capacidad: ', NEW.Capacidad),
            CONCAT('Espacio Superior: ', IFNULL(espacio_superior_nombre, 'Ninguno'))
        ),
        b'1', -- Estatus activo
        NOW()
    );
END
-- 2) BEFORE UPDATE Espacios
CREATE DEFINER=`bruno.lemus`@`%` TRIGGER `tbb_personas_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_espacios` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp();
END

-- 3) AFTER UPDATE Espacios
CREATE DEFINER=`bruno.lemus`@`%` TRIGGER `tbc_espacios_AFTER_UPDATE` AFTER UPDATE ON `tbc_espacios` FOR EACH ROW BEGIN
    DECLARE v_estatus VARCHAR(20);
    DECLARE departamento_nombre VARCHAR(255);
    DECLARE espacio_superior_nombre VARCHAR(255);

    -- Asignar el valor de estatus
    SET v_estatus = CASE 
                        WHEN NEW.Estatus = 'Activo' THEN 'Activo'
                        WHEN NEW.Estatus = 'Inactivo' THEN 'Inactivo'
                        WHEN NEW.Estatus = 'En remodelación' THEN 'En remodelación'
                        WHEN NEW.Estatus = 'Clausurado' THEN 'Clausurado'
                        WHEN NEW.Estatus = 'Reubicado' THEN 'Reubicado'
                        WHEN NEW.Estatus = 'Temporal' THEN 'Temporal'
                        ELSE 'Desconocido'
                    END;

    -- Obtener el nombre del departamento
    SET departamento_nombre = (SELECT Nombre FROM tbc_departamentos WHERE ID = NEW.Departamento_ID);
    
    -- Obtener el nombre del espacio superior
    SET espacio_superior_nombre = (SELECT Nombre FROM tbc_espacios WHERE ID = NEW.Espacio_superior_ID);

    -- Registrar la actualización del espacio en la bitácora
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) 
    VALUES (
        CURRENT_USER(), 
        'Update', 
        'tbc_espacios', 
        CONCAT_WS('\n',
            CONCAT('Se ha actualizado un ESPACIO con el Nombre: ', NEW.Nombre),
            CONCAT('Tipo: ', NEW.Tipo),
            CONCAT('Departamento: ', IFNULL(departamento_nombre, 'Desconocido')),
            CONCAT('Estatus: ', v_estatus),
            CONCAT('Fecha de Registro: ', NEW.Fecha_Registro),
            CONCAT('Fecha de Actualización: ', IFNULL(NEW.Fecha_Actualizacion, 'NULL')),
            CONCAT('Capacidad: ', NEW.Capacidad),
            CONCAT('Espacio Superior: ', IFNULL(espacio_superior_nombre, 'Ninguno'))
        ),
        b'1', -- Estatus activo
        NOW()
    );
END

-- 4) AFTER DELETE
CREATE DEFINER=`bruno.lemus`@`%` TRIGGER `tbc_espacios_AFTER_DELETE` AFTER DELETE ON `tbc_espacios` FOR EACH ROW BEGIN
    DECLARE v_estatus VARCHAR(20);
    DECLARE departamento_nombre VARCHAR(255);
    DECLARE espacio_superior_nombre VARCHAR(255);

    -- Asignar el valor de estatus
    SET v_estatus = CASE 
                        WHEN OLD.Estatus = 'Activo' THEN 'Activo'
                        WHEN OLD.Estatus = 'Inactivo' THEN 'Inactivo'
                        WHEN OLD.Estatus = 'En remodelación' THEN 'En remodelación'
                        WHEN OLD.Estatus = 'Clausurado' THEN 'Clausurado'
                        WHEN OLD.Estatus = 'Reubicado' THEN 'Reubicado'
                        WHEN OLD.Estatus = 'Temporal' THEN 'Temporal'
                        ELSE 'Desconocido'
                    END;

    -- Obtener el nombre del departamento
    SET departamento_nombre = (SELECT Nombre FROM tbc_departamentos WHERE ID = OLD.Departamento_ID);
    
    -- Obtener el nombre del espacio superior
    SET espacio_superior_nombre = (SELECT Nombre FROM tbc_espacios WHERE ID = OLD.Espacio_superior_ID);

    -- Registrar la eliminación del espacio en la bitácora
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro) 
    VALUES (
        CURRENT_USER(), 
        'Delete', 
        'tbc_espacios', 
        CONCAT_WS('\n',
            CONCAT('Se ha eliminado un ESPACIO con el Nombre: ', OLD.Nombre),
            CONCAT('Tipo: ', OLD.Tipo),
            CONCAT('Departamento: ', IFNULL(departamento_nombre, 'Desconocido')),
            CONCAT('Estatus: ', v_estatus),
            CONCAT('Fecha de Registro: ', OLD.Fecha_Registro),
            CONCAT('Fecha de Actualización: ', IFNULL(OLD.Fecha_Actualizacion, 'NULL')),
            CONCAT('Capacidad: ', OLD.Capacidad),
            CONCAT('Espacio Superior: ', IFNULL(espacio_superior_nombre, 'Ninguno'))
        ),
        b'1', -- Estatus activo
        NOW()
    );
END




