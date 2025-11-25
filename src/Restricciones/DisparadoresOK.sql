-- DisparadoresOK: trg_activar_poliza
-- Insertar un pago para la Poliza 12 (que ahora tiene idCliente NULL pero existe)
-- La poliza 12 tiene estado 'VIGENTE'. Al insertar pago, debe pasar a 'ACTIVA'.
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
VALUES (6, 1, 12, DATE '2024-07-01', 100000, 'EFECTIVO'); -- Usamos cliente 1 pq cliente 2 fue borrado

-- Verificar cambio de estado
SELECT estado FROM Polizas WHERE idPoliza = 12; -- Deberia ser 'ACTIVA'
