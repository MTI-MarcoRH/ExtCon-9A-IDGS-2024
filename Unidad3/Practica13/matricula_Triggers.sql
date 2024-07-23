-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: M.T.I. Marco A. Ramírez Hernández
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  18 de Julio de 2024


-- Triggers para la tabla de Usuarios
-- 1) AFTER INSERT USUARIOS
DELIMITER &&
CREATE DEFINER=`root`@`localhost` TRIGGER `tbb_usuarios_AFTER_INSERT` AFTER INSERT ON `tbb_usuarios` FOR EACH ROW BEGIN

	INSERT INTO tbi_bitacora VALUES
    (DEFAULT,
    current_user(), 
    'Create', 
    'tbb_usuarios', 
    CONCAT_WS(' ','Se ha creado un nuevo usuario con los siguientes datos:',
    'ID: ', new.id, '\n',
    'PERSONA ID: ', new.persona_id, '\n',
    'NOMBRE USUARIO: ', new.nombre_usuario, '\n',
    'CORREO ELECTRÓNICO: ', new.correo_electronico, '\n',
    'CONTRASEÑA: ', new.contrasena, '\n',
    'NÚMERO TELEFÓNICO MÓVIL: ', new.numero_telefonico_movil, '\n',
    'ESTATUS: ', new.estatus, '\n'),
    DEFAULT, DEFAULT);

END
&&
DELIMITER ;

-- 2) BEFORE UPDATE
DELIMITER &&
CREATE DEFINER=`root`@`localhost` TRIGGER `tbb_usuarios_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_usuarios` FOR EACH ROW BEGIN
	SET new.fecha_actualizacion = current_timestamp();
END
&&
DELIMITER ;


-- 3) AFTER UPDATE
DELIMITER &&
&&
CREATE DEFINER=`root`@`localhost` TRIGGER `tbb_usuarios_AFTER_UPDATE` AFTER UPDATE ON `tbb_usuarios` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES
    (DEFAULT,
    current_user(), 
    'Update', 
    'tbb_usuarios', 
    CONCAT_WS(' ','Se ha creado un modificado ul usuario con ID :', old.id,"con los 
    siguientes datos: \n",
    'PERSONA ID: ', old.persona_id, ' - ', new.persona_id, '\n',
    'NOMBRE USUARIO: ', old.nombre_usuario, ' - ', new.nombre_usuario, '\n',
    'CORREO ELECTRÓNICO: ', old.correo_electronico, ' - ',new.correo_electronico, '\n',
    'CONTRASEÑA: ', old.contrasena, ' - ',new.contrasena, '\n',
    'NÚMERO TELEFÓNICO MÓVIL: ', old.numero_telefonico_movil, ' - ',new.numero_telefonico_movil, '\n',
    'ESTATUS: ', old.estatus, ' - ',new.estatus, '\n'),
    DEFAULT, DEFAULT);
END
DELIMITER ;

-- 4) AFTER DELETE
DELIMITER &&
&&
CREATE DEFINER=`root`@`localhost` TRIGGER `tbb_usuarios_AFTER_DELETE` AFTER DELETE ON `tbb_usuarios` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES
    (DEFAULT,
    current_user(), 
    'Delete', 
    'tbb_usuarios', 
    CONCAT_WS(' ','Se ha eliminado un usuario existente con los siguientes datos:',
    'ID: ', old.id, '\n',
    'PERSONA ID: ', old.persona_id, '\n',
    'NOMBRE USUARIO: ', old.nombre_usuario, '\n',
    'CORREO ELECTRÓNICO: ', old.correo_electronico, '\n',
    'CONTRASEÑA: ', old.contrasena, '\n',
    'NÚMERO TELEFÓNICO MÓVIL: ', old.numero_telefonico_movil, '\n',
    'ESTATUS: ', old.estatus, '\n'),
    DEFAULT, DEFAULT);
END
DELIMITER ;




