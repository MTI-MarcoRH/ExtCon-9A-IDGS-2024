-- SCRIPT DE CREACIÓN DE LAS FUNCIONE NECESARIAS PARA LA POBLACION DINAMICA DE LA TABLA ASIGNADA

-- Elaborado por: Arturo Aguilar Santos
-- Grado y Grupo: 9° A
-- Programa Educativo: Ingenieria en Desarrollo y Gestión de Software
-- Fecha de elaboración: 17 de Agosto del 2024

-- Funciones de la Tabla: Expedientes Medicos

-- 1.- Función: "fn_genera_Antecendentes_Medicos_Patologicos"
/*Genera un dato relevante sobre los antecedentes medicos patologicos que pueda tener el paciente
de forma aleatoria, esta funcion fue alimentada por 50 diferentes tipos de antecedentes medicos 
patologicos.*/

DELIMITER $$
&&
CREATE DEFINER=`arturo.aguilar`@`%` FUNCTION `fn_genera_Antecendentes_Medicos_Patologicos`() RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE antecedentesMP_generada VARCHAR(200) DEFAULT NULL;
    SET antecedentesMP_generada  = ELT(FLOOR(1 + RAND() * 50), 
    "Hipertensión arterial","Diabetes mellitus tipo 1",
    "Diabetes mellitus tipo 2","Infarto agudo de miocardio",
    "Insuficiencia cardíaca","Arritmias cardíacas",
    "Enfermedad coronaria","Accidente cerebrovascular (ACV)",
    "Epilepsia","Asma",
    "Enfermedad pulmonar obstructiva crónica (EPOC)","Tuberculosis pulmonar",
    "Cáncer (especificar tipo y localización)","Hepatitis viral (A, B, C)",
    "Cirrosis hepática","Enfermedad renal crónica",
    "Insuficiencia renal","Litiasis renal (cálculos en los riñones)",
    "Artritis reumatoide","Osteoartritis",
    "Lupus eritematoso sistémico","Psoriasis",
    "Enfermedad celíaca","Enfermedad inflamatoria intestinal (como Crohn o colitis ulcerosa)",
    "Hipotiroidismo","Hipertiroidismo",
    "Síndrome de apnea del sueño","Alergias graves (anafilaxia)",
    "Síndrome de Marfan","Fibromialgia",
    "Migrañas o cefaleas intensas","Esclerosis múltiple",
    "Parkinson","Enfermedad de Huntington",
    "Trastornos de ansiedad","Depresión mayor",
    "Esquizofrenia","Trastorno bipolar",
    "Tinnitus (acúfenos)","Hepatitis autoinmune",
    "Hiperlipidemia (colesterol alto)","Anemia (tipo específico)",
    "Deficiencia de vitamina B12","Enfermedad de Gaucher",
    "Hemofilia","Síndrome de Down",
    "Síndrome de Turner","Síndrome de Klinefelter",
    "Enfermedad de Wilson","Trastornos de la coagulación"
	"Radiología");
    RETURN antecedentesMP_generada ;
END
DELIMITER ;

-- 2.- Función: "fn_genera_Antecendentes_Medicos_NoPatologicos"
/*Genera un dato relevante sobre los antecedentes medicos no patologicos que pueda tener el paciente
de forma aleatoria, esta funcion fue alimentada por 50 diferentes tipos de antecedentes medicos 
no patologicos.*/

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` FUNCTION `fn_genera_Antecendentes_Medicos_NoPatologicos`() RETURNS varchar(300) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE antecedentesNoMP_generada VARCHAR(300) DEFAULT NULL;
    SET antecedentesNoMP_generada  = ELT(FLOOR(1 + RAND() * 50), 
    "No fuma y nunca ha tenido problemas relacionados con el tabaco","Consume alcohol ocasionalmente de manera social, sin historial de abuso",
    "No ha utilizado drogas recreativas en su vida","Mantiene un estilo de vida saludable, sin adicciones",
    "Gozó de buena salud durante la infancia sin enfermedades crónicas","Nunca ha requerido cirugías importantes",
    "No presenta alergias conocidas","No tiene historial familiar de enfermedades genéticas",
    "Sistema cardiovascular en buen estado, sin antecedentes de problemas","Pulmones sanos, sin problemas respiratorios en el pasado",
    "No hay historial de enfermedades hepáticas","Riñones funcionando correctamente, sin antecedentes de problemas",
    "Sistema digestivo saludable, sin problemas conocidos","Sin antecedentes de enfermedades neurológicas",
    "No presenta antecedentes psiquiátricos ni problemas de salud mental","Sistema inmunológico fuerte, sin enfermedades autoinmunes",
    "Hormonas en equilibrio, sin problemas endocrinos previos","Metabolismo normal, sin problemas metabólicos conocidos",
    "Sangre sana, sin enfermedades hematológicas","Sistema musculoesquelético en buen estado, sin problemas previos",
    "Sin historial de enfermedades infecciosas importantes","Sin antecedentes de cáncer en la familia",
    "Piel saludable, sin enfermedades dermatológicas conocidas","Visión en buen estado, sin enfermedades oculares",
    "Audición normal, sin problemas auditivos previos","Salud dental óptima, sin problemas dentales significativos",
    "Embarazos anteriores sin complicaciones (si aplica)","Estilo de vida activo y saludable, sin enfermedades relacionadas con el estilo de vida",
    "Sistema inmunológico robusto, sin problemas conocidos","Sin problemas endocrinos ni enfermedades relacionadas",
    "Metabolismo equilibrado, sin antecedentes de enfermedades metabólicas","Corazón fuerte, sin problemas cardiovasculares previos",
    "Duerme bien, sin trastornos del sueño conocidos","Piel sana, sin problemas dermatológicos importantes",
    "Salud ginecológica en orden (si aplica), sin problemas conocidos","Sin problemas urológicos, función renal normal",
    "Salud mental estable, sin enfermedades psiquiátricas","Función endocrina normal, sin problemas hormonales",
    "Respiración normal, sin enfermedades respiratorias previas","Sistema gastrointestinal sano, sin problemas digestivos",
    "Sistema osteoarticular en buen estado, sin antecedentes de problemas","Sin infecciones graves en el pasado",
    "Sistema nervioso sano, sin problemas neurológicos conocidos","Salud reproductiva normal (si aplica), sin problemas previos",
    "Vasos sanguíneos en buen estado, sin enfermedades vasculares","Desarrollo normal, sin trastornos del desarrollo conocidos",
    "Sistema linfático sano, sin problemas conocidos","Sin problemas de conducta ni trastornos psicológicos",
    "Buena salud general, sin problemas importantes en el pasado");
    RETURN antecedentesNoMP_generada;
END
DELIMITER ;

-- 3.- Función: "fn_genera_Antecendentes_Medicos_Patologicos_HeredoFamiliares"
/*Genera un dato relevante sobre los antecedentes medicos patologicos heredofamiliares que pueda tener 
el paciente de forma aleatoria, esta funcion fue alimentada por 50 diferentes tipos de antecedentes medicos 
patologicos heredofamiliares.*/

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` FUNCTION `fn_genera_Antecendentes_Medicos_Patologicos_HeredoFamiliares`() RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE antecedentesMPH_generada VARCHAR(200) DEFAULT NULL;
    SET antecedentesMPH_generada  = ELT(FLOOR(1 + RAND() * 50), 
	"Diabetes mellitus tipo 1","Diabetes mellitus tipo 2",
    "Hipertensión arterial","Enfermedad coronaria",
    "Infarto agudo de miocardio","Insuficiencia cardíaca",
    "Accidente cerebrovascular (ACV)","Enfermedad pulmonar obstructiva crónica (EPOC)",
    "Asma","Cáncer de mama","Cáncer de ovario",
    "Cáncer de próstata","Cáncer colorrectal",
    "Cáncer de pulmón","Enfermedad de Alzheimer",
    "Enfermedad de Parkinson","Esclerosis múltiple",
    "Lupus eritematoso sistémico","Artritis reumatoide",
    "Enfermedad de Huntington","Fibrosis quística",
    "Anemia de células falciformes","Talassemia",
    "Hemofilia","Síndrome de Marfan",
    "Síndrome de Down","Síndrome de Turner",
    "Síndrome de Klinefelter","Síndrome de Prader-Willi",
    "Síndrome de Angelman","Enfermedad de Wilson",
    "Hipercolesterolemia familiar","Hipertrigliceridemia familiar",
    "Enfermedad de Crohn","Colitis ulcerosa",
    "Enfermedad celíaca","Psoriasis",
    "Esquizofrenia","Trastorno bipolar",
    "Depresión mayor","Trastornos de ansiedad",
    "Epilepsia","Síndrome de fatiga crónica",
    "Trastorno del espectro autista","Tinnitus (acúfenos)",
    "Deficiencia de alfa-1 antitripsina","Enfermedad de Gaucher",
    "Ataxia telangiectasia","Distrofia muscular",
    "Enfermedad de Tay-Sachs","Cistinuria",
    "Enfermedad de Pompe","Acondroplasia");
    RETURN antecedentesMPH_generada ;
END
DELIMITER ;

-- 4.- Función: "fn_genera_Interrogatorio_Sistemas"
/*Genera un dato relevante sobre los signos vitales que pueda tener 
el paciente de forma aleatoria, esta funcion fue alimentada por 50 diferentes signos vitales.*/

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` FUNCTION `fn_genera_Interrogatorio_Sistemas`() RETURNS varchar(300) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE interrogatorioSistemas_generada VARCHAR(300) DEFAULT NULL;
    SET interrogatorioSistemas_generada  = ELT(FLOOR(1 + RAND() * 50), 
		"FC: 72 bpm, PA: 120/80 mmHg, Temp: 36.5°C, FR: 16 rpm, SOxigeno: 98% SpO2","FC: 68 bpm, PA: 115/75 mmHg, Temp: 36.7°C, FR: 18 rpm, SOxigeno: 97% SpO2",
        "FC: 75 bpm, PA: 122/82 mmHg, Temp: 37.0°C, FR: 17 rpm, SOxigeno: 99% SpO2","FC: 80 bpm, PA: 130/85 mmHg, Temp: 36.8°C, FR: 20 rpm, SOxigeno: 96% SpO2",
        "FC: 65 bpm, PA: 110/70 mmHg, Temp: 36.4°C, FR: 15 rpm, SOxigeno: 99% SpO2","FC: 70 bpm, PA: 118/76 mmHg, Temp: 36.6°C, FR: 16 rpm, SOxigeno: 98% SpO2",
        "FC: 77 bpm, PA: 125/80 mmHg, Temp: 36.9°C, FR: 18 rpm, SOxigeno: 97% SpO2","FC: 69 bpm, PA: 115/73 mmHg, Temp: 36.5°C, FR: 17 rpm, SOxigeno: 98% SpO2",
        "FC: 74 bpm, PA: 121/79 mmHg, Temp: 36.7°C, FR: 19 rpm, SOxigeno: 99% SpO2","FC: 78 bpm, PA: 128/84 mmHg, Temp: 37.1°C, FR: 16 rpm, SOxigeno: 96% SpO2",
        "FC: 71 bpm, PA: 117/75 mmHg, Temp: 36.8°C, FR: 18 rpm, SOxigeno: 98% SpO2","FC: 66 bpm, PA: 112/72 mmHg, Temp: 36.3°C, FR: 15 rpm, SOxigeno: 99% SpO2",
        "FC: 73 bpm, PA: 120/80 mmHg, Temp: 36.7°C, FR: 16 rpm, SOxigeno: 98% SpO2","FC: 79 bpm, PA: 129/83 mmHg, Temp: 37.0°C, FR: 19 rpm, SOxigeno: 97% SpO2",
        "FC: 67 bpm, PA: 114/74 mmHg, Temp: 36.4°C, FR: 17 rpm, SOxigeno: 98% SpO2","FC: 81 bpm, PA: 132/86 mmHg, Temp: 36.9°C, FR: 20 rpm, SOxigeno: 96% SpO2",
        "FC: 64 bpm, PA: 111/71 mmHg, Temp: 36.2°C, FR: 15 rpm, SOxigeno: 99% SpO2","FC: 76 bpm, PA: 123/79 mmHg, Temp: 36.8°C, FR: 18 rpm, SOxigeno: 98% SpO2",
        "FC: 68 bpm, PA: 116/73 mmHg, Temp: 36.5°C, FR: 17 rpm, SOxigeno: 98% SpO2","FC: 83 bpm, PA: 135/88 mmHg, Temp: 37.2°C, FR: 21 rpm, SOxigeno: 96% SpO2",
        "FC: 70 bpm, PA: 118/76 mmHg, Temp: 36.6°C, FR: 16 rpm, SOxigeno: 98% SpO2","FC: 74 bpm, PA: 122/81 mmHg, Temp: 36.9°C, FR: 19 rpm, SOxigeno: 97% SpO2",
        "FC: 69 bpm, PA: 115/74 mmHg, Temp: 36.4°C, FR: 17 rpm, SOxigeno: 98% SpO2","FC: 85 bpm, PA: 138/90 mmHg, Temp: 37.3°C, FR: 22 rpm, SOxigeno: 95% SpO2",
        "FC: 72 bpm, PA: 120/78 mmHg, Temp: 36.7°C, FR: 16 rpm, SOxigeno: 98% SpO2","FC: 66 bpm, PA: 113/72 mmHg, Temp: 36.5°C, FR: 15 rpm, SOxigeno: 99% SpO2",
        "FC: 79 bpm, PA: 127/82 mmHg, Temp: 37.0°C, FR: 19 rpm, SOxigeno: 97% SpO2","FC: 75 bpm, PA: 124/79 mmHg, Temp: 36.8°C, FR: 18 rpm, SOxigeno: 97% SpO2",
        "FC: 78 bpm, PA: 126/81 mmHg, Temp: 36.9°C, FR: 17 rpm, SOxigeno: 98% SpO2","FC: 82 bpm, PA: 134/87 mmHg, Temp: 37.1°C, FR: 20 rpm, SOxigeno: 96% SpO2",
        "FC: 65 bpm, PA: 112/70 mmHg, Temp: 36.3°C, FR: 15 rpm, SOxigeno: 99% SpO2","FC: 77 bpm, PA: 125/80 mmHg, Temp: 36.8°C, FR: 18 rpm, SOxigeno: 97% SpO2",
        "FC: 69 bpm, PA: 116/73 mmHg, Temp: 36.4°C, FR: 17 rpm, SOxigeno: 98% SpO2","FC: 84 bpm, PA: 137/89 mmHg, Temp: 37.2°C, FR: 21 rpm, SOxigeno: 96% SpO2",
        "FC: 63 bpm, PA: 110/69 mmHg, Temp: 36.2°C, FR: 15 rpm, SOxigeno: 99% SpO2","FC: 80 bpm, PA: 130/85 mmHg, Temp: 36.9°C, FR: 19 rpm, SOxigeno: 96% SpO2",
        "FC: 71 bpm, PA: 119/76 mmHg, Temp: 36.6°C, FR: 17 rpm, SOxigeno: 98% SpO2","FC: 67 bpm, PA: 114/72 mmHg, Temp: 36.4°C, FR: 16 rpm, SOxigeno: 98% SpO2",
        "FC: 76 bpm, PA: 124/78 mmHg, Temp: 36.8°C, FR: 18 rpm, SOxigeno: 97% SpO2","FC: 79 bpm, PA: 127/82 mmHg, Temp: 36.9°C, FR: 17 rpm, SOxigeno: 97% SpO2",
        "FC: 83 bpm, PA: 135/88 mmHg, Temp: 37.1°C, FR: 20 rpm, SOxigeno: 96% SpO2","FC: 62 bpm, PA: 109/68 mmHg, Temp: 36.1°C, FR: 14 rpm, SOxigeno: 99% SpO2",
        "FC: 73 bpm, PA: 121/78 mmHg, Temp: 36.7°C, FR: 16 rpm, SOxigeno: 98% SpO2","FC: 81 bpm, PA: 133/86 mmHg, Temp: 37.0°C, FR: 19 rpm, SOxigeno: 96% SpO2",
        "FC: 66 bpm, PA: 113/71 mmHg, Temp: 36.3°C, FR: 15 rpm, SOxigeno: 98% SpO2","FC: 85 bpm, PA: 138/90 mmHg, Temp: 37.2°C, FR: 21 rpm, SOxigeno: 95% SpO2",
        "FC: 64 bpm, PA: 111/69 mmHg, Temp: 36.2°C, FR: 14 rpm, SOxigeno: 99% SpO2","FC: 75 bpm, PA: 123/80 mmHg, Temp: 36.8°C, FR: 18 rpm, SOxigeno: 97% SpO2",
        "FC: 68 bpm, PA: 116/73 mmHg, Temp: 36.4°C, FR: 17 rpm, SOxigeno: 98% SpO2"
        );
    RETURN interrogatorioSistemas_generada ;
END
DELIMITER ;

-- 5.- Función: "fn_genera_Padecimiento_Actual"
/*Genera un dato relevante sobre el padecimiento actual que pueda tener 
el paciente de forma aleatoria, esta funcion fue alimentada por 50 diferentes padecimientos.*/

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` FUNCTION `fn_genera_Padecimiento_Actual`() RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE padecimientoA_generada VARCHAR(200) DEFAULT NULL;
    SET padecimientoA_generada  = ELT(FLOOR(1 + RAND() * 50), 
    "Resfriado común","Gripe (influenza)",
    "Dolor de cabeza (cefalea)","Dolor de garganta",
    "Faringitis","Bronquitis",
    "Sinusitis","Otitis",
    "Asma","Rinitis alérgica",
    "Gastritis","Úlcera péptica",
    "Reflujo gastroesofágico","Estreñimiento",
    "Diarrea","Colitis",
    "Síndrome del intestino irritable","Hemorroides",
    "Diabetes tipo 2","Hipertensión arterial",
    "Hiperlipidemia (colesterol alto)","Sobrepeso",
    "Obesidad","Artritis",
    "Osteoartritis","Fibromialgia",
    "Tendinitis","Lumbalgia",
    "Ciática","Esguinces",
    "Fracturas óseas","Dermatitis",
    "Psoriasis","Acné",
    "Eczema","Candidiasis",
    "Infección urinaria","Cistitis",
    "Prostatitis","Hepatitis viral",
    "Sinusitis","Meningitis",
    "Epilepsia","Insomnio",
    "Depresión","Ansiedad",
    "Estrés","Trastorno de pánico",
    "Trastorno obsesivo-compulsivo","Trastorno bipolar");
    RETURN padecimientoA_generada ;
END
DELIMITER ;

-- 6.- Función: "fn_genera_Notas_Medicas"
/*Genera un dato relevante sobre las notas medicas que pueda tener 
el paciente de forma aleatoria, esta funcion fue alimentada por 50 diferentes notas medicas posibles.*/

DELIMITER &&
&&
CREATE DEFINER=`arturo.aguilar`@`%` FUNCTION `fn_genera_Notas_Medicas`() RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE notasMedicas_generada VARCHAR(200) DEFAULT NULL;
    SET notasMedicas_generada  = ELT(FLOOR(1 + RAND() * 50), 
		"Control mensual.","Dieta baja en carbohidratos.",
        "Fisioterapia recomendada.","Evitar desencadenantes conocidos.",
        "Incrementar la actividad física.","Monitoreo diario de la presión arterial.",
        "Realizar seguimiento en 3 semanas.","Realizar exámenes de laboratorio.",
        "Evitar consumo de alcohol.","Controlar los niveles de glucosa.",
        "Requiere revisión en 1 mes.","Iniciar tratamiento con dieta y ejercicio.",
        "Continuar con la medicación actual.","Revisión neurológica cada 6 meses.",
        "Suspender uso de antiinflamatorios.","Reevaluar en 2 semanas.",
        "Mantener hidratación adecuada.","Reducir la ingesta de sal.",
        "Necesita evaluación por especialista.","Evitar exposición al sol.",
        "Reposo absoluto por 48 horas.","Seguimiento semanal.",
        "Realizar control de peso semanal.","Iniciar tratamiento con probióticos.",
        "Control de síntomas en casa.","Seguir indicaciones de fisioterapia.",
        "Evitar alimentos ricos en grasas.","Mantener un diario de síntomas.",
        "Consultar si persisten los síntomas.","Revisión en 6 semanas.",
        "Evitar estrés excesivo.","Realizar pruebas de imagen.",
        "Iniciar terapia ocupacional.","Suspender el tratamiento si aparecen efectos secundarios.",
        "Aumentar la dosis gradualmente.","Realizar ejercicios de respiración.",
        "Control oftalmológico anual.","Recomendar uso de suplementos vitamínicos.",
        "Evitar el consumo de tabaco.","Revisar adherencia al tratamiento.",
        "Control de función hepática.","Realizar ecografía de control.",
        "Evaluar necesidad de cirugía.","Mantener comunicación con el equipo de salud.",
        "Informar sobre cualquier cambio de síntomas.","Considerar terapia psicológica.",
        "Programar revisión en 3 meses.","Observar signos de infección.",
        "Monitorizar frecuencia cardíaca.");
    RETURN notasMedicas_generada ;
END
DELIMITER ;