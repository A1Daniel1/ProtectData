--- CK_Polizas_Fechas

INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro) VALUES (2013, 10203, 58,  TO_DATE('2030-03-29', 'YYYY-MM-DD'), TO_DATE('2025-12-10', 'YYYY-MM-DD'), 4749235.29, 'Cancelada', 'N', 2);


--- CK_Pagos_Metodo_Monto

INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago) VALUES (205, 7, 181, TO_DATE('2026-01-01', 'YYYY-MM-DD'), 5000000.96, 'EFECTIVO');


     