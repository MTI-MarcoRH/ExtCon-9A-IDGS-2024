-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por:Diego Oliver Basilio
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024


-- Triggers para la tabla de horarios

-- 1) AFTER INSERT horarios
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_AFTER_INSERT` 
AFTER INSERT ON `tbd_horarios` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora (
        Usuario,
        Operacion,
        Tabla,
        Descripcion,
        Estatus,
        Fecha_Registro
    ) VALUES (
        CURRENT_USER(),
        'Create',
        'tbd_horarios',
        CONCAT_WS(' ', 'Se ha agregado un nuevo horario con los siguientes datos:',
            '\n ID Empleado:', NEW.empleado_id,
            '\n Nombre:', NEW.nombre,
            '\n Especialidad:', NEW.especialidad,
            '\n Día de la Semana:', NEW.dia_semana,
            '\n Hora de Inicio:', NEW.hora_inicio,
            '\n Hora de Fin:', NEW.hora_fin,
            '\n Turno:', NEW.turno,
            '\n Departamento:', NEW.nombre_departamento,
            '\n Sala:', NEW.nombre_sala),
        b'1',
        CURRENT_TIMESTAMP()
    );
END ;;


-- 2) BEFORE UPDAE horarios
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_BEFORE_UPDATE` 
BEFORE UPDATE ON `tbd_horarios` 
FOR EACH ROW 
BEGIN
    INSERT INTO tbi_bitacora (
        Usuario,
        Operacion,
        Tabla,
        Descripcion,
        Estatus,
        Fecha_Registro
    ) VALUES (
        CURRENT_USER(),
        'Update',
        'tbd_horarios',
        CONCAT_WS(' ', 'Se ha actualizado un horario con los siguientes cambios:',
            '\n ID Empleado:', OLD.empleado_id, '->', NEW.empleado_id,
            '\n Nombre:', OLD.nombre, '->', NEW.nombre,
            '\n Especialidad:', OLD.especialidad, '->', NEW.especialidad,
            '\n Día de la Semana:', OLD.dia_semana, '->', NEW.dia_semana,
            '\n Hora de Inicio:', OLD.hora_inicio, '->', NEW.hora_inicio,
            '\n Hora de Fin:', OLD.hora_fin, '->', NEW.hora_fin,
            '\n Turno:', OLD.turno, '->', NEW.turno,
            '\n Departamento:', OLD.nombre_departamento, '->', NEW.nombre_departamento,
            '\n Sala:', OLD.nombre_sala, '->', NEW.nombre_sala),
        b'1',
        CURRENT_TIMESTAMP()
    );
END ;;

--3) AFTER UPDATE horarios
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_AFTER_UPDATE` 
AFTER UPDATE ON `tbd_horarios` 
FOR EACH ROW 
BEGIN
    DECLARE v_turno_old VARCHAR(20) DEFAULT 'Activo';
    DECLARE v_turno_new VARCHAR(20) DEFAULT 'Activo';

    IF NEW.turno = 'Inactivo' THEN
        SET v_turno_new = 'Inactivo';
    ELSEIF NEW.turno = 'Bloqueado' THEN
        SET v_turno_new = 'Bloqueado';
    ELSEIF NEW.turno = 'Suspendido' THEN
        SET v_turno_new = 'Suspendido';
    END IF;

    IF OLD.turno = 'Inactivo' THEN
        SET v_turno_old = 'Inactivo';
    ELSEIF OLD.turno = 'Bloqueado' THEN
        SET v_turno_old = 'Bloqueado';
    ELSEIF OLD.turno = 'Suspendido' THEN
        SET v_turno_old = 'Suspendido';
    END IF;

    INSERT INTO tbi_bitacora (
        Usuario,
        Operacion,
        Tabla,
        Descripcion,
        Estatus,
        Fecha_Registro
    ) VALUES (
        CURRENT_USER(),
        'Update',
        'tbd_horarios',
        CONCAT_WS(' ', 'Se ha modificado el horario existente con los siguientes datos:',
            '\n ID Empleado:', OLD.empleado_id, '-', NEW.empleado_id,
            '\n Nombre:', OLD.nombre, '-', NEW.nombre,
            '\n Especialidad:', OLD.especialidad, '-', NEW.especialidad,
            '\n Día de la Semana:', OLD.dia_semana, '-', NEW.dia_semana,
            '\n Hora de Inicio:', OLD.hora_inicio, '-', NEW.hora_inicio,
            '\n Hora de Fin:', OLD.hora_fin, '-', NEW.hora_fin,
            '\n Turno:', v_turno_old, '-', v_turno_new,
            '\n Departamento:', OLD.nombre_departamento, '-', NEW.nombre_departamento,
            '\n Sala:', OLD.nombre_sala, '-', NEW.nombre_sala),
        b'1',
        CURRENT_TIMESTAMP()
    );
END ;;

-- 3) BEFORE DELETE horarios
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_AFTER_DELETE` 
AFTER DELETE ON `tbd_horarios` 
FOR EACH ROW 
BEGIN
    DECLARE v_turno VARCHAR(20) DEFAULT 'Activo';

    INSERT INTO tbi_bitacora (
        Usuario,
        Operacion,
        Tabla,
        Descripcion,
        Estatus,
        Fecha_Registro
    ) VALUES (
        CURRENT_USER(),
        'Delete',
        'tbd_horarios',
        CONCAT_WS(' ', 'Se ha eliminado un horario con los siguientes datos:',
            '\n ID Empleado:', OLD.empleado_id,
            '\n Nombre:', OLD.nombre,
            '\n Especialidad:', OLD.especialidad,
            '\n Día de la Semana:', OLD.dia_semana,
            '\n Hora de Inicio:', OLD.hora_inicio,
            '\n Hora de Fin:', OLD.hora_fin,
            '\n Turno:', v_turno,
            '\n Departamento:', OLD.nombre_departamento,
            '\n Sala:', OLD.nombre_sala),
        b'1',
        CURRENT_TIMESTAMP()
    );
END ;;