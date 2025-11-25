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

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (1, 10, 'Carlos Perez', 'Hijo', 50);

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (2, 10, 'Ana Perez', 'Esposa', 50);

INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (1, 1, 10, DATE '2024-03-01', 600000, 'TRANSFERENCIA');

INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (2, 2, 12, DATE '2024-04-01', 500000, 'TARJETA');

COMMIT;
