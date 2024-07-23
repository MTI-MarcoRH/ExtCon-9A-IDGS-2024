-- SCRIPT DE TRIGGERS DE TABLAS ASIGNADAS

-- Elaborado por: Arturo Aguilar Santos
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Triggers para la tabla de Expedientes Medicos

-- 1) AFTER INSERT EXPEDIENTES MEDICOS

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` TRIGGER `tbd_expedientes_clinicos_AFTER_INSERT` AFTER INSERT ON `tbd_expedientes_clinicos` FOR EACH ROW BEGIN
	declare v_estatus varchar(20) default 'Activo';
-- validamos el estatus del registro y le asignamos una etiqueta para la descripcion

	if not new.Estatus then
		set v_estatus = 'Inactivo';
    end if;
    
    INSERT INTO tbi_bitacora VALUES (
        default,
	    current_user(),
		'Create',
	   'tbd_expedientes_clinicos',
       concat_ws(' ','Se ha creado un nuevo EXPEDIENTE con los siguientes datos: \n',
		'PERSONA ID: ',new.persona_id, '\n', 
        'ANTECEDENTES MEDICOS PATOLOGICOS: ',new.Antecendentes_Medicos_Patologicos, '\n',
        'ANTECEDENTES MEDICOS NO PATOLOGICOS: ',new.Antecendentes_Medicos_NoPatologicos, '\n',
        'ANTECEDENTES MEDICOS PATOLOGICOS HEREDOFAMILIARES',new.Antecendentes_Medicos_Patologicos_HeredoFamiliares, '\n',
        'INTERROGATORIO DE SISTEMAS', new.Interrogatorio_sistemas,'\n',
        'PADECIMIENTO ACTUAL', new.Padecimiento_Actual,'\n',
        'NOTAS MEDICAS', new.Notas_Medicas,'\n',
        'ESTATUS: ',v_estatus,'\n'
        ),
		default,
		default
	);
END
DELIMITER ;

-- 2) BEFORE UPDATE EXPEDIENTES MEDICOS

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` TRIGGER `tbd_expedientes_clinicos_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_expedientes_clinicos` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp();
END
DELIMITER ;

-- 3) AFTER UPDATE EXPEDIENTES MEDICOS
DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` TRIGGER `tbd_expedientes_clinicos_AFTER_UPDATE` AFTER UPDATE ON `tbd_expedientes_clinicos` FOR EACH ROW BEGIN
	declare v_estatus_old varchar(20) default 'Activo';
    declare v_estatus_new varchar(20) default 'Activo';
	-- validamos el estatus del registro y le asignamos una etiqueta para la descripcion

		if not new.Estatus then
			set v_estatus_new = 'Inactivo';
		end if;
        if not new.Estatus then
			set v_estatus_old = 'Inactivo';
		end if;
	
    INSERT INTO tbi_bitacora VALUES (
        default,
	    current_user(),
		'Update',
	   'tbd_expedientes_clinicos',
       concat_ws(' ','Se ha actualizado el EXPEDIENTE con los siguientes datos: \n',
		'PERSONA ID: ', old.persona_id,' -> ',new.persona_id, '\n', 
        'ANTECEDENTES MEDICOS PATOLOGICOS: ',old.Antecendentes_Medicos_Patologicos,' -> ',new.Antecendentes_Medicos_Patologicos, '\n',
        'ANTECEDENTES MEDICOS NO PATOLOGICOS: ',old.Antecendentes_Medicos_NoPatologicos,' -> ',new.Antecendentes_Medicos_NoPatologicos, '\n',
        'ANTECEDENTES MEDICOS PATOLOGICOS HEREDOFAMILIARES',old.Antecendentes_Medicos_Patologicos_HeredoFamiliares,' -> ',new.Antecendentes_Medicos_Patologicos_HeredoFamiliares, '\n',
        'INTERROGATORIO DE SISTEMAS',old.Interrogatorio_sistemas,' -> ', new.Interrogatorio_sistemas,'\n',
        'PADECIMIENTO ACTUAL',old.Padecimiento_Actual,' -> ', new.Padecimiento_Actual,'\n',
        'NOTAS MEDICAS',old.Notas_Medicas,' -> ', new.Notas_Medicas,'\n',
        'ESTATUS: ', v_estatus_old,'->',v_estatus_new,'\n'
        ),
		default,
		default
    );
END
DELIMITER ;

-- 4) AFTER DELETE EXPEDIENTES MEDICOS

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` TRIGGER `tbd_expedientes_clinicos_AFTER_DELETE` AFTER DELETE ON `tbd_expedientes_clinicos` FOR EACH ROW BEGIN
	declare v_estatus varchar(20) default 'Activo';
		
		-- validamos el estatus del registro y le asignamos una etiqueta para la descripcion

			if not old.Estatus then
				set v_estatus = 'Inactivo';
			end if;
            
	INSERT INTO tbi_bitacora VALUES (
        default,
	    current_user(),
		'Delete',
	   'tbd_expedientes_clinicos',
       concat_ws(' ','Se ha eliminado el EXPEDIENTE con los siguientes datos: \n',
		'PERSONA ID: ', old.persona_id, '\n', 
        'ANTECEDENTES MEDICOS PATOLOGICOS: ',old.Antecendentes_Medicos_Patologicos, '\n',
        'ANTECEDENTES MEDICOS NO PATOLOGICOS: ',old.Antecendentes_Medicos_NoPatologicos, '\n',
        'ANTECEDENTES MEDICOS PATOLOGICOS HEREDOFAMILIARES',old.Antecendentes_Medicos_Patologicos_HeredoFamiliares, '\n',
        'INTERROGATORIO DE SISTEMAS',old.Interrogatorio_sistemas,'\n',
        'PADECIMIENTO ACTUAL',old.Padecimiento_Actual,'\n',
        'NOTAS MEDICAS',old.Notas_Medicas,'\n',
        'ESTATUS: ', v_estatus,'\n'
        ),
		default,
		default
    );
END
DELIMITER ;