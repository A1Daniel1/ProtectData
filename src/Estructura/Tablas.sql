CREATE TABLE Agencias (
    idAgencia NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(200)
);

CREATE TABLE Sucursales (
    idSucursal NUMBER(10) NOT NULL,
    idAgencia NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(200)
);

CREATE TABLE Asesores (
    idAsesor NUMBER(10) NOT NULL,
    idAgencia NUMBER(10) NOT NULL,
    idSucursal NUMBER(10) NOT NULL,
    cedula NUMBER(10),
    nombre VARCHAR2(100) NOT NULL,
    telefono NUMBER(10),
    correo VARCHAR2(100)
);

CREATE TABLE Clientes (
    idCliente NUMBER(10) NOT NULL,
    idAgencia NUMBER(10) NOT NULL,
    idAsesor NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100) NOT NULL,
    telefono NUMBER(10),
    direccion VARCHAR2(200)
);

CREATE TABLE Polizas (
    idPoliza NUMBER(10) NOT NULL,
    numeroPoliza NUMBER(20),
    idCliente NUMBER(10) NOT NULL,
    fechaInic DATE NOT NULL,
    fechaFin DATE NOT NULL,
    prima NUMBER(10,2) NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    renovable CHAR(1)
);

CREATE TABLE Pagos (
    idPago NUMBER(10) NOT NULL,
    idCliente NUMBER(10) NOT NULL,
    idPoliza NUMBER(10) NOT NULL,
    fechaPago DATE NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    metodoPago VARCHAR2(15) NOT NULL
);

CREATE TABLE Beneficiarios (
    idBeneficiario NUMBER(10) NOT NULL,
    idPoliza NUMBER(10) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    relacion VARCHAR2(100) NOT NULL,
    porcentaje NUMBER(3)
);

CREATE TABLE Coberturas (
    idCobertura NUMBER(10) NOT NULL,
    idPoliza NUMBER(10) NOT NULL,
    descripcionC VARCHAR2(500) NOT NULL,
    montoMax NUMBER(10,2) NOT NULL
);

CREATE TABLE Reclamaciones (
    idReclamacion NUMBER(10) NOT NULL,
    idPoliza NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(500)
);
