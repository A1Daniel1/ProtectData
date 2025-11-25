CREATE TABLE Agencias (
    idAgencia NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(200)
);

CREATE TABLE Sucursales (
    idSucursal NUMBER(10) PRIMARY KEY,
    idAgencia NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(200),
    FOREIGN KEY (idAgencia) REFERENCES Agencias(idAgencia)
);

CREATE TABLE Asesores (
    idAsesor NUMBER(10) PRIMARY KEY,
    idAgencia NUMBER(10) NOT NULL,
    idSucursal NUMBER(10) NOT NULL,
    cedula NUMBER(10) UNIQUE,
    nombre VARCHAR2(100) NOT NULL,
    telefono NUMBER(10),
    correo VARCHAR2(100),
    FOREIGN KEY (idAgencia) REFERENCES Agencias(idAgencia),
    FOREIGN KEY (idSucursal) REFERENCES Sucursales(idSucursal)
);

CREATE TABLE Clientes (
    idCliente NUMBER(10) PRIMARY KEY,
    idAgencia NUMBER(10) NOT NULL,
    idAsesor NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100) UNIQUE NOT NULL,
    telefono NUMBER(10),
    direccion VARCHAR2(200),
    FOREIGN KEY (idAgencia) REFERENCES Agencias(idAgencia),
    FOREIGN KEY (idAsesor) REFERENCES Asesores(idAsesor)
);

CREATE TABLE Polizas (
    idPoliza NUMBER(10) PRIMARY KEY,
    numeroPoliza NUMBER(20) UNIQUE,
    idCliente NUMBER(10) NOT NULL,
    fechaInic DATE NOT NULL,
    fechaFin DATE NOT NULL,
    prima NUMBER(10,2) NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    renovable CHAR(1) CHECK (renovable IN ('S','N')),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

CREATE TABLE Pagos (
    idPago NUMBER(10) PRIMARY KEY,
    idCliente NUMBER(10) NOT NULL,
    idPoliza NUMBER(10) NOT NULL,
    fechaPago DATE NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    metodoPago VARCHAR2(15) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza)
);

CREATE TABLE Beneficiarios (
    idBeneficiario NUMBER(10) PRIMARY KEY,
    idPoliza NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    relacion VARCHAR2(100) NOT NULL,
    porcentaje NUMBER(3) CHECK (porcentaje BETWEEN 0 AND 100),
    FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza)
);

CREATE TABLE Coberturas (
    idCobertura NUMBER(10) PRIMARY KEY,
    idPoliza NUMBER(10) NOT NULL,
    descripcionC VARCHAR2(500) NOT NULL,
    montoMax NUMBER(10,2) NOT NULL,
    FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza)
);

CREATE TABLE Reclamaciones (
    idReclamacion NUMBER(10) PRIMARY KEY,
    idPoliza NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(500),
    FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza)
);
