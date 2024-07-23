-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: M.T.I. Marco A. Ramírez Hernández
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  18 de Julio de 2024

-- Queries para revisión  y población de la tabla: Personal Médico

-- 1. Verificar la construcción de la tabla
DESC tbb_personal_medico; 

-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_personal_medico("xyz#$%");

SELECT * FROM tbb_personal_medico; 
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_personal_medico" ORDER BY ID DESC;

-- 4. Realizamos una consulta joing para visualizar los datos poblados. 
SELECT p.id, CONCAT_WS(' ', NULLIF(p.titulo, ""), p.nombre, p.primer_apellido, p.segundo_apellido) as NombreCompleto,
pm.Especialidad, pm.tipo, d.nombre
FROM tbb_personas p
JOIN tbb_personal_medico pm ON p.id = pm.persona_id
JOIN tbc_departamentos d ON d.id=pm.departamento_id;