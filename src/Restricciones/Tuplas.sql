-- Restricciones de Tupla (Multi-atributo)
ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Fechas
CHECK (fechaFin > fechaInic);

ALTER TABLE Pagos
ADD CONSTRAINT CK_Pagos_Metodo_Monto
CHECK (
    (metodoPago = 'EFECTIVO' AND monto <= 5000000)
    OR
    (metodoPago IN ('TRANSFERENCIA', 'TARJETA') AND monto > 0)
);

