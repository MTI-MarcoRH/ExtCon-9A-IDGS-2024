-- SCRIPT DE CRECACIÓN DE TRIGGERS

-- Elaborado por: Brayan Gutiérrez Ramírez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Triggers para la tabla cirugías
-- 1) AFTER INSERT CIRUGÍAS
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_AFTER_INSERT` AFTER INSERT ON `tbb_cirugias` FOR EACH ROW BEGIN
DECLARE v_paciente_nombre VARCHAR(155);
DECLARE v_espacio_nombre VARCHAR(100);
 
SELECT CONCAT(
    IFNULL(Titulo, ''), ' ', 
    Nombre, ' ', 
    Primer_Apellido, ' ', 
    COALESCE(Segundo_Apellido, '')
) INTO v_paciente_nombre
FROM tbb_personas 
WHERE ID = NEW.Paciente_ID;
    
	SELECT CONCAT(Tipo,' ', Nombre) 
    INTO v_espacio_nombre 
    FROM tbc_espacios 
    WHERE ID = NEW.Espacio_Medico_ID;
    
  -- Inserta la información del nuevo registro en la tabla de bitacora
    INSERT INTO tbi_bitacora 
   VALUES (
    DEFAULT,
      CURRENT_USER(),
	  'Create',
	  'tbb_cirugias',
	  concat_ws('', 'se ha creado una nueva cirugia con los siguientes datos: ',
      
      'PACIENTE: ',v_paciente_nombre ,'\n',
      'ESPACIO MEDICO: ',v_espacio_nombre ,'\n',
      'TIPO: ',NEW.Tipo,'\n',
      'NOMBRE: ',NEW.Nombre,'\n',
      'DESCRIPCION: ',NEW.Descripcion,'\n',
      'NIVEL URGENCIA: ',NEW.Nivel_Urgencia,'\n',
      'HORARIO: ',NEW.Horario,'\n',
      'OBSERVACIONES: ',NEW.Observaciones,'\n',
      'VALORACION MEDICA :',NEW.Valoracion_Medica,'\n',
      'CON ESTATUS: ',NEW.Estatus,'\n',
      'CONSUMIBLE: ',NEW.Consumible,'\n',
      'CON FECHA DE REGISTRO: ',NEW.Fecha_Registro,'\n'),
      DEFAULT,
      DEFAULT);
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
DECLARE v_paciente_nombre_old VARCHAR(155);
DECLARE v_paciente_nombre_new VARCHAR(155);
DECLARE v_espacio_nombre_old VARCHAR(100);
DECLARE v_espacio_nombre_new VARCHAR(100);
 
SELECT CONCAT(
    IFNULL(Titulo, ''), ' ', 
    Nombre, ' ', 
    Primer_Apellido, ' ', 
    COALESCE(Segundo_Apellido, '')
) INTO v_paciente_nombre_old
FROM tbb_personas 
WHERE ID = OLD.Paciente_ID;
    
SELECT CONCAT(
    IFNULL(Titulo, ''), ' ', 
    Nombre, ' ', 
    Primer_Apellido, ' ', 
    COALESCE(Segundo_Apellido, '')
) INTO v_paciente_nombre_new
FROM tbb_personas 
WHERE ID = NEW.Paciente_ID;
    
	SELECT CONCAT(Tipo,' ', Nombre) 
    INTO v_espacio_nombre_old 
    FROM tbc_espacios 
    WHERE ID = OLD.Espacio_Medico_ID;
    
	SELECT CONCAT(Tipo,' ', Nombre) 
    INTO v_espacio_nombre_new
    FROM tbc_espacios 
    WHERE ID = NEW.Espacio_Medico_ID;



insert into tbi_bitacora VALUES
(
DEFAULT,
current_user(),
'Update',
'tbb_cirugias',
concat_ws('', 'se ha modificado una cirugia con los siguientes datos: ',

 'PACIENTE : ',v_paciente_nombre_old ,'-', v_paciente_nombre_new,'\n',
 'ESPACIO MEDICO: ', v_espacio_nombre_old ,'-', v_espacio_nombre_new,'\n',
'TIPO: ',old.Tipo, '-', NEW.Tipo, '\n',
'NOMBRE: ',old.Nombre, '-', NEW.Nombre, '\n',
'DESCRIPCION: ', old.Descripcion, '-', NEW.Descripcion, '\n',
'NIVEL_URGENCIA: ', old.Nivel_Urgencia, '-', NEW.Nivel_Urgencia,'\n',
'HORARIO: ', old.Horario, '-', NEW.Horario,'\n',
'OBSERVACIONES: ', old.Observaciones, '-', NEW.Observaciones,'\n',
'VALORACIÓN MEDICA: ', old.Valoracion_Medica, '-', new.Valoracion_Medica,'\n',
'ESTATUS: ', old.Estatus, '-', NEW.Estatus, '\n',
'CONSUMIBLE: ', old.Consumible, '-' , NEW.Consumible,'\n',
'CON FECHA DE REGISTRO: ', old.Fecha_Registro, '-', new.Fecha_Registro,'\n'
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

DECLARE v_paciente_nombre_old VARCHAR(155);
DECLARE v_espacio_nombre_old VARCHAR(100);
 
	SELECT CONCAT(Titulo, Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, ''))
	INTO v_paciente_nombre_old 
    FROM tbb_personas 
    WHERE ID = old.Paciente_ID;
    
	SELECT CONCAT(Tipo,' ', Nombre) 
    INTO v_espacio_nombre_old 
    FROM tbc_espacios 
    WHERE ID = old.Espacio_Medico_ID;


insert into tbi_bitacora values(
    default,
    current_user(),
    'Delete',
    'tbb_cirugias',
    concat_ws(' ','Se ha eliminado una cirugia con los siguientes datos: ',
    'PACIENTE: ', v_paciente_nombre_old,'\n',
    'ESPACIO MEDICO: ', v_espacio_nombre_old  , '\n',
    'TIPO: ', old.Tipo,'\n',
    'NOMBRE: ', old.Nombre,'\n',
    'DESCRIPCION: ', old.Descripcion,'\n',
    'NIVEL URGENCIA: ', old.Nivel_Urgencia,'\n',
    'HORARIO: ', old.Horario,'\n',
    'OBSERVACIONES: ', old.Observaciones,'\n',
    'VALORACIÓN MÉDICA: ', old.Valoracion_Medica,'\n',
    'ESTATUS: ', old.Estatus,'\n',
    'CONSUMIBLE: ', old.Consumible,'\n',
	'FECHA REGISTRO: ', old.Fecha_Registro,'\n',
    'FECHA ACTUALIZACIÓN: ', old.Fecha_Actualizacion
    ),
    default,
    default
    );
END
&&
DELIMITER ;