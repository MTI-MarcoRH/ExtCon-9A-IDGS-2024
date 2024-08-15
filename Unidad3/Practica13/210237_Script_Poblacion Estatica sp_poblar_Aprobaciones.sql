-- Scrip de la Creacion del Procedimeinto Estatico sp_poblar_Aprobaciones('1234')
-- Elaborado por Carlos Iván Crespo Alvarado
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingenieria de Desarrollo y Gestion de Software
-- Fecha de Elaboración: 22 de julio de 2024


-- Querys para revision de la tabla : Aprobaciones 

-- 1. Verifica la Constriccion de la Tabla
desc tbb_aprobaciones;

-- 2. Poblar de manera estatica la tabla
call sp_poblar_Aprobaciones("1234");
select * from tbb_aprobaciones;

-- 3. Verifica el registro de los eventos en la bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_aprobaciones" ORDER BY ID DESC;

-- 4. Realizamos una consulta Join para visualzar los datos poblados
SELECT p.id, CONCAT_WS(' ', NULLIF(p.titulo, ""), p.nombre, p.primer_apellido, p.segundo_apellido) 
as Solicitante, s.Prioridad, s.Descripcion, a.Comentario, a.Estatus, a.Tipo, a.Fecha_Registro, a.fecha_actualizacion
FROM tbb_personas p
JOIN tbd_solicitudes s ON p.id = s.id
JOIN tbb_aprobaciones a ON a.id=s.id;


-- Para llamar el procedimeinto 
-- Call sp_poblar_Aprobaciones('1234');
-------------------------------------------------------------------------------------------------------------------

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
					VALUES ('4', '2', '4', 'Solicitud de Cunas en Area de Maternida', 'Aprobado', 'Servicio Interno', now());
         
         /* Depende del numero solicitudes registradas en la tbd_solicitudes
		INSERT INTO tbb_aprobaciones (`id`, `personal_medico_id`, `solicitud_id`, `comentario`, `estatus`, `tipo`, `fecha_registro`) 
					VALUES ('5', '1', '5', 'Solicitud de Apertura de Area de Maternidad ', 'Aprobado', 'Servicio Interno', now());
		*/
        -- Actualizar
		UPDATE tbb_aprobaciones SET Estatus = 'Aprobado' WHERE Estatus = 'En Proceso' and ID = 1;
		UPDATE tbb_aprobaciones SET Tipo = 'Subrogado' WHERE Tipo = 'Servicio Interno' and ID  = 4;
		UPDATE tbb_aprobaciones SET Comentario = 'Solicitud de traslado a la UTI' WHERE Comentario = 'Preuba de Solicitud' and id = 1;
        
        -- Eliminar
		delete from tbb_aprobaciones where id = 2;
        
    ELSE
        SELECT 'La contraseña es incorrecta, no puedo mostrarte los nacimientos de la base de datos' AS ErrorMessage;
    END IF;
END