/*Procedimiento After Insert*/

CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_AFTER_INSERT` AFTER INSERT ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
DECLARE v_usuario varchar(100) default (select paciente_nombre from
    tbd_recetas_medicas where id = new.id);
 INSERT INTO tbi_bitacora 
    VALUES (
    default,
	current_user(),
    'Create',
    'tbd_recetas_medicas',
    CONCAT_WS(' ', 'Se ha creado una nueva receta médica con ID: ',NEW.id,'\n',
    "Para el usuario:",v_usuario),
    default, 
    default);
END

/*Procedimiento Before update*/
CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
SET new.fecha_actualizacion = current_timestamp();
END

/*Procedimiento After Update*/

CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_AFTER_UPDATE` AFTER UPDATE ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
   
    INSERT INTO tbi_bitacora 
    VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Update',
        'tbd_recetas_medicas',
         CONCAT_WS(' ', 
        'Se ha actualizado la receta médica con ID: ', NEW.id,'\n',
        'Del usuario: ', old.paciente_nombre,'\n', 
        'Nombre de usuario Actualizado:', new.paciente_nombre, '\n',
        'Se modificaron las indicaciones:',old.indicaciones,'\n',
        'por las nuevas:', new.indicaciones,'\n',
        'Diagnostico Actual:', old.diagnostico,'\n',
        'Diagnostico Actualizado:',new.diagnostico,'\n',
        'Medicamentos Sumistrados:', old.medicamentos,'\n',
		'Medicamentos Actualizados',new.medicamentos
        ),
        
        DEFAULT,
        DEFAULT
    );
END
/*After Delete*/

CREATE DEFINER=`marvin.tolentino`@`%` TRIGGER `tbd_recetas_medicas_AFTER_DELETE` AFTER DELETE ON `tbd_recetas_medicas` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (
    DEFAULT,
    CURRENT_USER(),
    'Delete',
    'tbd_recetas_medicas',
    CONCAT_WS(' ', 
		'se ha eliminado la receta del usuario:', old.paciente_nombre,'\n',
        'con el id:', old.id ),
    DEFAULT,
    DEFAULT
);
END