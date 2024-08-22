-- SCRIPT DE CREACIÓN DE LAS FUNCIONES NECESARIAS PARA LA POBLACION DINAMICA DE LA TABLA ASIGNADA

-- Elaborado por: Justin Martin Muñoz Escorcia
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- calls de la Tabla: Pacientes y seguimiento pacientes

call hospital_general_9a_idgs_210659.sp_estatus_bd('xYz$123');
call hospital_general_9a_idgs_210659.sp_limpiar_bd('xYz$123');
call hospital_general_9a_idgs_210659.sp_poblar_personal_medico('xyz#$%');
call hospital_general_9a_idgs_210659.sp_poblar_personas('1234');
call hospital_general_9a_idgs_210659.sp_poblar_pacientes_dinamico(30);
call hospital_general_9a_idgs_210659.sp_poblar_seguimiento_pacientes_dinamico(4);

SELECT * FROM tbi_bitacora WHERE tabla= "tbb_pacientes" ORDER BY ID DESC;