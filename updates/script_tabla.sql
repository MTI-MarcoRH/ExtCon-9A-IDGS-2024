CREATE TABLE tbd_horarios (
  ID int NOT NULL AUTO_INCREMENT,
  espacio_id int unsigned NOT NULL,
  `servicio_medico_id`int unsigned NOT NULL,
  departamento_id int unsigned NOT NULL,
  nombre varchar(100) NOT NULL,
  especialidad varchar(100) NOT NULL,
  dia_semana varchar(20) NOT NULL,
  hora_inicio time NOT NULL,
  hora_fin time NOT NULL,
  turno ENUM('Matutino', 'Vespertino', 'Nocturno') NOT NULL,
  tipo_horario ENUM('Diario', 'Semanal', 'Quincenal', 'Mensual') NOT NULL,
  fecha_creacion timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  FOREIGN KEY (espacio_id) REFERENCES tbc_espacios(ID),
  FOREIGN KEY (servicio_medico_id) REFERENCES tbc_servicios_medicos(ID),
  FOREIGN KEY (departamento_id) REFERENCES tbc_departamentos(ID)
);