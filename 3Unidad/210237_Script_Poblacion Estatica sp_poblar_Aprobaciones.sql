-- Scrip de la Creacion del Procedimeinto Estatico sp_poblar_Aprobaciones('1234')
-- Elaborado por Carlos Iván Crespo Alvarado
-- Programa Educativo: Ingenieria de Desarrollo y Gestion de Software
-- Fecha de Elaboración: 22 de julio de 2024

CREATE DEFINER=`carlos.crespo`@`%` PROCEDURE `sp_poblar_Aprobaciones`(IN v_password VARCHAR(255))
BEGIN
    IF v_password = '1234' THEN
        -- Insertar
		INSERT INTO tbb_aprobaciones (`id`, `personal_medico_id`, `solicitud_id`, `comentario`, `estatus`, `tipo`, `fecha_registro`) 
					VALUES ('1', '1', '1', 'Preuba de Solicitud', 'En Proceso', 'Servicio Interno', now());

		INSERT INTO tbb_aprobaciones (`id`, `personal_medico_id`, `solicitud_id`, `comentario`, `estatus`, `tipo`, `fecha_registro`) 
					VALUES ('2', '2', '2', 'Traslado a la sala de Cuidados Intensivos', 'En Proceso', 'Servicio Interno', now());

		INSERT INTO tbb_aprobaciones (`id`, `personal_medico_id`, `solicitud_id`, `comentario`, `estatus`, `tipo`, `fecha_registro`) 
					VALUES ('3', '3', '3', 'Traslado a la sala de Cuidados Intensivos', 'En Proceso', 'Servicio Interno', now());
                    
		INSERT INTO tbb_aprobaciones (`id`, `personal_medico_id`, `solicitud_id`, `comentario`, `estatus`, `tipo`, `fecha_registro`) 
					VALUES ('4', '4', '4', 'Solicitud de Cunas en Area de Maternida', 'Aprobado', 'Servicio Interno', now());
                    
		INSERT INTO tbb_aprobaciones (`id`, `personal_medico_id`, `solicitud_id`, `comentario`, `estatus`, `tipo`, `fecha_registro`) 
					VALUES ('5', '5', '5', 'Solicitud de Apertura de Area de Maternidad ', 'Aprobado', 'Servicio Interno', now());
        
        -- Actualizar
		UPDATE tbb_aprobaciones SET Estatus = 'Aprobado' WHERE Estatus = 'En Proceso' and id = 1;
		UPDATE tbb_aprobaciones SET tipo = 'Subrogado' WHERE tipo = 'Servicio Interno' and solicitud_id  = 4;
		UPDATE tbb_aprobaciones SET Comentario = 'Solicitud de traslado a la UTI' WHERE Comentario = 'Preuba de Solicitud' and id = 1;
        
        -- Eliminar
		delete from tbb_aprobaciones where id = 3;
        
    ELSE
        SELECT 'La contraseña es incorrecta, no puedo mostrarte los nacimientos de la base de datos' AS ErrorMessage;
    END IF;
END