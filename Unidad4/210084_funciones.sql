
-- Script de creacion de funciones para la tabla de tbb_citas_medicas


-- Elaborado por : Janeth Ahuacatitla Amixtlan 
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 05 de agosto de 2024 

CREATE DEFINER=`janeth.ahuacatitla`@`%` FUNCTION `fn_paciente_fallecido`(p_paciente_id INT)
RETURNS BOOLEAN
BEGIN
    DECLARE v_fallecido BOOLEAN;

    -- Consulta si el paciente está marcado como fallecido
    SELECT fallecido INTO v_fallecido
    FROM pacientes
    WHERE paciente_id = p_paciente_id;
    
    -- Devuelve TRUE si el paciente está fallecido, de lo contrario FALSE
    RETURN v_fallecido;
END
