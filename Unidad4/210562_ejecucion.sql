-- SCRIP DE CREACIÓN DE EL PROCEDIMIENTO ALMACENADO DE LA TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 21 de agosto del 2024

-- Sentencia de ejecucion de la Tabla: tbb_personas

-- 1. Verificar la construcción de la tabla
DESC tbb_personas; 

-- 2. Poblar de manera dinamica la tabla.
CALL sp_poblar_personas_dinamico(20, "Médico");

SELECT * FROM tbb_personas; 
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_personas" ORDER BY ID DESC;
