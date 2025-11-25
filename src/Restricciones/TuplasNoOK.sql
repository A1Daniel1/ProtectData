-- Prueba CK_Pagos_Metodo_Monto: Efectivo > 5M
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (4, 1, 10, DATE '2024-06-01', 6000000, 'EFECTIVO');

-- Prueba CK_Pagos_Metodo_Monto: Transferencia <= 0
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (5, 1, 10, DATE '2024-06-01', 0, 'TRANSFERENCIA');
