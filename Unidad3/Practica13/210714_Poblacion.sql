-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Queries para revisión  y población de la tabla: Valoraciones Medicas

CREATE DEFINER=`romualdo`@`%` PROCEDURE `sp_poblar_valoraciones_medicas`(v_password varchar(20))
BEGIN
IF v_password = "hola123" THEN
	




INSERT INTO tbb_valoraciones_medicas (
	id, paciente_id, fecha, antecedentes_personales, antecedentes_familiares, antecedentes_medicos, sintomas_signos, examen_fisico, pruebas_diagnosticas,
    diagnostico, plan_tratamiento, seguimiento) VALUES (1, 1,'2024-06-06','Sin antecedentes personales relevantes', 'Madre con diabetes tipo 2',
    'Hipertensión arterial diagnosticada hace 5 años', 'Dolor abdominal, náuseas', 'Abdomen distendido, signo de Murphy positivo', 'Ecografía abdominal',
    'Colecistitis aguda', 'Colecistectomía laparoscópica programada', 'Control postoperatorio en una semana');

INSERT INTO tbb_valoraciones_medicas (
	id, paciente_id, fecha, antecedentes_personales, antecedentes_familiares, antecedentes_medicos, sintomas_signos, examen_fisico, pruebas_diagnosticas,
    diagnostico, plan_tratamiento, seguimiento) VALUES (2, 2, '2024-06-07', 'Fumador ocasional', 'Padre con hipertensión', 'Asma diagnosticada en la infancia',
    'Tos persistente, dificultad para respirar', 'Sibilancias en ambos campos pulmonares', 'Espirometría', 'Asma bronquial', 'Tratamiento con broncodilatadores',
    'Revisión en dos semanas');

INSERT INTO tbb_valoraciones_medicas (
    id, paciente_id, fecha, antecedentes_personales, antecedentes_familiares, antecedentes_medicos, sintomas_signos, examen_fisico, pruebas_diagnosticas,
    diagnostico, plan_tratamiento, seguimiento) VALUES(3, 3, '2024-06-07', 'Deportista regular, sin antecedentes de tabaquismo', 'Madre con osteoporosis',
    'Ninguno', 'Dolor en la rodilla derecha al correr', 'Inflamación en la rodilla derecha', 'Radiografía de rodilla', 'Tendinitis rotuliana', 'Fisioterapia y antiinflamatorios',
    'Revisión en un mes');

INSERT INTO tbb_valoraciones_medicas (
id, paciente_id, fecha, antecedentes_personales, antecedentes_familiares, antecedentes_medicos, sintomas_signos, examen_fisico, pruebas_diagnosticas,
    diagnostico, plan_tratamiento, seguimiento) VALUES (4, 4, '2024-06-07', 'Alergia a los mariscos', 'Hermano con asma', 'Alergias estacionales',
    'Erupción cutánea y picazón después de comer mariscos', 'Erupciones eritematosas en brazos y piernas', 'Pruebas de alergia cutánea', 'Alergia alimentaria a mariscos',
    'Antihistamínicos y evitar mariscos', 'Revisión en tres meses');

UPDATE tbb_valoraciones_medicas
SET plan_tratamiento = 'Nuevo plan de tratamiento'
WHERE id = 1;


DELETE FROM tbb_valoraciones_medicas
WHERE paciente_id = 1;



ELSE
	select "La contraseña es incorrecta, no puedo mostrarte el estatus de la base de datos"  AS ErrorMessage;
END IF;
END