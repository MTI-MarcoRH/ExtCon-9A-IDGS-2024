-- SCRIPT DE PRUEBA DE POBLACION Y JOIN DE EXPEDIENTES CLINICOS CON PERSONAS

-- Elaborado por: Arturo Aguilar Santos
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Queries para revisión y población de la tabla: Expedientes Medicos

-- 1. Verificar la construcción de la tabla
DESC tbd_expedientes_clinicos; 

-- 2. Procedimiento de población de Expedientes Clinícos
DELIMITER $$
CREATE DEFINER=`arturo.aguilar`@`%` PROCEDURE `sp_poblar_expedientes_clinicos`(v_password varchar(20))
BEGIN
	if v_password = "1234" then
		-- Primera Persona
        INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		('Sra.', 'María', 'López', 'Martínez', 'LOMJ850202PDFRPL01', 'F', 'A+', '1985-02-02', b'1', NOW(), NULL);
		-- Primero Expediente
		insert into tbd_expedientes_clinicos values(last_insert_id(),'Asma bronquial','Alergia a la penicilina','Alzheimer en abuelo materno','Todo bien','Gripe','Mas vitaminas',default, default, null);
        
        -- Segunda Persona
		INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		('C.', 'Ana', 'Hernández', 'Ruiz', 'HERA900303HDFRIL01', 'F', 'B+', '1990-03-03', b'1', NOW(), NULL);
		-- Segundo Expediente
        insert into tbd_expedientes_clinicos values(last_insert_id(),'Hipertensión arterial','Cirugía de apéndice a los 12 años.','Enfermedad cardíaca coronaria en padre y tíos paternos.','Frecuencia Cardiaca baja','Sano','Hidratarse más',default, default, null);

		-- Tercer Persona
        INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		('Dr.', 'Carlos', 'García', 'Rodríguez', 'GARC950404NDFRRL06', 'M', 'AB+', '1995-04-04', b'1', NOW(), NULL);
		-- Tercer Expediente
        insert into tbd_expedientes_clinicos values(last_insert_id(),'Hepatitis B previa','Historial de viajes a países tropicales','Cáncer colorrectal en primo hermano','Frecuencia Reepiratoria baja','En buenas condiciones','Necesita mas actividad fisica',default, default, null);

		-- Cuarta Persona
		INSERT INTO tbb_personas 
		(Titulo, Nombre, Primer_Apellido, Segundo_Apellido, CURP, Genero, Grupo_Sanguineo, Fecha_Nacimiento, Estatus, Fecha_Registro, Fecha_Actualizacion)
		VALUES
		('Lic.', 'Laura', 'Martínez', 'Gómez', 'MALG000505TDFRRL07', 'F', 'O-', '2000-05-05', b'1', NOW(), NULL);
		-- Cuarto Expediente
        insert into tbd_expedientes_clinicos values(last_insert_id(),'Artritis reumatoide','Ausencia de alergias conocidas a medicamentos.','Asma en hermano menor.','Presion baja','Salud Optima','No come bien',default, default, null);


		update tbd_expedientes_clinicos set Notas_Medicas = 'Necesita paracetamol' where Interrogatorio_sistemas = 'Presion baja';
		update tbd_expedientes_clinicos set estatus = b'0' where Interrogatorio_sistemas = 'Frecuencia Reepiratoria baja';
			
		delete from tbd_expedientes_clinicos where Interrogatorio_sistemas = 'Frecuencia Cardiaca baja';
		else
			select "La contraseña es incorrecta, no puedo mostrarte el estatus de la Base de Datos" as ErrorMessage;
		end if;
END$$
DELIMITER ;

-- 3. Poblar de manera estática la tabla.
CALL sp_poblar_expedientes_clinicos("1234");

SELECT * FROM tbd_expedientes_clinicos; 
-- 4. Verificamos el registro de los eventos en bitacora
SELECT * FROM tbi_bitacora WHERE tabla= "tbd_expedientes_clinicos" ORDER BY ID DESC;

-- 5. Realizamos una consulta joing para visualizar los datos poblados. 
SELECT p.id, CONCAT_WS(' ', NULLIF(p.titulo, ""), p.nombre, p.primer_apellido, p.segundo_apellido) as NombreCompleto,
ec.Interrogatorio_Sistemas,ec.Padecimiento_actual,ec.Notas_medicas, ec.Estatus
FROM tbb_personas p
JOIN tbd_expedientes_clinicos ec ON p.id = ec.persona_id
