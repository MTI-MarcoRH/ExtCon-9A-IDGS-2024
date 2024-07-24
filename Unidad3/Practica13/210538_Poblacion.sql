-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Elí Aidan Melo Calva
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Queries para revisión  y población de la tabla: Nacimientos

-- 1. Verificar la construcción de la tabla
DESC tbb_nacimientos;

-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_nacimientos("1234");

SELECT * FROM tbb_nacimientos;
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_nacimientos" ORDER BY ID DESC;