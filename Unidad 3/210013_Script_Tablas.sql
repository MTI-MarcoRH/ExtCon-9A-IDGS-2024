CREATE TABLE tbc_servicios_medicos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT,
    Observaciones TEXT,
    Fecha_Registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Fecha_Actualizacion DATETIME
);



CREATE TABLE tbd_departamentos_servicios (
    Departamento_ID INT NOT NULL,
    Servicio_ID INT NOT NULL,
    Requisitos TEXT,
    Restricciones TEXT,
    Estatus BIT(1) NOT NULL DEFAULT b'1',
    Fecha_Registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Fecha_Actualizacion DATETIME,
    PRIMARY KEY (Departamento_ID, Servicio_ID),
    FOREIGN KEY (Departamento_ID) REFERENCES tbc_departamentos(ID),
    FOREIGN KEY (Servicio_ID) REFERENCES tbc_servicios_medicos(ID)
);
