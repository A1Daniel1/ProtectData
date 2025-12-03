-- POBLACIÓN INICIAL DE TABLAS PADRE
INSERT INTO Aseguradoras(idAseguradora, nombre, telefono, nit, direccion)
VALUES (1, 'Aseguradora X', 3123123, 312, 'Calle 6 #31-32');

INSERT INTO Agencias (idAgencia, nombre, direccion, idAseguradora)
VALUES (1, 'Agencia Norte', 'Calle 10 #45-12', 1);

INSERT INTO Agencias (idAgencia, nombre, direccion, idAseguradora)
VALUES (2, 'Agencia Sur', 'Carrera 15 #22-80', 1);

INSERT INTO Sucursales (idSucursal, idAgencia, nombre, direccion)
VALUES (1, 1, 'Sucursal Centro', 'Calle 11 #10-01');

INSERT INTO Sucursales (idSucursal, idAgencia, nombre, direccion)
VALUES (2, 2, 'Sucursal Sur', 'Carrera 15 #22-90');

INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo)
VALUES (1, 1, 1, 1001001001, 'Carlos Mejia', 3101001001, 'carlos@ejemplo.com');

INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo)
VALUES (2, 2, 2, 2002002002, 'Laura Torres', 3102002002, 'laura@ejemplo.com');

INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, direccion, telefono, correo)
VALUES (1, 1, 1, 'Juan Perez', 'Calle 123', 3105551234, 'juan@correo.com');

INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, direccion, telefono, correo)
VALUES (2, 2, 2, 'Maria Lopez', 'Carrera 45', 3205554321, 'maria@correo.com');


-- TABLAS FALTANTES: SEGUROS (Dependencia para Polizas)
INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
VALUES (100, 'Vida Total', 'Vida', 'Seguro de vida con cobertura completa', 1);

INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
VALUES (200, 'Auto Premium', 'Automovil', 'Todo riesgo para vehiculos gama alta', 1);


-- POBLACIÓN DE PÓLIZAS (CON CAMPO idSeguro CORREGIDO)
INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente, idSeguro)
VALUES (10, 5555, DATE '2024-01-01', DATE '2025-01-01', 1200000, 'VIGENTE', 'S', 1, 100);

INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente, idSeguro)
VALUES (12, 7777, DATE '2024-02-01', DATE '2025-02-01', 1000000, 'VIGENTE', 'S', 2, 200);


-- POBLACIÓN DE BENEFICIARIOS
INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (1, 10, 'Carlos Perez', 'Hijo', 50);

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (2, 10, 'Ana Perez', 'Esposa', 50);

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (3, 12, 'Maria Lopez', 'Titular', 100);


-- TABLAS FALTANTES: COBERTURAS
-- Coberturas para la Póliza 10 (Vida - idSeguro 100)
INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (1, 10, 'Muerte por cualquier causa', 50000000.00);

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (2, 10, 'Incapacidad total permanente', 25000000.00);

-- Coberturas para la Póliza 12 (Auto - idSeguro 200)
INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (3, 12, 'Responsabilidad Civil Extracontractual', 100000000.00);


-- TABLAS FALTANTES: RECLAMACIONES
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (1, 12, DATE '2024-06-15', 500000, 'APROBADO', 'Rotura de espejo lateral derecho');

INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (2, 12, DATE '2024-08-20', 1200000.00, 'EN REVISION', 'Golpe leve en parachoques trasero');


-- POBLACIÓN DE PAGOS
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (1, 1, 10, DATE '2024-03-01', 600000, 'TRANSFERENCIA');

INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (2, 2, 12, DATE '2024-04-01', 500000, 'TARJETA');

COMMIT;