-- SCRIPT DE CRECACIÓN DE TABLAS ASIGNADAS

-- Elaborado por: Justin Martin Muñoz Escorcia
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Población de la tabla: Pacientes y Seguimiento Pacientes

-- . Procedimiento de pacientes

CREATE DEFINER=`justin.muñoz`@`%` PROCEDURE `sp_poblar_pacientes`(v_password varchar(10))
    DETERMINISTIC
BEGIN
IF v_password = "1234" then		
-- Insertamos los datos de la persona del primer paciente
INSERT INTO tbb_personas 
(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
VALUES
('Sra.', 'María', 'López', 'Martínez', 'LOMJ850202MDFRPL01', 'F', 'A+', '1985-02-02', b'1', NOW(), NULL);
INSERT INTO `tbb_pacientes` VALUES (last_insert_id(),NULL,'Sin Seguro','2009-03-17 17:31:00',default,'Vivo',1,'2001-02-15 06:23:05',NULL);
-- Insertamos los datos de la persona del segundo paciente
INSERT INTO tbb_personas 
(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
VALUES
(NULL, 'Ana', 'Hernández', 'Ruiz', 'HERA900303HDFRRL01', 'F', 'B+', '1990-03-03', b'1', NOW(), NULL);
INSERT INTO `tbb_pacientes` VALUES (last_insert_id(),NULL,'Sin Seguro','2019-05-01 13:15:29',default,'Vivo',1,'2020-06-28 18:46:37',NULL);
-- Insertamos los datos de la persona del tercer paciente
INSERT INTO tbb_personas 
(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
VALUES
('Dr.', 'Carlos', 'García', 'Rodríguez', 'GARC950404HDFRRL06', 'M', 'AB+', '1995-04-04', b'1', NOW(), NULL);
INSERT INTO `tbb_pacientes` VALUES (last_insert_id(),'G9OA6QW29V8DVXS','Seguro Popular','2024-02-16 13:10:48',default,'Vivo',1,'2024-02-18 16:05:14',NULL);
-- Insertamos los datos de la persona del cuarto paciente
INSERT INTO tbb_personas 
(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
VALUES
('Lic.', 'Laura', 'Martínez', 'Gómez', 'MALG000505MDFRRL07', 'F', 'O-', '2000-05-05', b'1', NOW(), NULL);
INSERT INTO `tbb_pacientes` VALUES (last_insert_id(),"12254185844-3",'Particular','2022-08-16 12:05:35',default,'Vivo',1,'2022-08-16 11:50:00',NULL);

update tbb_pacientes set NSS = "JL4HVKXPI3PX999" where NSS = "G9OA6QW29V8DVXS";
delete from tbb_pacientes where NSS = "JL4HVKXPI3PX999";
    
    
    else
		select "La contraseña es incorrecta" as mensaje;
        end if;
END




-- . Poblar de manera estática la tabla.
call sp_poblar_pacientes('1234');

SELECT * FROM tbb_pacientes; 
-- . Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbb_pacientes" ORDER BY ID DESC;

-- . Realizamos una consulta joing para visualizar los datos poblados. 
SELECT CONCAT_WS(' ', NULLIF(p.titulo,""),p.nombre,p.primer_apellido,p.segundo_apellido) as NombreCompleto,
fn_calcula_edad(p.fecha_nacimiento) as edad,pa.nss,pa.estatus_vida
FROM tbb_personas p
join tbb_pacientes pa ON  p.id=pa.persona_id;






-- . Procedimiento de llenado estatico de Seguimiento Pacientes

CREATE DEFINER=`justin.muñoz`@`%` PROCEDURE `sp_poblar_seguimiento_pacientes`(v_password varchar(10))
    DETERMINISTIC
BEGIN
IF v_password = "1234" then
INSERT INTO tbd_seguimiento_pacientes
		(Paciente_ID, Personal_Medico_ID,Observaciones,Estatus, Fecha_Registro, Fecha_Actualizacion)
        values
        (4,6,"Mal seguimiento con la Dieta",  1, NOW(), NULL);
        
INSERT INTO tbd_seguimiento_pacientes
		(Paciente_ID, Personal_Medico_ID,Observaciones,Estatus, Fecha_Registro, Fecha_Actualizacion)
        values
        (1,5,"Falta de asistencia a revision",  1, NOW(), NULL);
        
INSERT INTO tbd_seguimiento_pacientes
		(Paciente_ID, Personal_Medico_ID,Observaciones,Estatus, Fecha_Registro, Fecha_Actualizacion)
        values
        (2,7,"Medicamento sin efecto",  1, NOW(), NULL);

update tbd_seguimiento_pacientes set Observaciones = "Falta de asistencia a 2 revisiones" where Observaciones = "Falta de asistencia a revision";
delete from tbd_seguimiento_pacientes where Paciente_ID = 1;
    


    else
		select "La contraseña es incorrecta" as mensaje;
        end if;
END

-- . Poblar de manera estática la tabla.
call sp_poblar_seguimiento_pacientes('1234');

SELECT * FROM tbd_seguimiento_pacientes; 
-- . Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbd_seguimiento_pacientes" ORDER BY ID DESC;
