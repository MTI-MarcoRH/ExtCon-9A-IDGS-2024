-- FUNCIONES DE TABLA ASIGNADA

-- Elaborado por: Jonathan Enrique Ibarra Canales
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  4 de Agosto de 2024



-- 1.1 Funcion para calcular la fecha de nacimiento

DELIMITER $$
DROP function IF EXISTS `fn_genera_fecha_nacimiento`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_fecha_nacimiento`(fecha_inicio DATE, fecha_fin DATE) RETURNS date
    DETERMINISTIC
BEGIN
    DECLARE min_dias INT;
    DECLARE max_dias INT;
    DECLARE dias_aleatorios INT;
    DECLARE fecha_aleatoria DATE;

    SET min_dias = DATEDIFF(fecha_inicio, '1900-01-01');
    SET max_dias = DATEDIFF(fecha_fin, '1900-01-01');
    SET dias_aleatorios = fn_numero_aleatorio_rangos(min_dias, max_dias);
    SET fecha_aleatoria = DATE_ADD('1900-01-01', INTERVAL dias_aleatorios DAY);

    RETURN fecha_aleatoria;
END
&&
DELIMITER ;




-- 1.2 Funcion badera porcentaje
DELIMITER &&
DROP function IF EXISTS `fn_bandera_porcentaje`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_bandera_porcentaje`(v_porcentaje INT) RETURNS int
    DETERMINISTIC
BEGIN
   /* Declaración de una variable con un valor aleatorio de entre 0 y 100*/
   DECLARE v_valor INT DEFAULT (fn_numero_aleatorio_rangos(0,100));
   /* Declaración de una variable booleana con valor inicial de falso */
   DECLARE v_bandera BOOLEAN DEFAULT false;
   
   IF v_valor <= v_porcentaje THEN 
      SET v_bandera = true;
   END IF;
   RETURN v_bandera;
END
&&
DELIMITER ;




-- 1.3 Funcion para generar el nombre de la persona
DELIMITER &&
DROP function IF EXISTS `fn_genera_nombre`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_nombre`(v_genero CHAR(1)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE v_nombre_generado VARCHAR(50) DEFAULT NULL;
    DECLARE v_nombre2_generado VARCHAR(50) DEFAULT NULL;    

    DECLARE v_bandera_nombrecompuesto BOOLEAN DEFAULT (fn_bandera_porcentaje(35));
    
   	SET v_nombre_generado = fn_genera_nombre_simple(v_genero);
    
    IF v_bandera_nombrecompuesto THEN 
		WHILE v_nombre2_generado IS NULL OR v_nombre2_generado = v_nombre_generado DO
             SET v_nombre2_generado = fn_genera_nombre_simple(v_genero);
        END WHILE;
        SET v_nombre_generado = CONCAT(v_nombre_generado," ", v_nombre2_generado);
	END IF;
    
    RETURN v_nombre_generado;
RETURN v_nombre_generado;
END
&&
DELIMITER ;



-- 1.4 Función para generar primer apellidos
DELIMITER &&
DROP function IF EXISTS `fn_genera_apellido`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_apellido`() RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_apellido_generado VARCHAR(50) DEFAULT NULL;
    SET v_apellido_generado = ELT(fn_numero_aleatorio_rangos(1,100), 
			"Álvarez","Briones","Cruz","Díaz","Estrada", "Fuentes","Gayosso","Hernández","Ibarra","Jiménez",
			"Kuno","López","Martínez","Ortíz","Paredes", "Quiróz","Ramírez","Sampayo","Téllez","Urbina",
			"Vargas","Wurtz","Ximénez","Yañez","Zapata", "García","González","Pérez","Rodríguez","Sánchez",
            "Romero","Gómez","Flores","Morales","Vázquez", "Reyes","Torres","Gutiérrez","Ruíz","Mendoza",
            "Aguilar","Moreno","Castillo","Méndez","Chávez", "Rivera","Juárez","Ramos","Domínguez","Herrera",
            "Medina","Castro","Vargas","Guzmán","Velazquez", "Muñoz","Rojas","de la Cruz","Contreras","Salazar",
            "Luna","Ortega","Santiago","Guerrero","Bautista", "Cortés","Soto","Alvarado","Espinoza","Lara",
            "Ávila","Ríos","Cervantes","Silva","Delgado", "Vega","Márquez","Sandoval","Carrillo","León",
            "Mejía","Solís","Rosas","Valdéz","Nuñez", "Campos","Santos","Camacho","Navarro","Peña",
            "Maldonado","Rosales","Acosta","Miranda","Trejo", "Valencia","Nava","Pacheco","Huerta","Padilla");
            
    
RETURN v_apellido_generado;
END
&&
DELIMITER ;



-- 1.5 Función para generar nombres
DELIMITER &&
DROP function IF EXISTS `fn_genera_nombre_simple`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_nombre_simple`(v_genero CHAR(1)) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_nombre_generado VARCHAR(60) DEFAULT NULL;
    IF v_genero = 'M' THEN 
		SET v_nombre_generado = ELT( fn_numero_aleatorio_rangos(1,255), "Aarón", "Abel", "Abelardo", "Abraham", "Adalberto",
		"Adán", "Adolfo","Adrián","Agustín","Alán", "Alberto","Aldo","Alejandro","Alfonso","Alfredo",
        "Alonso","Álvaro","Amado","Andrés","Ángel","Anselmo","Antonio","Apolinar","Ariel","Aristeo",
        "Armando", "Arnoldo","Arnulfo","Artemio","Arturo","Augusto", "Aureliano", "Aurelio", "Baltazar","Benito",
        "Benjamin","Bernabe","Bernardino","Bernardo","Candelario","Candido","Carlos", "Carmelo", "Cecilio", "César",
        "Christian","Cirilo","Claudio","Clemente","Concepción","Constantino","Cristian","Cristobal", "Cruz","Cuauhtémoc",
        "Dagoberto", "Damián","Daniel","Dario","David","Delfino","Demetrio","Diego","Domingo","Edgar",
        "Edgardo","Edmundo","Eduardo","Edwin","Efrain","Efrén","Eleazar","Elías","Eligio","Eliseo",
        "Eloy","Emiliano","Emilio","Emmanuel","Enrique","Erasmo","Eric","Erick","Erik","Ernesto",
        "Esteban","Eugenio","Eusebio","Evaristo","Everardo","Ezequiel","Fabián","Faustino","Fausto","Federico",
        "Feliciano","Felipe","Froylan", "Félix","Fermín","Fernando","Fidel","Filiberto","Florencio","Florentino",
        "Fortino","Francisco","Fredy","Gabino","Gabriel","Gamaliel","Genaro","Gerardo","Germán","Gilberto",
        "Gildardo","Gonzálo","Gregorio","Guadalupe","Guillermo","Gustavo","Héctor","Heriberto","Hernán","Hilario",
        "Hipólito","Homero","Horacio","Hugo","Humberto","Ignacio","Isaac","Irvin", "Isaías","Isidro",
        "Ismael","Israel","Ivan","Jacinto","Jacobo","Jaime","Javier","Jeronimo","Jesús","Joaquín",
        "Joel","Jonathan","Jorge","José","Jose María","Josué", "Juan","Juan de Dios","Julián","Julio",
        "Justino","Juventino","Lázaro","Lenin","Leobardo","Leonardo","Leonel","Leopoldo","Lorenzo","Luciano",
        "Lucio","Luis","Manuel","Matías","Marcelino","Marcelo","Marco","Marcos","Margarito","Tobías",
        "Mariano","Mario","Martín","Mateo","Mauricio","Mauro","Maximíno","Máximo","Miguel","Milton",
        "Misael","Modesto","Moisés","Nestor","Nicolás","Noé","Noel","Norberto","Octavio","Omar",
        "Orlando","Oscar","Osvaldo","Oswaldo","Pablo","Pascual","Patricio","Pedro","Porfirio","Rafael",
        "Ramiro","Ramón","Raúl","Raymundo","Refugio","René","Rey","Reyes","Reynaldo","Ricardo",
        "Rigoberto","Roberto","Rodolfo","Rodrigo","Rogelio","Roger","Rolando","Román","Rosalio","Rosario",
        "Rosendo","Rubén","Sabino","Salomón","Salvador","Samuel","Santiago","Santos","Saúl","Sebastián", 
        "Sergio","Silvestre","Simón","Teodoro","Tomás","Trinidad", "Ubaldo", "Ulises", "Uriel", "Valentin",
        "Vicente","Víctor","Virgilio","Vladimir","Wilbert","Zahid","Zacarías", "Yahir", "Yael", "Yoshua");
    ELSEIF v_genero= 'F' THEN 
        SET v_nombre_generado = ELT( fn_numero_aleatorio_rangos(1,255), "Abigail", "Adela", "Adriana", "Agustina", "Aida", 
        "Aide","Alba","Alejandra","Alejandrina","Alícia","Alma","Amalia","Amelia","América","Ampáro", 
        "Ana","Anabel","Andrea", "Anel","Angela", "Ángeles", "Angélica", "Angelina", "Antonia", "Antonieta", 
        "Araceli","Aracely", "Areli", "Arely", "Asunción","Aurelia", "Aurora","Azucena", "Beatríz", "Berenice", 
        "Bertha","Blanca","Brenda","Candelaria","Carmen","Carolina","Catalina", "Cecilia","Celia", "Clara",
        "Claudia","Concepción","Consuelo","Cristina","Cruz","Cynthia","Dalia","Dalila","Daniela","Delia",
        "Denisse","Diana","Dolores","Dora","Dulce","Edith","Edna","Elba","Elda","Elena",
        "Elia","Elisa","Elizabeth","Eloisa","Elsa","Elva","Elvia","Elvira","Emilia","Emma",
        "Enedina","Enriqueta","Erendira","Erika","Ernestina","Esmeralda","Esperanza","Estela","Esthela","Esther",
        "Eugenia","Eva","Evangelina","Evelia","Evelyn","Fabiola","Fatima","Fernanda","Flor","Francisca",
        "Gabriela","Genoveva","Georgina","Gisela","Gladys","Gloria","Graciela","Griselda","Guadalupe","Guillermina",
        "Herlinda","Hermelinda","Hilda","Hortencia","Idalia","Iliana","Iliria","Imelda","Inés","Irene",
        "Iris","Irma","Isabel","Isela","Itzel","Ivana","Ivette", "Ivonne","Janet","Janeth",
        "Jaqueline","Jazmín","Jessica","María José","Josefina", "Juana","Judith","Julia","Julieta","Karen",
        "Karina","Karla","Laura","Leonor","Leticia","Lidia","Lilia","Liliana","Lizbeth","Lizeth",
        "Lorena","Lourdes","Lucero","Lucia","Lucila","Lucina","Luisa","Luz","Magdalena","Manuela",
        "Marcela","Margarita","María","Mariana","Maribel","Maricela","Mariela","Marina","Marisela","Marisol",
        "Maritza","Marlene","Marta","Martha","Martina","Matilde","Mayra","Mercedes","Micaela","Minerva",
        "Mireya","Miriam","Mirna","Mónica","Monserrat","Nadia","Nallely","Nancy","Natalia","Natividad",
        "Nayeli","Nelly","Nidia","Noemí","Nohemi","Nora","Norma","Ofelia","Olga","Olivia",
        "Oralia","Paola","Patricia","Paula","Paulina","Perla","Petra","Pilar","Ramona","Raquel", 
        "Rebeca","Refugio","Reyna","Rita","Rocío","Rosa","Rosalba","Rosalia","Rosalinda","Rosario", 
        "Rosaura","Rubí","Ruth","Sandra","Santa","Sara","Selene","Silvia","Socorro","Sofía",
        "Soledad","Sonia","Susana","Tania","Tanya","Teresa","Teresita","Tomasa","Trinidad","Valeria",
        "Vanessa","Veronica", "Victoria", "Violeta", "Virginia","Viridiana", "Wendy","Xcaret","Xochitl","Xandra", 
        "Yadira", "Yanet", "Yazmín","Yesenia", "Yolanda","Zara","Zaira", "Zoila","Tamara","Ariel");
	END IF;
RETURN v_nombre_generado;
END
&&
DELIMITER ;



-- 1.6 Funcion para Cañcular hora especifica
DELIMITER &&
DROP function IF EXISTS `fn_fechahora_aleatoria_rangos`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_fechahora_aleatoria_rangos`( fechaInicio DATE, fechaFin DATE, horaInicio TIME, horaFin TIME) RETURNS datetime
    DETERMINISTIC
BEGIN
    DECLARE fechaAleatoria DATE;
    DECLARE horaEntrada TIME;
    DECLARE horaSalida TIME;
    DECLARE horaRegistro TIME;
    DECLARE fechaHoraGenerada DATETIME;
    
   -- Generar fecha aleatoria dentro del rango dado
    SET fechaAleatoria = DATE_ADD(fechaInicio, INTERVAL FLOOR(RAND() * (DATEDIFF(fechaFin, fechaInicio) + 1)) DAY);

    -- Generar hora de registro aleatoria dentro del rango de hora de entrada y salida
    SET horaRegistro = ADDTIME(horaInicio, SEC_TO_TIME(FLOOR(RAND() * TIME_TO_SEC(TIMEDIFF(horaFin, horaInicio)))));
    
    SET fechaHoraGenerada = CONCAT(fechaAleatoria," ",horaRegistro);
  
RETURN fechaHoraGenerada;
END
&&
DELIMITER ;



-- 1.7 Funcion para calcular la fecha especifica
DELIMITER &&
DROP function IF EXISTS `fn_calcula_edad_fecha_especifica`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_calcula_edad_fecha_especifica`(v_fecha_nacimiento DATE, v_fechareferencia DATE) RETURNS int
    DETERMINISTIC
BEGIN
RETURN TIMESTAMPDIFF(YEAR, v_fecha_nacimiento,v_fechareferencia);
END
&&
DELIMITER ;


-- 1.8 funcion para generar CURP
DELIMITER &&
DROP function IF EXISTS `fn_genera_curp`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_curp`(v_nombre VARCHAR(60), v_primer_apellido VARCHAR(45) ,v_segundo_apellido VARCHAR(45), 
															v_fecha_nacimiento DATE, v_genero CHAR(1), v_entidad_federativa VARCHAR(45)) RETURNS char(18) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
     DECLARE v_curp CHAR(18) DEFAULT NULL;
     DECLARE v_sexo CHAR(1) DEFAULT NULL;
     DECLARE v_efn  CHAR(2) DEFAULT NULL;  /*Entidad Federativa de Nacimiento*/
     DECLARE v_dv   CHAR(2) DEFAULT NULL;  /* Dígito Verificador */
     IF v_genero = "M" THEN 
        SET v_sexo = "H";
	 ELSEIF v_genero = "F" THEN 
        SET v_sexo = "M";
	 END IF;
     SET v_nombre = fn_elimina_acentos(v_nombre);
     SET v_primer_apellido = fn_elimina_acentos(v_primer_apellido);
     SET v_segundo_apellido = fn_elimina_acentos(v_segundo_apellido);
     IF v_entidad_federativa = "Aguascalientes" THEN
	    SET v_efn = "AS";
	 ELSEIF v_entidad_federativa = "Baja California" THEN
		SET v_efn = "BC";
	 ELSEIF v_entidad_federativa = "Baja California Sur" THEN
		SET v_efn = "BS";
     ELSEIF v_entidad_federativa = "Campeche" THEN
		SET v_efn = "CC";
	 ELSEIF v_entidad_federativa = "Coahuila" THEN
		SET v_efn = "CL";
	 ELSEIF v_entidad_federativa = "Colima" THEN
		SET v_efn = "CM";
	 ELSEIF v_entidad_federativa = "Chiapas" THEN
		SET v_efn = "CS";
     ELSEIF v_entidad_federativa = "Chihuahua" THEN
		SET v_efn = "CH";
	 ELSEIF v_entidad_federativa = "Distrito Federal" THEN
		SET v_efn = "DF";
     ELSEIF v_entidad_federativa = "Durango" THEN
		SET v_efn = "DG";
	 ELSEIF v_entidad_federativa = "Guanajuato" THEN
		SET v_efn = "GT";
	 ELSEIF v_entidad_federativa = "Guerrero" THEN
		SET v_efn = "GR";
     ELSEIF v_entidad_federativa = "Hidalgo" THEN
		SET v_efn = "HG";
	 ELSEIF v_entidad_federativa = "Jalisco" THEN
		SET v_efn = "JC";
     ELSEIF v_entidad_federativa = "México" THEN
		SET v_efn = "MC";
	 ELSEIF v_entidad_federativa = "Michoacán" THEN
		SET v_efn = "MN";
	 ELSEIF v_entidad_federativa = "Morelos" THEN
		SET v_efn = "MS";
     ELSEIF v_entidad_federativa = "Nayarit" THEN
		SET v_efn = "NT";
	 ELSEIF v_entidad_federativa = "Nuevo León" THEN
		SET v_efn = "NL";
     ELSEIF v_entidad_federativa = "Oaxaca" THEN
		SET v_efn = "OC";
     ELSEIF v_entidad_federativa = "Puebla" THEN
		SET v_efn = "PL";
	 ELSEIF v_entidad_federativa = "Querétaro" THEN
		SET v_efn = "QT";
	 ELSEIF v_entidad_federativa = "Quintana Roo" THEN
		SET v_efn = "QR";
     ELSEIF v_entidad_federativa = "San Luis Potosí" THEN
		SET v_efn = "SP";
	 ELSEIF v_entidad_federativa = "Sinaloa" THEN
		SET v_efn = "SL";
     ELSEIF v_entidad_federativa = "Sonora" THEN
		SET v_efn = "SR";
     ELSEIF v_entidad_federativa = "Tabasco" THEN
		SET v_efn = "TC";
	 ELSEIF v_entidad_federativa = "Tamaulipas" THEN
		SET v_efn = "TS";
     ELSEIF v_entidad_federativa = "Tlaxcala" THEN
		SET v_efn = "TL";
	 ELSEIF v_entidad_federativa = "Veracruz" THEN
		SET v_efn = "VZ";
     ELSEIF v_entidad_federativa = "Yucatán" THEN
		SET v_efn = "YN";   
     ELSEIF v_entidad_federativa = "Zacatecas" THEN
		SET v_efn = "ZS";
     ELSEIF v_entidad_federativa = "Nacido en el Extranjero" THEN
		SET v_efn = "NE"; 
	 END IF;
     SET v_curp = CONCAT(UPPER(SUBSTR(v_primer_apellido,1,1)), fn_primer_vocalinterna(v_primer_apellido),
						 UPPER(SUBSTR(v_segundo_apellido,1,1)), UPPER(SUBSTR(v_nombre,1,1)), SUBSTR(year(v_fecha_nacimiento),3,2), 
                         LPAD(MONTH(v_fecha_nacimiento),2,'0'), LPAD(DAY(v_fecha_nacimiento),2,'0'), v_sexo, v_efn, 
                         fn_primer_consonanteinterna(v_primer_apellido), fn_primer_consonanteinterna(v_segundo_apellido), fn_primer_consonanteinterna(v_nombre));
     SET v_dv =  LPAD((SELECT COUNT(*) FROM tbb_personas WHERE curp like CONCAT(v_curp, "%")),2,'0');
     SET v_curp = CONCAT(v_curp, v_dv);
RETURN v_curp;
END
&&
DELIMITER ;



-- 1.9 Funcioón para eliminar acentos
DELIMITER &&
DROP function IF EXISTS `fn_elimina_acentos`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_elimina_acentos`(textvalue varchar(100)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
begin
set @textvalue = textvalue;
set @withaccents = 'ŠšŽžÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝŸÞàáâãäåæçèéêëìíîïñòóôõöøùúûüýÿþƒ';
set @withoutaccents = 'SsZzAAAAAAACEEEEIIIINOOOOOOUUUUYYBaaaaaaaceeeeiiiinoooooouuuuyybf';
set @count = length(@withaccents);
while @count > 0 do
    set @textvalue = replace(@textvalue, substring(@withaccents, @count, 1), substring(@withoutaccents, @count, 1));
    set @count = @count - 1;
end while;
set @special = '!@#$%¨&*()_+=§¹²³£¢¬"`´{[^~}]<,>.:;?/°ºª+*|\\''';
set @count = length(@special);
while @count > 0 do
    set @textvalue = replace(@textvalue, substring(@special, @count, 1), '');
    set @count = @count - 1;
end while;
return @textvalue;
end

&&
DELIMITER ;



-- 2.0 Funcion para generar primera vocal interna
DELIMITER &&
DROP function IF EXISTS `fn_primer_vocalinterna`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_primer_vocalinterna`(v_palabra VARCHAR(100)) RETURNS char(1) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
      DECLARE v_vocal CHAR(1) DEFAULT NULL; 
      DECLARE v_bandera BOOLEAN DEFAULT FALSE;
      DECLARE v_pos INT DEFAULT 1; 
      SET v_palabra = fn_elimina_acentos(v_palabra);
      WHILE v_bandera = FALSE DO
            SET v_vocal = UPPER(substr(v_palabra, v_pos,1));
            IF v_vocal IN ('A','E','I','O','U') AND v_pos > 1 THEN
            SET v_bandera = TRUE;
            ELSEIF v_pos = CHAR_LENGTH(v_palabra) THEN
            SET v_vocal = NULL;
            SET v_bandera = TRUE;
            ELSE
            SET v_pos = v_pos + 1;
            END IF;
      END WHILE;
RETURN v_vocal;
END
&&
DELIMITER ;


-- 2.1 Funcion para primera consonante
DELIMITER &&
DROP function IF EXISTS `fn_primer_consonanteinterna`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_primer_consonanteinterna`(v_palabra VARCHAR(100)) RETURNS char(1) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
      DECLARE v_consonante CHAR(1) DEFAULT NULL; 
      DECLARE v_bandera BOOLEAN DEFAULT FALSE;
      DECLARE v_pos INT DEFAULT 1; 
      WHILE v_bandera = FALSE DO
            SET v_consonante = UPPER(substr(v_palabra, v_pos,1));
            IF v_consonante IN ('B','C','D','F','G','H','J','K','L','M','N','P','Q','R','S','T','V','W','X','Y','Z') AND v_pos > 1 THEN
            SET v_bandera = TRUE;
            ELSEIF v_pos = CHAR_LENGTH(v_palabra) THEN
            SET v_consonante = NULL;
            SET v_bandera = TRUE;
            ELSE
            SET v_pos = v_pos + 1;
            END IF;
      END WHILE;
RETURN v_consonante;
END
&&
DELIMITER ;



-- 2.2 Funcion para generar cedula profesional
DELIMITER &&
DROP function IF EXISTS `fn_genera_cedula_profesional`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_cedula_profesional`() RETURNS int
    DETERMINISTIC
BEGIN
       DECLARE v_cedula_generada INT(8) DEFAULT 0;
       DECLARE v_bandera_cedula_valida BOOLEAN DEFAULT FALSE;
       
       WHILE NOT v_bandera_cedula_valida DO 
			SET v_cedula_generada = fn_numero_aleatorio_rangos(1,99999999);
            IF (SELECT COUNT(*) FROM tbb_personal_medico WHERE cedula_profesional = v_cedula_generada) = 0 THEN
				SET v_bandera_cedula_valida = TRUE;
            END IF;
       END WHILE;
RETURN v_cedula_generada;
END
&&
DELIMITER ;


-- Función para generar sueldos
DELIMITER &&
DROP FUNCTION IF EXISTS `fn_genera_sueldos`;
CREATE DEFINER=`jonathan.ibarra`@`%` FUNCTION `fn_genera_sueldos`(v_tipo_empleado VARCHAR(50)) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE v_sueldo INT;

    CASE v_tipo_empleado
        WHEN 'Médico' THEN
            SET v_sueldo = FLOOR(RAND() * 50000) + 60000; /* Sueldo entre 60000 y 109999 */
        WHEN 'Enfermero' THEN
            SET v_sueldo = FLOOR(RAND() * 20000) + 30000; /* Sueldo entre 30000 y 49999 */
        WHEN 'Administrativo' THEN
            SET v_sueldo = FLOOR(RAND() * 20000) + 35000; /* Sueldo entre 35000 y 54999 */
        WHEN 'Directivo' THEN
            SET v_sueldo = FLOOR(RAND() * 50000) + 80000; /* Sueldo entre 80000 y 129999 */
        WHEN 'Apoyo' THEN
            SET v_sueldo = FLOOR(RAND() * 10000) + 20000; /* Sueldo entre 20000 y 29999 */
        WHEN 'Residente' THEN
            SET v_sueldo = FLOOR(RAND() * 15000) + 25000; /* Sueldo entre 25000 y 39999 */
        WHEN 'Interno' THEN
            SET v_sueldo = FLOOR(RAND() * 10000) + 15000; /* Sueldo entre 15000 y 24999 */
        ELSE
            SET v_sueldo = FLOOR(RAND() * 15000) + 20000; /* Sueldo por defecto entre 20000 y 34999 */
    END CASE;

    RETURN v_sueldo;
END 
&&
DELIMITER ;
