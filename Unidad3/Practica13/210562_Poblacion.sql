-- SCRIP DE EL PROCEDIMIENTO ALAMCENADO (ESTATICO) DE LA TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 23 de Julio del 2024

-- Procedimiento Almacenado ccon datos Estaticos de la Tabla: tbb_personas

DELIMITER $$
CREATE DEFINER=`jose.gomez`@`%` PROCEDURE `sp_poblar_personas`(v_password varchar(20))
BEGIN
if v_password='1234' then
INSERT INTO tbb_personas 
(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
VALUES
('Sra.', 'María', 'López', 'Martínez', 'LOMJ850202MDFRPL02', 'F', 'A+', '1985-02-02', b'1', NOW(), NULL),
('C.', 'Ana', 'Hernández', 'Ruiz', 'HERA900303HDFRRL03', 'F', 'B+', '1990-03-03', b'1', NOW(), NULL),
('Dr.', 'Carlos', 'García', 'Rodríguez', 'GARC950404HDFRRL04', 'M', 'AB+', '1995-04-04', b'1', NOW(), NULL),
('Lic.', 'Laura', 'Martínez', 'Gómez', 'MALG000505MDFRRL05', 'F', 'O-', '2000-05-05', b'1', NOW(), NULL),
('C.', 'Luis', 'Pérez', 'Sánchez', 'PESL010606HDFRRL06', 'M', 'A-', '2001-06-06', b'1', NOW(), NULL),
('C.', 'Mónica', 'López', 'Hernández', 'LOHM020707MDFRRL07', 'F', 'B-', '2002-07-07', b'1', NOW(), NULL),
('C.', 'Pedro', 'Gómez', 'Pérez', 'GOPP030808HDFRRL08', 'M', 'AB-', '2003-08-08', b'1', NOW(), NULL),
('C.', 'Sofía', 'Ruiz', 'López', 'RULS040909HDFRRL09', 'F', 'O+', '2004-09-09', b'1', NOW(), NULL),
('C.', 'José', 'Sánchez', 'García', 'SAGJ051010HDFRRL10', 'M', 'A+', '2005-10-10', b'1', NOW(), NULL);

UPDATE tbb_personas SET Primer_Apellido = 'Hernández', Estatus = b'0' WHERE ID = 1;

DELETE FROM tbb_personas where ID=2;
	 else
		select 'La contraseña es incorrecta, no puedo mostrar el estatus de la Base de Datos' As ErrorMessage;
	end if;
END $$
DELIMITER ;