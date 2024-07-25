-- SCRIPT DE CRECACIÓN DE TRIGGERS

-- Elaborado por: Brayan Gutiérrez Ramírez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Triggers para la tabla cirugías
-- 1) AFTER INSERT CIRUGÍAS
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_AFTER_INSERT` AFTER INSERT ON `tbb_cirugias` FOR EACH ROW BEGIN
insert into tbi_bitacora VALUES
(
DEFAULT,
current_user(),
'Create',
'tbb_cirugias',
concat_ws('', 'se ha creado una nueva cirugia con los siguientes datos:',
'ID ', NEW.id,'\n',
'TIPO:', NEW.tipo, '\n',
'NOMBRE:', NEW.nombre, '\n',
'DESCRIPCION:', NEW.descripcion, '\n',
'PERSONAL_MEDICO:', NEW.personal_medico_id, '\n',
'PACIENTE: ', NEW.paciente,'\n',
'NIVEL_URGENCIA: ', NEW.nivel_urgencia,'\n',
'HORARIO: ', NEW.horario,'\n',
'OBSERVACIONES: ', NEW.observaciones,'\n',
'FECHA_REGISTRO: ', NEW.fecha_registro,'\n',
'VALORACION_MEDICA: ', NEW.valoracion_medica, '\n',
'ESTATUS: ', NEW.estatus, '\n',
'CONSUMIBLE: ', NEW.consumible,'\n',
'ESPACIO_MEDICO', NEW.espacio_medico_id,'\n'),
default,
default
);
END
&&
DELIMITER ;


-- 2) BEFORE UPDATE
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_cirugias` FOR EACH ROW BEGIN
set new.fecha_actualizacion = current_timestamp();
END
&&
DELIMITER ;



-- 3) AFTER UPDATE
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_AFTER_UPDATE` AFTER UPDATE ON `tbb_cirugias` FOR EACH ROW BEGIN
insert into tbi_bitacora VALUES
(
DEFAULT,
current_user(),
'Update',
'tbb_cirugias',
concat_ws('', 'se ha modificado una cirugia con los siguientes datos:',
'ID ',old.id,'-', NEW.id,'\n',
'TIPO: ',old.tipo, '-', NEW.tipo, '\n',
'NOMBRE: ',old.nombre, '-', NEW.nombre, '\n',
'DESCRIPCION: ', old.descripcion, '-', NEW.descripcion, '\n',
'PERSONAL_MEDICO: ', old.personal_medico_id, '-', NEW.personal_medico_id, '\n',
'PACIENTE: ',old.paciente, '-', NEW.paciente,'\n',
'NIVEL_URGENCIA: ', old.nivel_urgencia, '-', NEW.nivel_urgencia,'\n',
'HORARIO: ', old.horario, '-', NEW.horario,'\n',
'OBSERVACIONES: ', old.observaciones, '-', NEW.observaciones,'\n',
'FECHA_REGISTRO ', old.fecha_registro, '-', NEW.fecha_registro,'\n',
'VALORACION_MEDICA: ', old.fecha_registro, '-', NEW.valoracion_medica, '\n',
'ESTATUS:', old.estatus, '-', NEW.estatus, '\n',
'CONSUMIBLE: ', old.consumible, '-' , NEW.consumible,'\n',
'ESPACIO_MEDICO: ', old.espacio_medico_id, '-', NEW.espacio_medico_id,'\n'
),
default,
default
);
END
&&
DELIMITER ;


-- 4) AFTER DELETE
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_AFTER_DELETE` AFTER DELETE ON `tbb_cirugias` FOR EACH ROW BEGIN
insert into tbi_bitacora values(
    default,
    current_user(),
    'Delete',
    'tbb_cirugias',
    concat_ws(' ','Se ha eliminado una cirugia con los siguientes datos: ',
    'TIPO: ', old.tipo,'\n',
    'NOMBRE: ', old.nombre,'\n',
    'DESCRIPCION: ', old.descripcion,'\n',
    'PERSONAL MÉDICO: ', old.personal_medico_id,'\n',
    'PACIENTE: ', old.paciente,'\n',
    'NIVEL URGENCIA: ', old.nivel_urgencia,'\n',
    'HORARIO: ', old.horario,'\n',
    'OBSERVACIONES: ', old.observaciones,'\n',
    'FECHA REGISTRO: ', old.fecha_registro,'\n',
    'VALORACIÓN MÉDICA: ', old.valoracion_medica,'\n',
    'ESTATUS: ', old.estatus,'\n',
    'CONSUMIBLE: ', old.consumible,'\n',
    'ESPACIO MÉDICO: ', old.espacio_medico_id,'\n',
    'FECHA ACTUALIZACIÓN: ', old.fecha_actualizacion
    ),
    default,
    default
    );
END
&&
DELIMITER ;