-- Script de poblar de la tabla tbb_citas_medicas 


-- Elaborado por : Janeth Ahuacatitla Amixtlan
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 23 de julio de 2024 

CREATE DEFINER=`janeth.ahuacatitla`@`%` PROCEDURE `sp_poblar_citas_medicas`(v_password VARCHAR(20))
BEGIN
	
	IF v_password = "1234" THEN
    
    
    
	INSERT INTO tbb_citas_medicas (Tipo, Paciente_ID, Personal_medico_ID, Servicio_Medico_ID,
    Espacio_ID, Fecha_Programada, Estatus, Observaciones)
	VALUES
	('Revisión',  5, 1,1, 3, '2024-08-15 10:00:00','Programada', 'Sin Observaciones'),
	('Diagnóstico',  5, 2,5, 3, '2024-07-18 10:20:00', 'En proceso','Sin Observaciones'),
	('Seguimiento', 6, 3, 1,5, '2024-06-30 11:00:00', 'Atendida',  'El paciente se encuentra estable'),
	('Revisión',  8, 3, 1,5, '2024-05-02 09:45:00', 'Cancelada','Sin Observaciones'),
    ('Diagnóstico', 8,3, 1, 6, '2024-07-01 09:00:00','Atendida', 
    'Se diagnosticó en el paciente una gripa estacionaria, se le asigno tratamiento.');
    
	UPDATE tbb_citas_medicas 
    SET Fecha_Programada = '2024-08-30 09:30:00', Estatus = "Reprogramada" WHERE ID = 1;
    
	DELETE FROM tbb_citas_medicas WHERE ID=4;
    
	ELSE
	SELECT "La contraseña es incorrecta, no puedo realizar la operación" AS ErrorMessage;
	END IF;

END