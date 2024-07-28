-- SCRIP DE CREACIÓN DE LAS FUNCIONE NECESARIAS PARA LA POBLACION DINAMICA DE LA  TABLA ASIGNADA

-- Elaborado por: Jose Angel Gomez Ortiz
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 28 de Julio del 2024

-- Funciones de la Tabla: tbb_personas

-- 1.- Función:"fn_bandera_porcentaje":
/*Genera un valor aleatorio entre 0 y 100 usando fn_numero_aleatorio_rangos(0, 100).
    Compara este valor aleatorio con el porcentaje proporcionado (v_porcentaje). 
    Si el valor aleatorio es menor o igual al porcentaje, establece la bandera v_bandera como true;
    de lo contrario, la bandera se mantiene como false.*/

    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_bandera_porcentaje`(v_porcentaje INT) RETURNS int
        DETERMINISTIC
    BEGIN
    DECLARE v_valor INT DEFAULT (fn_numero_aleatorio_rangos(0,100));
    DECLARE v_bandera BOOLEAN DEFAULT false;

    IF v_valor <= v_porcentaje THEN 
        SET v_bandera = true;
    END IF;
    RETURN v_bandera;
    END ;;
    DELIMITER ;

-- 2.- Función: "fn_genera_nombre_simple":
/*Genera un nombre aleatorio basado en el género proporcionado. Aquí están los pasos:
    Dependiendo del género (v_genero):
    -Si es 'M' (masculino), selecciona un nombre masculino aleatorio de una lista predefinida.
    -Si es 'F' (femenino), selecciona un nombre femenino aleatorio de una lista predefinida.
    El nombre seleccionado se devuelve como resultado de la función.
    Esta función utiliza fn_numero_aleatorio_rangos para elegir aleatoriamente un nombre de las listas correspondientes a cada género.*/

    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_genera_nombre_simple`(v_genero CHAR(1)) RETURNS varchar(50) CHARSET utf8mb4
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
    END ;;
    DELIMITER ;

-- 3.- Función: "fn_genera_nombre":
/*La función `fn_genera_nombre` genera un nombre completo aleatorio que puede ser simple o compuesto. Aquí está cómo funciona:
    1. Genera un nombre básico:
    - Llama a `fn_genera_nombre_simple` para obtener un nombre según el género (`v_genero`).
    2. Decide si el nombre debe ser compuesto:
    - Usa `fn_bandera_porcentaje(35)` para determinar si debe generar un nombre compuesto (35% de probabilidad). La función `fn_bandera_porcentaje` devuelve un valor booleano basado en el porcentaje proporcionado.
    3. Genera un segundo nombre si es necesario:
    - Si se decide que el nombre debe ser compuesto, genera un segundo nombre distinto (para evitar duplicados) llamando nuevamente a `fn_genera_nombre_simple`.
    4. Concatena los nombres:
    - Si se genera un segundo nombre, lo concatena al primer nombre con un espacio en medio.
    5. Devuelve el nombre generado:
    - Retorna el nombre completo (ya sea simple o compuesto).
    */
 
    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_genera_nombre`(v_genero CHAR(1)) RETURNS varchar(100) CHARSET utf8mb4
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
    END ;;
    DELIMITER ;

-- 4.- Función: "fn_genera_fecha_nacimiento":
/*La función `fn_genera_fecha_nacimiento` genera una fecha aleatoria entre dos fechas específicas (`fecha_inicio` y `fecha_fin`). Aquí está su funcionamiento:
    1. Calcula los días desde una fecha base (`'1900-01-01'`) hasta las fechas de inicio y fin:
    - `min_dias` es el número de días entre `'1900-01-01'` y `fecha_inicio`.
    - `max_dias` es el número de días entre `'1900-01-01'` y `fecha_fin`.
    2. Genera un número aleatorio de días dentro del rango:
    - `dias_aleatorios` se establece usando la función `fn_numero_aleatorio_rangos(min_dias, max_dias)`, que genera un número aleatorio entre `min_dias` y `max_dias`.
    3. Calcula la fecha aleatoria:
    - `fecha_aleatoria` se obtiene añadiendo `dias_aleatorios` días a la fecha base (`'1900-01-01'`).
    4. Devuelve la fecha aleatoria:
    - La fecha generada se retorna como resultado de la función.*/

    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_genera_fecha_nacimiento`(fecha_inicio DATE, fecha_fin DATE) RETURNS date
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
    END ;;
    DELIMITER ;

-- 5.- Función: "fn_genera_curp":
/*Genera un CURP (Clave Única de Registro de Población) 
    para una persona con base en su nombre, apellidos, fecha de nacimiento, género y entidad federativa.
    Utiliza funciones auxiliares para obtener componentes como vocales internas y consonantes,
    y genera un dígito verificador para asegurar la unicidad del CURP.*/

    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_genera_curp`(v_nombre VARCHAR(60), v_primer_apellido VARCHAR(45) ,v_segundo_apellido VARCHAR(45), 
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
    END ;;
    DELIMITER ;

-- 6.- Función: "fn_genera_apellido":
/*Genera aleatoriamente un apellido a partir de una lista predefinida
    de apellidos. Utiliza una función auxiliar para seleccionar un apellido de la lista con base en
    un número aleatorio.*/

    DELIMITER ;;
    CREATE DEFINER=`jose.gomez`@`%` FUNCTION `fn_genera_apellido`() RETURNS varchar(100) CHARSET utf8mb4
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
    END ;;
    DELIMITER ;

-- 7.- Función
/**/
DELIMITER ;;
DELIMITER ;