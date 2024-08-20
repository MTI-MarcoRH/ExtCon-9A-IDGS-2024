-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de Valoraciones Medicas
-- 1) AFTER INSERT Valoraciones Medicas
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_AFTER_INSERT` AFTER INSERT ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN
    INSERT INTO `hospital_general_9a_idgs_matricula`.`tbi_bitacora` (
        id,
        usuario,
        operacion,
        tabla,
        descripcion
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Create',
        'tbb_valoraciones_medicas',
        CONCAT_WS('',
            'Se ha registrado una nueva valoración médica con los siguientes datos:', '\n',
            'ID: ', NEW.ID, '\n',
            'Valor: ', NEW.Valor, '\n',
            'Indicador: ', NEW.Indicador, '\n',
            'Unidad de Medida: ', NEW.Unidad_medida, '\n',
            'Paciente ID: ', NEW.Paciente_id, '\n',
            'Cita ID: ', NEW.Cita_id, '\n',
            'Pm ID: ', NEW.Pm_id, '\n',
            'Estatus: ', NEW.Estatus, '\n',
            'Fecha de Registro: ', NEW.Fecha_registro
        )
    );
END
-- 2) BEFORE UPDATE
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN
    SET NEW.Fecha_actualizacion = CURRENT_TIMESTAMP();
END
-- 3) AFTER UPDATE
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_AFTER_UPDATE` AFTER UPDATE ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN

    INSERT INTO `hospital_general_9a_idgs_matricula`.`tbi_bitacora` (
        id,
        usuario,
        operacion,
        tabla,
        descripcion
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'update',
        'tbb_valoraciones_medicas',
        CONCAT_WS('', 
            'Se ha modificado el registro con ID: ', OLD.ID, ' con los siguientes datos \n',
            'Valor: ', OLD.Valor, ' -> ', NEW.Valor, '\n',
            'Indicador: ', OLD.Indicador, ' -> ', NEW.Indicador, '\n',
            'Unidad de Medida: ', OLD.Unidad_medida, ' -> ', NEW.Unidad_medida, '\n',
            'Paciente ID: ', OLD.Paciente_id, ' -> ', NEW.Paciente_id, '\n',
            'Cita ID: ', OLD.Cita_id, ' -> ', NEW.Cita_id, '\n',
            'Pm ID: ', OLD.Pm_id, ' -> ', NEW.Pm_id, '\n',
            'Estatus: ', OLD.Estatus, ' -> ', NEW.Estatus, '\n',
            'Fecha de Registro: ', OLD.Fecha_registro, ' -> ', NEW.Fecha_registro)
    );
END

-- 4) AFTER DELETE
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_AFTER_DELETE` AFTER DELETE ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN
    INSERT INTO `hospital_general_9a_idgs_matricula`.`tbi_bitacora` (
        id,
        usuario,
        operacion,
        tabla,
        descripcion
    ) VALUES (
        DEFAULT,
        CURRENT_USER(),
        'Delete',
        'tbb_valoraciones_medicas',
        CONCAT_WS('', 
            'Se ha eliminado una valoración médica con los siguientes datos:', '\n', 
            'ID: ', OLD.ID, '\n',
            'Valor: ', OLD.Valor, '\n',
            'Indicador: ', OLD.Indicador, '\n',
            'Unidad de Medida: ', OLD.Unidad_medida, '\n',
            'Paciente ID: ', OLD.Paciente_id, '\n',
            'Cita ID: ', OLD.Cita_id, '\n',
            'Pm ID: ', OLD.Pm_id, '\n',
            'Estatus: ', OLD.Estatus, '\n',
            'Fecha de Registro: ', OLD.Fecha_registro)
    );
END


