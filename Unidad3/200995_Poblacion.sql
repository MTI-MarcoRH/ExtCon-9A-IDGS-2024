-- SCRIPT DE CREACION DE PROCEDIMIENTOS ALMACENADOS
-- Elaborado por: Jesus Rios Gomez
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Archivo: procedimientos.sql

CREATE DEFINER=`jesus.rios`@`%` PROCEDURE `sp_poblar_puestos`(IN v_password VARCHAR(20))
BEGIN
    IF v_password = '1234' THEN
        -- Insertar puestos en la tabla tbc_puestos
        INSERT INTO tbc_puestos (Nombre, Descripcion, Salario, Turno, Creado, Modificado) VALUES 
        ('Médicos', 'Profesionales médicos que diagnostican y tratan a los pacientes', 5000.00, 'Mañana', NOW(), NOW()),
        ('Enfermeras', 'Proporcionan cuidados directos a los pacientes', 3000.00, 'Tarde', NOW(), NOW()),
        ('Técnicos de laboratorio', 'Realizan análisis clínicos y pruebas de laboratorio', 2500.00, 'Mañana', NOW(), NOW()),
        ('Técnicos radiológicos', 'Realizan estudios por imágenes como radiografías y resonancias', 2600.00, 'Tarde', NOW(), NOW()),
        ('Técnicos de farmacia', 'Ayudan en la dispensación y gestión de medicamentos', 2400.00, 'Mañana', NOW(), NOW()),
        ('Asistentes médicos', 'Apoyan a los médicos en consultas y procedimientos', 2800.00, 'Mañana', NOW(), NOW()),
        ('Personal administrativo', 'Gestiona tareas administrativas y de recepción', 2200.00, 'Mañana', NOW(), NOW()),
        ('Personal de limpieza', 'Mantiene la limpieza y el orden en las instalaciones', 1800.00, 'Noche', NOW(), NOW()),
        ('Terapeutas ocupacionales', 'Ayudan a pacientes a recuperar habilidades para la vida diaria', 2700.00, 'Mañana', NOW(), NOW()),
        ('Fisioterapeutas', 'Realizan terapias físicas para la rehabilitación de pacientes', 2800.00, 'Tarde', NOW(), NOW()),
        ('Logopedas', 'Especializados en trastornos del habla y lenguaje', 2600.00, 'Mañana', NOW(), NOW()),
        ('Administradores de salud', 'Gestionan operaciones y recursos en el ámbito de la salud', 3500.00, 'Tarde', NOW(), NOW()),
        ('Cocineros', 'Preparan comidas nutritivas para pacientes y personal', 2000.00, 'Mañana', NOW(), NOW()),
        ('Dietistas', 'Planifican dietas personalizadas según necesidades de los pacientes', 2300.00, 'Tarde', NOW(), NOW()),
        ('Personal de seguridad', 'Garantizan la seguridad y el orden dentro del hospital', 2100.00, 'Noche', NOW(), NOW()),
        ('Personal de mantenimiento', 'Realizan mantenimiento preventivo y correctivo de instalaciones', 1900.00, 'Tarde', NOW(), NOW()),
        ('Investigadores médicos', 'Conductores de investigación clínica y científica', 3800.00, 'Día', NOW(), NOW()),
        ('Educadores médicos', 'Imparten conocimientos y formación a profesionales de la salud', 3200.00, 'Mañana', NOW(), NOW()),
        ('Voluntarios', 'Ofrecen su tiempo y servicios de manera voluntaria', 0.00, 'Noche', NOW(), NOW());

        -- Actualizar un puesto específico
        -- Ejemplo: Actualizar el salario del puesto con nombre 'Médicos'
        UPDATE tbc_puestos
        SET Salario = 5200.00, Modificado = NOW()
        WHERE Nombre = 'Médicos';

        -- Eliminar un puesto específico
        -- Ejemplo: Eliminar el puesto con nombre 'Educadores médicos'
        DELETE FROM tbc_puestos
        WHERE Nombre = 'Educadores médicos';
    ELSE
        SELECT "La contraseña es incorrecta, no puedo mostrar el estatus de la Base de Datos" AS ErrorMessage;
    END IF;
END;

-- Llamar al procedimiento sp_poblar_puestos
CALL sp_poblar_puestos('1234');


CREATE DEFINER=`jesus.rios`@`%` PROCEDURE `sp_poblar_puestos_departamentos`(IN v_password VARCHAR(20))
BEGIN
    IF v_password = '1234' THEN
        -- Inserción de cinco registros reales
        INSERT INTO tbd_puestos_departamentos (Nombre, Descripcion, Salario, Turno, DepartamentoID)
        VALUES
            ('Medico General', 'Responsable de consultas generales', 50000.00, 'Manana', 1),
            ('Enfermero', 'Responsable de cuidado de pacientes', 30000.00, 'Tarde', 2),
            ('Cirujano', 'Responsable de realizar cirugias', 70000.00, 'Noche', 3),
            ('Pediatra', 'Especialista en cuidado de ninos', 55000.00, 'Manana', 13),
            ('Radiologo', 'Responsable de estudios de imagen', 60000.00, 'Tarde', 21);

        -- Actualización de uno de los registros
        UPDATE tbd_puestos_departamentos
        SET Salario = 52000.00, Modificado = CURRENT_TIMESTAMP
        WHERE Nombre = 'Medico General';

        -- Eliminación de uno de los registros
        DELETE FROM tbd_puestos_departamentos
        WHERE Nombre = 'Enfermero';
    ELSE
        SELECT 'La contraseña es incorrecta' AS Mensaje;
    END IF;
END;

-- Llamar al procedimiento sp_poblar_puestos_departamentos
CALL sp_poblar_puestos_departamentos('1234');
