-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Arturo Aguilar Santos
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Queries para revisión y población de la tabla: Expedientes Medicos

-- 1. Verificar la construcción de la tabla
DESC tbd_expedientes_clinicos; 

-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_expedientes_clinicos("1234");

SELECT * FROM tbd_expedientes_clinicos; 
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbd_expedientes_clinicos" ORDER BY ID DESC;

-- 4. Realizamos una consulta joing para visualizar los datos poblados. 
SELECT p.id, CONCAT_WS(' ', NULLIF(p.titulo, ""), p.nombre, p.primer_apellido, p.segundo_apellido) as NombreCompleto,
ec.Interrogatorio_Sistemas,ec.Padecimiento_actual,ec.Notas_medicas, ec.Estatus
FROM tbb_personas p
JOIN tbd_expedientes_clinicos ec ON p.id = ec.persona_id
