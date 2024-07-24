-- SCRIPT DE CREACION DE TRIGGERS ASIGNADOS
-- Elaborado por: Jesus Rios Gomez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Archivo: triggers.sql

DELIMITER &&

-- Triggers para la tabla tbc_puestos

-- Trigger AFTER INSERT
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbc_puestos_AFTER_INSERT` 
AFTER INSERT ON `tbc_puestos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (CURRENT_USER(), 'Create', 'tbc_puestos', 
            CONCAT('Se insertó un nuevo puesto: ', NEW.Nombre, ' (ID: ', NEW.PuestoID, '), Descripción: ', NEW.Descripcion, ', Salario: ', NEW.Salario, ', Turno: ', NEW.Turno), 
            b'1', NOW());
END
&&

-- Trigger BEFORE UPDATE
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbc_puestos_BEFORE_UPDATE` 
BEFORE UPDATE ON `tbc_puestos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (CURRENT_USER(), 'Update', 'tbc_puestos', 
            CONCAT('Se actualizará el puesto: ', OLD.Nombre, ' (ID: ', OLD.PuestoID, '), Descripción: ', OLD.Descripcion, ', Salario: ', OLD.Salario, ', Turno: ', OLD.Turno), 
            b'1', NOW());
END
&&

-- Trigger AFTER UPDATE
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbc_puestos_AFTER_UPDATE` 
AFTER UPDATE ON `tbc_puestos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (CURRENT_USER(), 'Update', 'tbc_puestos', 
            CONCAT('Se actualizó el puesto: ', NEW.Nombre, ' (ID: ', NEW.PuestoID, '), Descripción: ', NEW.Descripcion, ', Salario: ', NEW.Salario, ', Turno: ', NEW.Turno), 
            b'1', NOW());
END
&&

-- Trigger AFTER DELETE
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbc_puestos_AFTER_DELETE` 
AFTER DELETE ON `tbc_puestos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (CURRENT_USER(), 'Delete', 'tbc_puestos', 
            CONCAT('Se eliminó el puesto: ', OLD.Nombre, ' (ID: ', OLD.PuestoID, '), Descripción: ', OLD.Descripcion, ', Salario: ', OLD.Salario, ', Turno: ', OLD.Turno), 
            b'1', NOW());
END
&&

-- Triggers para la tabla tbd_puestos_departamentos

-- Trigger AFTER INSERT
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbd_puestos_departamentos_AFTER_INSERT` 
AFTER INSERT ON `tbd_puestos_departamentos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora VALUES
    (DEFAULT,
    current_user(), 
    'Create', 
    'tbd_puestos_departamentos', 
    CONCAT_WS(' ',
    'Se ha creado un nuevo puesto con los siguientes datos:',
    'PuestoID: ', new.PuestoID, '\n',
    'Nombre: ', new.Nombre, '\n',
    'Descripcion: ', new.Descripcion, '\n',
    'Salario: ', new.Salario, '\n',
    'Turno: ', new.Turno, '\n',
    'DepartamentoID: ', new.DepartamentoID, '\n'),
    DEFAULT, DEFAULT);
END
&&

-- Trigger BEFORE UPDATE
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbd_puestos_departamentos_BEFORE_UPDATE` 
BEFORE UPDATE ON `tbd_puestos_departamentos` 
FOR EACH ROW 
BEGIN
    SET new.Modificado = current_timestamp();
END
&&

-- Trigger AFTER UPDATE
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbd_puestos_departamentos_AFTER_UPDATE` 
AFTER UPDATE ON `tbd_puestos_departamentos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora VALUES
    (DEFAULT,
    current_user(), 
    'Update', 
    'tbd_puestos_departamentos', 
    CONCAT_WS(' ',
    'Se ha modificado un puesto con ID: ', old.PuestoID, '\n',
    'Nombre: ', old.Nombre, ' - ', new.Nombre, '\n',
    'Descripcion: ', old.Descripcion, ' - ', new.Descripcion, '\n',
    'Salario: ', old.Salario, ' - ', new.Salario, '\n',
    'Turno: ', old.Turno, ' - ', new.Turno, '\n',
    'DepartamentoID: ', old.DepartamentoID, ' - ', new.DepartamentoID, '\n'),
    DEFAULT, DEFAULT);
END
&&

-- Trigger AFTER DELETE
CREATE DEFINER=`jesus.rios`@`%` TRIGGER `tbd_puestos_departamentos_AFTER_DELETE` 
AFTER DELETE ON `tbd_puestos_departamentos` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora VALUES
    (DEFAULT,
    current_user(), 
    'Delete', 
    'tbd_puestos_departamentos', 
    CONCAT_WS(' ',
    'Se ha eliminado un puesto con los siguientes datos:',
    'PuestoID: ', old.PuestoID, '\n',
    'Nombre: ', old.Nombre, '\n',
    'Descripcion: ', old.Descripcion, '\n',
    'Salario: ', old.Salario, '\n',
    'Turno: ', old.Turno, '\n',
    'DepartamentoID: ', old.DepartamentoID, '\n'),
    DEFAULT, DEFAULT);
END
&&

DELIMITER ;
