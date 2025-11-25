-- Ingreso de datos correctos con respecto a tuplas
-- Insertar un pago válido que cumpla las restricciones de tupla
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (99, 1, 10, DATE '2024-06-01', 100000, 'EFECTIVO');
