-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024


-- Triggers para la tabla de vValoraciones Medicas
-- 1) AFTER INSERT Valoraciones Medicas
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_AFTER_INSERT` AFTER INSERT ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN
    INSERT INTO tbi_bitacora (
        id,
        usuario,
        operacion,
        tabla,
        descripcion
    ) VALUES (
        default,
        current_user(),
        'Create',
        'tbb_valoraciones_medicas',
        concat_ws('', 
            'Se ha registrado una nueva valoracion medica con los siguientes datos:', 
            'Id: ', NEW.id,'\n',
            'Paciente: ', NEW.paciente_id,'\n',
            'Fecha: ', NEW.fecha,'\n',
            'Antecedentes Personales: ', NEW.antecedentes_personales,'\n',
            'Antecedentes Familiares: ', NEW.antecedentes_familiares,'\n',
            'Antecedentes Medicos: ', NEW.antecedentes_medicos,'\n',
            'Sintomas y Signos: ', NEW.sintomas_signos,'\n',
            'Examen Fisico: ', NEW.examen_fisico,'\n',
            'Pruebas Diagnosticas: ', NEW.pruebas_diagnosticas,'\n',
            'Diagnostico: ', NEW.diagnostico,'\n',
            'Plan de Tratamiento: ', NEW.plan_tratamiento,'\n',
            'Seguimiento: ', NEW.seguimiento)
            
            
            
            
            
    );
END

-- 2) BEFORE UPDATE
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_valoraciones_medicas` FOR EACH ROW SET new.fecha_actualizacion = current_timestamp()


-- 3) AFTER UPDATE
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_AFTER_UPDATE` AFTER UPDATE ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN

    INSERT INTO tbi_bitacora (
        id,
        usuario,
        operacion,
        tabla,
        descripcion
    ) VALUES (
        default,
        current_user(),
        'update',
        'tbb_valoraciones_medicas',
        concat_ws('', 
            'Se ha modificado al usuario con ID: ',old.id, "con los 
        siguientes datos \n",
			'Paciente: ', OLD.paciente_id, ' -> ', NEW.paciente_id, '\n',
            'Fecha: ', OLD.fecha, ' -> ', NEW.fecha, '\n',
            'Antecedentes Personales: ', OLD.antecedentes_personales, ' -> ', NEW.antecedentes_personales, '\n',
            'Antecedentes Familiares: ', OLD.antecedentes_familiares, ' -> ', NEW.antecedentes_familiares, '\n',
            'Antecedentes Medicos: ', OLD.antecedentes_medicos, ' -> ', NEW.antecedentes_medicos, '\n',
            'Sintomas y Signos: ', OLD.sintomas_signos, ' -> ', NEW.sintomas_signos, '\n',
            'Examen Fisico: ', OLD.examen_fisico, ' -> ', NEW.examen_fisico, '\n',
            'Pruebas Diagnosticas: ', OLD.pruebas_diagnosticas, ' -> ', NEW.pruebas_diagnosticas, '\n',
            'Diagnostico: ', OLD.diagnostico, ' -> ', NEW.diagnostico, '\n',
            'Plan de Tratamiento: ', OLD.plan_tratamiento, ' -> ', NEW.plan_tratamiento, '\n',
            'Seguimiento: ', OLD.seguimiento, ' -> ', NEW.seguimiento)
            
            
            
            
            
    );
END

-- 4) AFTER DELETE
CREATE DEFINER=`romualdo`@`localhost` TRIGGER `tbb_valoraciones_medicas_AFTER_DELETE` AFTER DELETE ON `tbb_valoraciones_medicas` FOR EACH ROW BEGIN
    INSERT INTO tbi_bitacora (
        id,
        usuario,
        operacion,
        tabla,
        descripcion
    ) VALUES (
        default,
        current_user(),
        'Delete',
        'tbb_valoraciones_medicas',
        concat_ws('', 
            'Se ha eliminado una valoracion medica con los siguientes datos:', 
            'Id: ', old.id,'\n',
            'Paciente: ', old.paciente_id,'\n',
            'Fecha: ', old.fecha,'\n',
            'Antecedentes Personales: ', old.antecedentes_personales,'\n',
            'Antecedentes Familiares: ', old.antecedentes_familiares,'\n',
            'Antecedentes Medicos: ', old.antecedentes_medicos,'\n',
            'Sintomas y Signos: ', old.sintomas_signos,'\n',
            'Examen Fisico: ', old.examen_fisico,'\n',
            'Pruebas Diagnosticas: ', old.pruebas_diagnosticas,'\n',
            'Diagnostico: ', old.diagnostico,'\n',
            'Plan de Tratamiento: ', old.plan_tratamiento,'\n',
            'Seguimiento: ', old.seguimiento)
            
            
            
            
            
    );
END



