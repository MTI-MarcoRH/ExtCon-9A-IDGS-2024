-- SCRIPT DE CREACIÓN Y POBLACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Armando Carrasco Vargas
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2023

-- Queries para revisión y población de la tabla: Estudios

-- 1. Verificar la construcción de las tablas
DESC tbd_resultados_estudios; 

-- 2. Poblar de manera estática las tablas
call sp_poblar_personal_medico("xyz#$%");
call sp_poblar_pacientes("1234");
call sp_poblar_estudios("123");
call sp_poblar_resultados_estudios("1234");


-- 3. Verificamos el registro de los eventos en bitácora para resultados de estudios
SELECT * FROM tbi_bitacora WHERE tabla = "tbd_resultados_estudios" ORDER BY ID DESC;

-- 4. Realizamos una consulta JOIN para visualizar los datos poblados en resultados de estudios
SELECT re.ID, re.Folio, re.Resultados, re.Observaciones, re.Estatus, 
CONCAT_WS(' ', NULLIF(pac.Titulo, ""), pac.Nombre, pac.Primer_Apellido, pac.Segundo_Apellido) as NombreCompletoPaciente,
CONCAT_WS(' ', NULLIF(pm.Titulo, ""), pm.Nombre, pm.Primer_Apellido, pm.Segundo_Apellido) as NombreCompletoMedico,
es.Tipo as TipoEstudio
FROM tbd_resultados_estudios re
JOIN tbb_personas pac ON re.Paciente_ID = pac.ID
JOIN tbb_personas pm ON re.Personal_Medico_ID = pm.ID
JOIN tbc_estudios es ON re.Estudio_ID = es.ID;