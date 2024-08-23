CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_poblar_horarios_dinamicos`(
    IN Cantidad INT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    
    WHILE i < Cantidad DO
        INSERT INTO tbd_horarios (
            espacio_id, 
            servicio_medico_id, 
            departamento_id, 
            nombre, 
            especialidad, 
            dia_semana, 
            hora_inicio, 
            hora_fin, 
            turno, 
            tipo_horario, 
            fecha_creacion, 
            fecha_actualizacion
        )
        VALUES (
            1,                            -- Valor fijo para espacio_id
            2,                            -- Valor fijo para servicio_medico_id
            4,                            -- Valor fijo para departamento_id
            generar_nombre_horarios(),    -- Nombre dinámico
            generar_especialidad_horarios(), -- Especialidad dinámica
            generar_dia_semana_horarios(),   -- Día de la semana dinámico
            generar_hora_inicio_horarios(),  -- Hora de inicio dinámica
            generar_hora_fin_horarios(),     -- Hora de fin dinámica
            generar_turno_horarios(),        -- Turno dinámico
            generar_tipo_horarios(),         -- Tipo de horario dinámico
            CURRENT_TIMESTAMP,               -- Fecha de creación
            CURRENT_TIMESTAMP                -- Fecha de actualización
        );
        SET i = i + 1;
    END WHILE;
END