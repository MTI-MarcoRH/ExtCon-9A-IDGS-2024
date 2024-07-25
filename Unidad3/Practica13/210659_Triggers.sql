-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Justin Martin Muñoz Escorcia
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024


-- Triggers para la tabla de Pacientes
-- 1) AFTER INSERT Pacientes
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbb_pacientes_AFTER_INSERT` AFTER INSERT ON `tbb_pacientes` FOR EACH ROW BEGIN
	  declare v_estatus varchar(20) default 'Activo';
      
		if not new.Estatus then
			set v_estatus = 'Inactivo';
		end if;
      
      insert into tbi_bitacora values(
		default,
		current_user(),
		'Create',
		'tbb_pacientes',
		concat_ws(' ','Se ha creado un nuevo paciente con los siguientes datos: \n',
		'NSS: ', new.NSS, '\n', 
		'TIPO SEGURO: ', new.Tipo_Seguro, '\n', 
		'ESTATUS MEDICO: ', new.Estatus_Medico, '\n', 
		'ESTATUS VIDA: ', new.Estatus_Vida, '\n',
        'ESTATUS: ', v_estatus, '\n'),
		default,
		default
    );
END

-- 2) BEFORE UPDATE
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbb_pacientes_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_pacientes` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp(); 
END


-- 3) AFTER UPDATE
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbb_pacientes_AFTER_UPDATE` AFTER UPDATE ON `tbb_pacientes` FOR EACH ROW BEGIN
	 declare v_estatus_old varchar(20) default 'Activo';
     declare v_estatus_new varchar(20) default 'Activo';
      
		if not new.Estatus then
			set v_estatus_new = 'Inactivo';
		end if;
        if not new.Estatus then
			set v_estatus_old = 'Inactivo';
		end if;
        
    
    insert into tbi_bitacora values(
			default,
			current_user(),
			'Update',
			'tbb_pacientes',
			concat_ws(' ','Se ha creado un modificado al paciente con NSS: ',old.NSS,'con los siguientes datos: \n',
			'NSS: ', old.NSS,' -> ',new.NSS, '\n', 
			'TIPO SEGURO: ', old.Tipo_Seguro,' -> ',new.Tipo_Seguro, '\n', 
			'ESTATUS MEDICO: ', old.Estatus_Medico,' -> ',new.Estatus_Medico, '\n', 
			'ESTATUS VIDA: ', old.	Estatus_Vida,' -> ',new.Estatus_Vida, '\n',
            'ESTATUS: ', v_estatus_old, '->',v_estatus_new, '\n'),
			default,
			default
		);
END

-- 4) AFTER DELETE
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbb_pacientes_AFTER_DELETE` AFTER DELETE ON `tbb_pacientes` FOR EACH ROW BEGIN
	declare v_estatus varchar(20) default 'Activo';
      
		if not old.Estatus then
			set v_estatus = 'Inactivo';
		end if;
    
    insert into tbi_bitacora values(
		default,
		current_user(),
		'Delete',
		'tbb_pacientes',
		concat_ws(' ','Se ha eliminado un paciente existente con NSS: ',old.NSS,'y con los siguientes datos: \n',
		'TIPO SEGURO: ', old.Tipo_Seguro, '\n', 
		'ESTATUS MEDICO: ', old.Estatus_Medico, '\n', 
		'ESTATUS VIDA: ', old.Estatus_Vida, '\n'
        'ESTATUS: ', v_estatus, '\n'),
		default,
		default
    );
END



-- Triggers para la tabla de Seguimiento Pacientes
-- 1) AFTER INSERT Seguimiento Pacientes
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbd_seguimiento_pacientes_AFTER_INSERT` AFTER INSERT ON `tbd_seguimiento_pacientes` FOR EACH ROW BEGIN
	  declare v_estatus varchar(20) default 'Activo';
      
		if not new.Estatus then
			set v_estatus = 'Inactivo';
		end if;
      
      insert into tbi_bitacora values(
		default,
		current_user(),
		'Create',
		'tbd_seguimiento_pacientes',
		concat_ws(' ','Se ha creado un nuevo seguimiento a paciente con los siguientes datos: \n',
		'Observaciones: ', new.Observaciones, '\n', 
        'ESTATUS: ', v_estatus, '\n'),
		default,
		default
    );
END

-- 2) BEFORE UPDATE
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbd_seguimiento_pacientes_BEFORE_UPDATE` BEFORE UPDATE ON `tbd_seguimiento_pacientes` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp(); 
END


-- 3) AFTER UPDATE
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbd_seguimiento_pacientes_AFTER_UPDATE` AFTER UPDATE ON `tbd_seguimiento_pacientes` FOR EACH ROW BEGIN
	 declare v_estatus_old varchar(20) default 'Activo';
     declare v_estatus_new varchar(20) default 'Activo';
      
		if not new.Estatus then
			set v_estatus_new = 'Inactivo';
		end if;
        if not new.Estatus then
			set v_estatus_old = 'Inactivo';
		end if;
        
    
    insert into tbi_bitacora values(
			default,
			current_user(),
			'Update',
			'tbd_seguimiento_pacientes',
			concat_ws(' ','Se ha creado un modificado seguimiento a paciente con id: ',old.Paciente_ID,'con los siguientes datos: \n',
			'Observaciones: ', old.Observaciones,' -> ',new.Observaciones, '\n', 
            'ESTATUS: ', v_estatus_old, '->',v_estatus_new, '\n'),
			default,
			default
		);
END

-- 4) AFTER DELETE
CREATE DEFINER=`justin.muñoz`@`%` TRIGGER `tbd_seguimiento_pacientes_AFTER_DELETE` AFTER DELETE ON `tbd_seguimiento_pacientes` FOR EACH ROW BEGIN
	declare v_estatus varchar(20) default 'Activo';
      
		if not old.Estatus then
			set v_estatus = 'Inactivo';
		end if;
    
    insert into tbi_bitacora values(
		default,
		current_user(),
		'Delete',
		'tbd_seguimiento_pacientes',
		concat_ws(' ','Se ha eliminado un seguimiento a paciente existente con id: ',old.Paciente_ID,'y con los siguientes datos: \n',
		'Observaciones: ', old.Observaciones, '\n', 
        'ESTATUS: ', v_estatus, '\n'),
		default,
		default
    );
END


