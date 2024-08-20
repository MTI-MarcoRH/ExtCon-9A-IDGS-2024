-- SCRIPT DE CRECACIÓN DE TRIGGERS

-- Elaborado por: Brayan Gutiérrez Ramírez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  17 de Agosto de 2024

------------------ Triggers para la tabla cirugías --------------------
---------- 1) AFTER INSERT CIRUGÍAS ---------------------------------------------
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
      'FECHA PROGRAMACION CIRUGIA: ', NEW.Fecha_Programacion,'\n',
	  'FECHA REALIZACION CIRUGIA: ', NEW.Fecha_Realizacion, '\n',
      'CON FECHA DE REGISTRO: ',NEW.Fecha_Registro,'\n'),
      DEFAULT,
      DEFAULT);  
END

&&
DELIMITER ;



------------------------------------- 2) BEFORE UPDATE ----------------------------------

CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_cirugias` FOR EACH ROW BEGIN
set new.Fecha_Actualizacion = current_timestamp();
END

------------------------------------ 3) AFTER UPDATE ----------------------------------------------
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
'FECHA PROGRAMACION CIRUGIA: ', old.Fecha_Programacion, '-', NEW.Fecha_Programacion, '\n',
'FECHA REALIZACION CIRUGIA: ', old.Fecha_Realizacion, '-', NEW.Fecha_Realizacion, '\n',
'CON FECHA DE REGISTRO: ', old.Fecha_Registro, '-', new.Fecha_Registro,'\n'
),
default,
default
);

END
&&
DELIMITER ;


-------------------------- 4) AFTER DELETE --------------------------------------------
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbb_cirugias_AFTER_DELETE` AFTER DELETE ON `tbb_cirugias` FOR EACH ROW BEGIN

DECLARE v_paciente_nombre_old VARCHAR(155);
DECLARE v_espacio_nombre_old VARCHAR(100);
 
SELECT CONCAT(COALESCE(Titulo, ''), Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, ''))
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
    'FECHA PROGRAMACION CIRUGIA: ', old.Fecha_Programacion,'\n',
    'FECHA REALIZACION CIRUGIA: ', old.Fecha_Realizacion,'\n',
	'FECHA REGISTRO: ', old.Fecha_Registro,'\n',
    'FECHA ACTUALIZACIÓN: ', old.Fecha_Actualizacion
    ),
    default,
    default
    );

END
&&
DELIMITER ;



------------------ Triggers para la tabla cirugías personal medico  --------------------
-------------------------------------- 1) AFTER INSERT ---------------------------------------------
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbd_cirugias_personal_medico_AFTER_INSERT` AFTER INSERT ON `tbd_cirugias_personal_medico` FOR EACH ROW BEGIN
 DECLARE v_estatus TINYINT DEFAULT 1;
 DECLARE v_personal_medico_nombre VARCHAR(255);
 declare v_cirugia varchar(50);
 
 
    
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) 
    INTO v_personal_medico_nombre 
    FROM tbb_personas 
    WHERE ID = NEW.Personal_medico_ID;
    
	SELECT Tipo  INTO v_cirugia
    FROM tbb_cirugias
    WHERE ID = new.Cirugia_ID;

 -- Inserta la información del nuevo registro en la tabla de bitacora
    INSERT INTO tbi_bitacora 
   VALUES (
    DEFAULT,
      CURRENT_USER(),
	  'Create',
	  'tbd_cirugias_personal_medico',
	  concat_ws('', 'se ha creado una nueva CIRUGÍA con los siguientes datos: ',
      'PERSONAL MÉDICO: ',v_personal_medico_nombre,'\n',
      'CIRUGIA: ',v_cirugia,'\n',
      'Con el rol de: ', NEW.Rol,'\n',
      'ESTATUS: ', v_estatus,'\n'),
      DEFAULT,
      DEFAULT);



END
&&
DELIMITER ;


------------------------------------- 2) BEFORE UPDATE ----------------------------------
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbd_cirugias_personal_medico_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_cirugias_personal_medico` FOR EACH ROW BEGIN
set new.Fecha_Actualizacion = current_timestamp();
END
&&
DELIMITER ;


------------------------------------ 3) AFTER UPDATE ----------------------------------------------
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbd_cirugias_personal_medico_AFTER_UPDATE` AFTER UPDATE ON `tbd_cirugias_personal_medico` FOR EACH ROW BEGIN
 DECLARE v_personal_medico_nombre_old VARCHAR(255);
 DECLARE v_personal_medico_nombre_new VARCHAR(255);
 declare v_cirugia_old varchar(50);
 declare v_cirugia_new varchar(50);
 
 
      -- Obtener nombres completos para Personal Médico y Paciente
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, ''))
    INTO v_personal_medico_nombre_old 
    FROM tbb_personas 
    WHERE ID = OLD.Personal_medico_ID;
	
    SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, '')) 
    INTO v_personal_medico_nombre_new 
    FROM tbb_personas 
    WHERE ID = NEW.Personal_medico_ID;
    
    
	SELECT Tipo  INTO v_cirugia_old
    FROM tbb_cirugias
    WHERE ID = OLD.Cirugia_ID;
    
	SELECT Tipo  INTO v_cirugia_new
    FROM tbb_cirugias
    WHERE ID = NEW.Cirugia_ID;
 
 
insert into tbi_bitacora VALUES
(
DEFAULT,
current_user(),
'Update',
'tbd_cirugias_personal_medico',
concat_ws('', 'se ha modificado una CIRUGÍA con los siguientes datos: ',
 'PERSONAL MEDICO: ', v_personal_medico_nombre_old , '-' , v_personal_medico_nombre_new, '\n',
 'Cirugia: ', v_cirugia_old, '-', v_cirugia_new, '\n',
 'Con el rol de: ', OLD.Rol, '-', NEW.Rol, '\n',
 'Estatus: ',CAST(OLD.Estatus AS UNSIGNED), '-' ,CAST(NEW.Estatus AS UNSIGNED), '\n',
 'CON FECHA DE REGISTRO: ', old.Fecha_Registro, '-' , new.Fecha_Registro,'\n'
),
default,
default
);


END

&&
DELIMITER ;

------------------------------------ 4) AFTER DELETE --------------------------------------------
DELIMITER &&
CREATE DEFINER=`brayan.gutierrez`@`%` TRIGGER `tbd_cirugias_personal_medico_AFTER_DELETE` AFTER DELETE ON `tbd_cirugias_personal_medico` FOR EACH ROW BEGIN
 DECLARE v_personal_medico_nombre_old VARCHAR(255);
  declare v_cirugia_old varchar(50);
  
SELECT CONCAT(Nombre, ' ', Primer_Apellido, ' ', COALESCE(Segundo_Apellido, ''))
INTO v_personal_medico_nombre_old 
FROM tbb_personas 
WHERE ID = OLD.Personal_medico_ID;
    
SELECT Tipo  INTO v_cirugia_old
FROM tbb_cirugias
WHERE ID = OLD.Cirugia_ID;

insert into tbi_bitacora values(
    default,
    current_user(),
    'Delete',
    'tbd_cirugias_personal_medico',
    concat_ws(' ','Se ha eliminado una CIRUGÍA con los siguientes datos: ',
    'PERSONAL MÉDICO: ', v_personal_medico_nombre_old,'\n',
    'CIRUGIA: ', v_cirugia_old, '\n',
    "Con el Rol de: ", OLd.Rol, '\n',
    'Estatus: ',CAST(OLD.Estatus AS UNSIGNED), '\n',
	'FECHA REGISTRO: ', old.Fecha_Registro,'\n',
    'FECHA ACTUALIZACIÓN: ', old.Fecha_Actualizacion
    ),
    default,
    default
    );


END

&&
DELIMITER ;
