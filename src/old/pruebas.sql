-- LIMPIEZA 

DELETE FROM Pagos;         
DELETE FROM Beneficiarios;
DELETE FROM Polizas;
DELETE FROM Clientes;
DELETE FROM Asesores;
DELETE FROM Sucursales;
DELETE FROM Agencias;
COMMIT;

INSERT INTO Agencias (idAgencia, nombre, direccion)
VALUES (1, 'Agencia Norte', 'Calle 10 #45-12');

INSERT INTO Agencias (idAgencia, nombre, direccion)
VALUES (2, 'Agencia Sur', 'Carrera 15 #22-80');

INSERT INTO Sucursales (idSucursal, idAgencia, nombre, direccion)
VALUES (1, 1, 'Sucursal Centro', 'Calle 11 #10-01');

INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo)
VALUES (1, 1, 1, 1001001001, 'Carlos Mejia', 3101001001, 'carlos@ejemplo.com');

INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo)
VALUES (2, 2, 1, 2002002002, 'Laura Torres', 3102002002, 'laura@ejemplo.com');

INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, direccion, telefono, correo)
VALUES (1, 1, 1, 'Juan Perez', 'Calle 123', 3105551234, 'juan@correo.com');

INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, direccion, telefono, correo)
VALUES (2, 2, 2, 'Maria Lopez', 'Carrera 45', 3205554321, 'maria@correo.com');

INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente)
VALUES (10, 5555, DATE '2024-01-01', DATE '2025-01-01', 1200000, 'VIGENTE', 'S', 1);

INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente)
VALUES (12, 7777, DATE '2024-02-01', DATE '2025-02-01', 1000000, 'VIGENTE', 'S', 2);

-- Beneficiarios: requiere que Polizas existan
INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (1, 10, 'Carlos Perez', 'Hijo', 50);

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (2, 10, 'Ana Perez', 'Esposa', 50);

INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (1, 1, 10, DATE '2024-03-01', 600000, 'TRANSFERENCIA');

INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (2, 2, 12, DATE '2024-04-01', 500000, 'TARJETA');

COMMIT;

-- COMPROBACIONES RÁPIDAS
SELECT * FROM Clientes WHERE idCliente IN (1,2);
SELECT * FROM Polizas WHERE idPoliza IN (10,12);
SELECT * FROM Beneficiarios WHERE idPoliza = 10;
SELECT * FROM Pagos WHERE idPago IN (1,2);

-- CASOS NO VÁLIDOS 

-- 1) Insertar póliza con fechaFin <= fechaInic 
INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente)
VALUES (13, 8888, DATE '2025-01-01', DATE '2024-12-31', 800000, 'VIGENTE', 1, 1);

-- 2) Insertar póliza con cliente inexistente (FK)
INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente)
VALUES (14, 9999, DATE '2024-03-01', DATE '2025-03-01', 800000, 'VIGENTE', 1, 99);

-- 3) Beneficiario para poliza inexistente (FK)
INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (3, 99, 'Invalido', 'Padre', 30);

-- 4) Pago sin idCliente (NOT NULL)
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (3, NULL, 10, DATE '2024-05-01', 400000, 'EFECTIVO');
