-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Bruno Lemus Gonzalez
-- Grado y Grupo:  9° A  
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- 1. Verificar la construcción de la tabla
DESC tbc_espacios; 

-- 2. Poblar de manera estática la tabla.
CALL sp_poblar_espacios("xYz$123")

SELECT*FROM tbb_personal_medico;
-- 3. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi bitacora WHERE tabla= "tbb_pacientes" ORDER BY ID DESC;

-- 4. Realizamos una consulta joing para visualizar los datos poblados. 
SELECT e.Nombre As Nombre_Espacio, es. Nombre As Nombre_Espacio_Superior
FROM tbc_espacios e
LEFT JOIN tbc_espacios es ON e.Espacio_Superior_ID= es.ID;
