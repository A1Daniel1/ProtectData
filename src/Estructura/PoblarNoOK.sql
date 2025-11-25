-- 1) Insertar póliza con fechaFin <= fechaInic 
-- (Esto fallará por la lógica de negocio o por el Trigger/Check si están activos)
INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente)
VALUES (13, 8888, DATE '2025-01-01', DATE '2024-12-31', 800000, 'VIGENTE', 'S', 1);

-- 2) Insertar póliza con cliente inexistente (FK)
INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente)
VALUES (14, 9999, DATE '2024-03-01', DATE '2025-03-01', 800000, 'VIGENTE', 'S', 99);

-- 3) Beneficiario para poliza inexistente (FK)
INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (3, 99, 'Invalido', 'Padre', 30);

-- 4) Pago sin idCliente (NOT NULL)
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (3, NULL, 10, DATE '2024-05-01', 400000, 'EFECTIVO');
