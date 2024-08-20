-- SCRIPT DE CREACIÓN DE LAS FUNCIONES NECESARIAS PARA LA POBLACION DINAMICA DE LA TABLA ASIGNADA

-- Elaborado por: Elí Aidan Melo Calva
-- Grado y Grupo:  9° A 
-- Programa Educativo: Ingeniería de Desarrollo y Gestión de Software 
-- Fecha elaboración:  24 de Julio de 2024

-- Funciones de la Tabla: Nacimientos

-- 1.- Función: "fn_bandera_porcentaje"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_bandera_porcentaje`(v_porcentaje INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE v_valor INT DEFAULT (fn_numero_aleatorio_rangos(0,100));
    DECLARE v_bandera BOOLEAN DEFAULT false;

    IF v_valor <= v_porcentaje THEN 
        SET v_bandera = true;
    END IF;
    RETURN v_bandera;
END

-- 2.- Función: "fn_Calificacion_APGAR"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_Calificacion_APGAR`() RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE aparicion INT;
    DECLARE pulso INT;
    DECLARE gesticulacion INT;
    DECLARE actividad INT;
    DECLARE respiracion INT;
    DECLARE total INT;

    -- Generar puntuaciones aleatorias para cada criterio
    SET aparicion = fn_numero_aleatorio_rangos(0, 2);
    SET pulso = fn_numero_aleatorio_rangos(0, 2);
    SET gesticulacion = fn_numero_aleatorio_rangos(0, 2);
    SET actividad = fn_numero_aleatorio_rangos(0, 2);
    SET respiracion = fn_numero_aleatorio_rangos(0, 2);
    
    -- Calcular la calificación total
    SET total = aparicion + pulso + gesticulacion + actividad + respiracion;
    
    RETURN total;
END

-- 3.- Función: "fn_genera_apellido"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_genera_apellido`() RETURNS varchar(100) CHARSET utf8mb4
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

-- 4.- Función: "fn_genera_nombre"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_genera_nombre`(v_genero CHAR(1)) RETURNS varchar(100) CHARSET utf8mb4
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

-- 5.- Función: "fn_genera_nombre_simple"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_genera_nombre_simple`(v_genero CHAR(1)) RETURNS varchar(50) CHARSET utf8mb4
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

-- 6.- Función: "fn_numero_aleatorio_rangos"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_numero_aleatorio_rangos`(minimo INT, maximo INT) RETURNS int
    DETERMINISTIC
BEGIN
  RETURN FLOOR(RAND() * (maximo - minimo + 1)) + minimo;
END

-- 7.- Función: "fn_Observaciones"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_Observaciones`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE observacion_index INT;
    DECLARE observacion VARCHAR(255);

    -- Generar un índice aleatorio entre 1 y 3
    SET observacion_index = fn_numero_aleatorio_rangos(1, 3);

    -- Asignar observación basada en el índice
    CASE observacion_index
        WHEN 1 THEN
            SET observacion = 'Bien';
        WHEN 2 THEN
            SET observacion = 'Regular';
        WHEN 3 THEN
            SET observacion = 'Mal';
    END CASE;

    RETURN observacion;
END

-- 8.- Función: "fn_Signos_vitales"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_Signos_vitales`() RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE fc INT;  -- Frecuencia cardíaca
    DECLARE pa_sys INT;  -- Presión arterial sistólica
    DECLARE pa_dia INT;  -- Presión arterial diastólica
    DECLARE temp DECIMAL(4,1);  -- Temperatura corporal
    
    -- Generar valores aleatorios
    SET fc = fn_numero_aleatorio_rangos(60, 100);  -- Frecuencia cardíaca en reposo (60-100 bpm)
    SET pa_sys = fn_numero_aleatorio_rangos(90, 140);  -- Presión sistólica (90-140 mmHg)
    SET pa_dia = fn_numero_aleatorio_rangos(60, 90);  -- Presión diastólica (60-90 mmHg)
    SET temp = ROUND(36.0 + (RAND() * 2.0), 1);  -- Temperatura corporal (36.0-38.0°C)
    
    RETURN (SELECT fc AS Frecuencia_Cardiaca, pa_sys AS Presion_Sistolica, pa_dia AS Presion_Diastolica, temp AS Temperatura);
END

-- 9.- Función: "fn_obtener_genero"
CREATE DEFINER=`eli.aidan`@`%` FUNCTION `fn_obtener_genero`() RETURNS char(1) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE numero INT;
    
    SET numero = fn_numero_aleatorio_rangos(0, 1);
    
    IF numero = 0 THEN
        RETURN 'M';
    ELSE
        RETURN 'F';
    END IF;
END