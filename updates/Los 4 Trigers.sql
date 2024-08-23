-- #############################################AFTER INSERT
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_AFTER_INSERT` AFTER INSERT ON `tbd_horarios` FOR EACH ROW BEGIN
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
            '\n Nombre:', NEW.nombre,
            '\n Especialidad:', NEW.especialidad,
            '\n Día de la Semana:', NEW.dia_semana,
            '\n Hora de Inicio:', NEW.hora_inicio,
            '\n Hora de Fin:', NEW.hora_fin,
            '\n Turno:', NEW.turno),
        b'1', -- Este valor indica el estado del registro, asegúrate de que sea coherente con tu diseño
        CURRENT_TIMESTAMP()
    );
END


-- #############################################BEFORE UPDATE
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_horarios` FOR EACH ROW BEGIN
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
            IF(OLD.nombre != NEW.nombre, CONCAT('\n Nombre:', OLD.nombre, '->', NEW.nombre), ''),
            IF(OLD.especialidad != NEW.especialidad, CONCAT('\n Especialidad:', OLD.especialidad, '->', NEW.especialidad), ''),
            IF(OLD.dia_semana != NEW.dia_semana, CONCAT('\n Día de la Semana:', OLD.dia_semana, '->', NEW.dia_semana), ''),
            IF(OLD.hora_inicio != NEW.hora_inicio, CONCAT('\n Hora de Inicio:', OLD.hora_inicio, '->', NEW.hora_inicio), ''),
            IF(OLD.hora_fin != NEW.hora_fin, CONCAT('\n Hora de Fin:', OLD.hora_fin, '->', NEW.hora_fin), ''),
            IF(OLD.turno != NEW.turno, CONCAT('\n Turno:', OLD.turno, '->', NEW.turno), '')
        ),
        b'1',
        CURRENT_TIMESTAMP()
    );
END

-- ############################################# AFTER UPDATE
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_AFTER_UPDATE` AFTER UPDATE ON `tbd_horarios` FOR EACH ROW BEGIN
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
            IF(OLD.nombre != NEW.nombre, CONCAT('\n Nombre:', OLD.nombre, '-', NEW.nombre), ''),
            IF(OLD.especialidad != NEW.especialidad, CONCAT('\n Especialidad:', OLD.especialidad, '-', NEW.especialidad), ''),
            IF(OLD.dia_semana != NEW.dia_semana, CONCAT('\n Día de la Semana:', OLD.dia_semana, '-', NEW.dia_semana), ''),
            IF(OLD.hora_inicio != NEW.hora_inicio, CONCAT('\n Hora de Inicio:', OLD.hora_inicio, '-', NEW.hora_inicio), ''),
            IF(OLD.hora_fin != NEW.hora_fin, CONCAT('\n Hora de Fin:', OLD.hora_fin, '-', NEW.hora_fin), ''),
            IF(OLD.turno != NEW.turno, CONCAT('\n Turno:', OLD.turno, '-', NEW.turno), '')
        ),
        b'1',
        CURRENT_TIMESTAMP()
    );
END



-- ############################################# AFTER DELETE
CREATE DEFINER=`DiegoOliver`@`%` TRIGGER `tbd_horarios_AFTER_DELETE` AFTER DELETE ON `tbd_horarios` FOR EACH ROW BEGIN
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
            '\n Nombre:', OLD.nombre,
            '\n Especialidad:', OLD.especialidad,
            '\n Día de la Semana:', OLD.dia_semana,
            '\n Hora de Inicio:', OLD.hora_inicio,
            '\n Hora de Fin:', OLD.hora_fin,
            '\n Turno:', OLD.turno),
        b'1', -- Este valor indica el estado del registro, asegúrate de que sea coherente con tu diseño
        CURRENT_TIMESTAMP()
    );
END
