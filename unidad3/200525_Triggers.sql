-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: AMERICA YAELY ESTUDILLO LICONA
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024


-- Triggers para la tabla de Usuarios
-- 1) AFTER INSERT AREAS MEDICAS
DELIMITER &&
CREATE DEFINER=`america.estudillo`@`%` TRIGGER `tbc_areas_medicas_AFTER_INSERT` AFTER INSERT ON `tbc_areas_medicas` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (
        CURRENT_USER(),
        'Create',
        'tbc_areas_medicas',
        CONCAT('Se ha creado una nueva área médica con los siguientes datos:',
            '\nID: ', NEW.ID,
            '\nNombre: ', NEW.Nombre,
            '\nDescripción: ', NEW.Descripcion,
            '\nEstatus: ', NEW.Estatus,
            '\nFecha de Registro: ', NEW.Fecha_Registro),
        1,
        NOW()
    );
END
&&
DELIMITER ;
-- 2) BEFORE UPDATE
DELIMITER &&
CREATE DEFINER=`america.estudillo`@`%` TRIGGER `tbc_areas_medicas_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_areas_medicas` FOR EACH ROW BEGIN
	set new.fecha_actualizacion = current_timestamp();
END
&&
DELIMITER ;


-- 3) AFTER UPDATE
DELIMITER &&
CREATE DEFINER=`america.estudillo`@`%` TRIGGER `tbc_areas_medicas_AFTER_UPDATE` AFTER UPDATE ON `tbc_areas_medicas` FOR EACH ROW BEGIN
   IF OLD.Nombre != NEW.Nombre OR OLD.Descripcion != NEW.Descripcion OR OLD.Estatus != NEW.Estatus THEN
        INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
        VALUES (
            CURRENT_USER(),
            'Update',
            'tbc_areas_medicas',
            CONCAT('Se ha actualizado un área médica. Detalles de la actualización:',
                '\nID: ', NEW.ID,
                '\nNombre Anterior: ', OLD.Nombre,
                '\nNuevo Nombre: ', NEW.Nombre,
                '\nDescripción Anterior: ', OLD.Descripcion,
                '\nNueva Descripción: ', NEW.Descripcion,
                '\nEstatus Anterior: ', OLD.Estatus,
                '\nNuevo Estatus: ', NEW.Estatus,
                '\nFecha de Actualización: ', NOW()),
            1,
            NOW()
        );
    END IF;
END
&&
DELIMITER ;

-- 4) AFTER DELETE
DELIMITER &&
CREATE DEFINER=`america.estudillo`@`%` TRIGGER `tbc_areas_medicas_AFTER_DELETE` AFTER DELETE ON `tbc_areas_medicas` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora (Usuario, Operacion, Tabla, Descripcion, Estatus, Fecha_Registro)
    VALUES (
        CURRENT_USER(),
        'Delete',
        'tbc_areas_medicas',
        CONCAT('Se ha eliminado un área médica. Detalles de la eliminación:',
            '\nID: ', OLD.ID,
            '\nNombre: ', OLD.Nombre,
            '\nDescripción: ', OLD.Descripcion,
            '\nEstatus: ', OLD.Estatus,
            '\nFecha de Registro: ', OLD.Fecha_Registro),
        1,
        NOW()
    );
END
&&
DELIMITER ;




