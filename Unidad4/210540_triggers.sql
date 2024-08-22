-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: M.T.I. Marco A. Ramírez Hernández
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  18 de Julio de 2024


CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_AFTER_INSERT` AFTER INSERT ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
DECLARE v_usuario INT DEFAULT NEW.id_paciente;
 INSERT INTO tbi_bitacora 
    VALUES (
    default,
	current_user(),
    'Create',
    'tbd_recetas_medicas',
    CONCAT_WS(' ', 'Se ha creado una nueva receta médica con ID: ',NEW.id,'\n',
    "Para el paciente con id:",v_usuario),
    default, 
    default);
END

/*-------------------------*/
CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
SET new.fecha_actualizacion = current_timestamp();
END

/*-------------------------*/
CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_AFTER_UPDATE` AFTER UPDATE ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
   
    INSERT INTO tbi_bitacora 
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Update',
        'tbd_recetas_medicas',
         CONCAT_WS(' ', 
        'Se ha actualizado la receta médica con ID: ', NEW.id,'\n',
        'Fecha de cita Actual:', old.fecha_cita,'\n',
        'Fecha de cita  Actualizado:',new.fecha_cita,'\n',
        'Diagnostico Actual:', old.diagnostico,'\n',
        'Diagnostico Actualizado:',new.diagnostico,'\n'
        ),
        
        DEFAULT,
        DEFAULT
    );
END
/*-------------------------*/

CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_AFTER_DELETE` AFTER DELETE ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (
    DEFAULT,
    CURRENT_USER(),
    'Delete',
    'tbd_recetas_medicas',
    CONCAT_WS(' ', 
		'se ha eliminado la receta con id:', old.id),
    DEFAULT,
    DEFAULT
);
END
