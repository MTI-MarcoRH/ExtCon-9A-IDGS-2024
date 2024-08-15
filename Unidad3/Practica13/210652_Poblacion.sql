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


-- SCRIPT DE CRECACIÓN del Procedimiento

-- Elaborado por: Bruno Lemus Gonzalez
-- Grado y Grupo:  9° A  
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  05 de Agosto de 2024

--Procedimiento sp_poblar_espacios

CREATE DEFINER=`bruno.lemus`@`%` PROCEDURE `sp_poblar_espacios`(v_password VARCHAR(20))
BEGIN
	DECLARE id_espacio_superior_1 INT DEFAULT 0;
    DECLARE id_espacio_superior_2 INT DEFAULT 0;
    IF v_password = "xYz$123" THEN
        -- Insertar varios registros en la tabla tbd_espacio
        
        
        -- INSERTAMOS EL EDIFICIO 1 - Medicina General
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Edificio', 'Medicina General',1 ,NULL,DEFAULT, DEFAULT);
        SET id_espacio_superior_1= last_insert_id();
		
        -- Espacios de Nivel 2 
       INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Piso', 'Planta Baja',56 ,id_espacio_superior_1,DEFAULT,DEFAULT);
        SET id_espacio_superior_2= last_insert_id();
        -- Espacios de Nivel 3
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Consultorio', 'A-101',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-102',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-103',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-104',17 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Consultorio', 'A-105',17 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Quirófano', 'A-106',16 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Quirófano', 'A-107',16 ,id_espacio_superior_2,DEFAULT, DEFAULT), 
        ('Sala de Espera', 'A-108',16 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Sala de Espera', 'A-109',16 ,id_espacio_superior_2,DEFAULT, DEFAULT);
           
             
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Piso', 'Planta Alta',56, id_espacio_superior_1,DEFAULT, DEFAULT);
        SET id_espacio_superior_2= last_insert_id();
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Espacio_Superior_ID, Capacidad, Estatus) VALUES
        ('Habitación', 'A-201',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-202',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-203',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-204',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Habitación', 'A-205',11 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Laboratorio', 'A206',23 ,id_espacio_superior_2,DEFAULT, DEFAULT),
        ('Capilla', 'A-207',56 ,id_espacio_superior_2,DEFAULT, DEFAULT), 
        ('Recepción', 'A-208',1 ,id_espacio_superior_2,DEFAULT, DEFAULT);
        
        /*
        -- INSERTAMOS EL EDIFICIO 2 - Medicina de Especialidad
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Estatus, Capacidad, Espacio_Superior_ID) VALUES
        ('Oficina', 'Oficina Quirúrgica', 'Recursos Humanos', 'Activo', 10, 'Piso 3, Edificio Principal');
        -- INSERTAMOS EL EDFICIO 3 -  Areas Administrativas
        INSERT INTO tbc_espacios(Tipo, Nombre, Departamento_ID, Estatus, Capacidad, Espacio_Superior_ID) VALUES
        ('Oficina', 'Oficina Quirúrgica', 'Recursos Humanos', 'Activo', 10, 'Piso 3, Edificio Principal');
        */
      


        -- Realizar algunas actualizaciones o eliminaciones si es necesario
        UPDATE tbc_espacios SET Estatus= 'En remodelación' WHERE nombre = 'A-105';
        UPDATE tbc_espacios SET Capacidad = 80 WHERE nombre = 'A-109';
        
        DELETE FROM tbc_espacios WHERE nombre = 'A-207';
        

    ELSE
        SELECT "La contraseña es incorrecta, no puedo proceder con la inserción de registros" AS ErrorMessage;
    END IF;
END
