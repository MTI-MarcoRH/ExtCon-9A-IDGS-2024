-- Script de poblar de la tabla tbc_medicamentos


-- Elaborado por : Cristian Eduardo Ojeda Gayosso
-- Grado y Grupo: 9° A
-- Programa educativo: Ingenieria de Desarrollo  y Gestion de Software
-- Fecha elaboración: 21 de julio de 2024 

CREATE DEFINER=`Cristian.Ojeda`@`%` PROCEDURE `sp_poblar_medicamentos`(IN v_password VARCHAR(20))
BEGIN
 IF v_password = 'xYz$123' THEN
  -- Inserción de cinco registros reales
    INSERT INTO tbc_medicamentos (Nombre_comercial, Nombre_generico, Via_administracion, Presentacion, Tipo, Cantidad, Volumen, Estatus)
    VALUES
    ('Tylenol', 'Paracetamol', 'Oral', 'Comprimidos', 'Analgésicos', 10, 0.0, default),
    ('Amoxil', 'Amoxicilina', 'Oral', 'Cápsulas', 'Antibióticos', 5, 0.0, 0),
    ('Zoloft', 'Sertralina', 'Oral', 'Comprimidos', 'Antidepresivos', 20, 0.0, default),
    ('Claritin', 'Loratadina', 'Oral', 'Grageas', 'Antihistamínicos', 15, 0.0, default),
    ('Advil', 'Ibuprofeno', 'Oral', 'Comprimidos', 'Antiinflamatorios', 30, 0.0, default);

    -- Actualización de uno de los registros
    UPDATE tbc_medicamentos
    SET Cantidad = 75, Volumen = 10.0
    WHERE Nombre_comercial = 'Tylenol';

    -- Eliminación de uno de los registros
    DELETE FROM tbc_medicamentos
    WHERE Nombre_comercial = 'Amoxil';
  END IF;
END