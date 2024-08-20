-- SCRIP DE CREACIÓN DE EL PROCEDIMIENTO ALMACENADO DE LA TABLA ASIGNADA

-- Elaborado por: Romualdo Perez Romero
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  23 de Julio de 2024

-- Procedimiento almacenado de la Tabla: tbb_valoraciones_medicas

CREATE DEFINER=`romualdo`@`localhost` PROCEDURE `sp_poblado_dinamico_valoraciones_medicas`(IN cantidad INT, IN v_password VARCHAR(20))
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE valor DECIMAL(10,2);
    DECLARE indicador VARCHAR(50);
    DECLARE unidad_medida VARCHAR(50);
    DECLARE paciente_id INT;
    DECLARE cita_id INT;
    DECLARE pm_id INT;

    IF v_password = 'hola123' THEN

		WHILE i < cantidad DO
			-- Generar valores para Paciente_id, Cita_id, y Pm_id
			SET paciente_id = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(1, 100);
			SET cita_id = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(1, 50);
			SET pm_id = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(1, 20);

			-- Asignar indicador y unidad de medida en conjunto para asegurar coherencia
			SET indicador = hospital_general_9a_idgs_matricula.fn_indicador_aleatorio();
			
			IF indicador = 'Peso' THEN
				SET unidad_medida = 'kg';
				SET valor = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(30, 150);
			ELSEIF indicador = 'Altura' THEN
				SET unidad_medida = 'cm';
				SET valor = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(50, 200);
			ELSEIF indicador = 'Presión' THEN
				SET unidad_medida = 'mmHg';
				SET valor = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(60, 180);
			ELSEIF indicador = 'Frecuencia cardíaca' THEN
				SET unidad_medida = 'bpm';
				SET valor = hospital_general_9a_idgs_matricula.fn_numero_aleatorio_rangos(60, 100);
			END IF;

			-- Insertar el registro en la tabla tbb_valoraciones_medicas
			INSERT INTO hospital_general_9a_idgs_matricula.tbb_valoraciones_medicas 
			(Valor, Indicador, Unidad_medida, Paciente_id, Cita_id, Pm_id, Estatus, Fecha_registro)
			VALUES 
			(valor, indicador, unidad_medida, paciente_id, cita_id, pm_id, 1, NOW());

			SET i = i + 1;
		END WHILE;
    end if;
END