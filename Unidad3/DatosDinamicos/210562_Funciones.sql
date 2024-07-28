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
-- 3.- Función
DELIMITER ;;
DELIMITER ;
-- 4.- Función
DELIMITER ;;
DELIMITER ;
-- 5.- Función
DELIMITER ;;
DELIMITER ;