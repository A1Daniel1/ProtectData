--- restricciones de tupla

ALTER TABLE Polizas
ADD CONSTRAINT chk_fechas_poliza
CHECK (fechaFin > fechaInic);


--- para esta si el pago es en efectivo, que no sea mayor
--- a 5 millones    
ALTER TABLE Pagos
ADD CONSTRAINT chk_metodo_monto_pago
CHECK (
    (metodoPago = 'EFECTIVO' AND monto <= 5000000)
    OR
    (metodoPago IN ('TRANSFERENCIA', 'TARJETA') AND monto > 0)
);


--- ACCIONES DE REFERENCIA

--- toco borrar las foreing key que habia
ALTER TABLE Beneficiarios DROP CONSTRAINT SYS_C0052761;


ALTER TABLE Beneficiarios
ADD CONSTRAINT fk_benef_poliza
FOREIGN KEY (idPoliza)
REFERENCES Polizas(idPoliza)
ON DELETE CASCADE;

ALTER TABLE Polizas DROP CONSTRAINT SYS_C0052750;

ALTER TABLE Polizas
ADD CONSTRAINT fk_poliza_cliente
FOREIGN KEY (idCliente)
REFERENCES Clientes(idCliente)
ON DELETE SET NULL;

--- Tigres

--- poliza activa si se registra un pago

CREATE OR REPLACE TRIGGER trg_activar_poliza
AFTER INSERT ON Pagos
FOR EACH ROW
BEGIN
    UPDATE Polizas
    SET estado = 'ACTIVA'
    WHERE idPoliza = :NEW.idPoliza;
END;
/

--- triger para revisar fechas

CREATE OR REPLACE TRIGGER trg_validar_fechas_poliza
BEFORE INSERT OR UPDATE ON Polizas
FOR EACH ROW
BEGIN
    IF :NEW.fechaFin <= :NEW.fechaInic THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha final debe ser posterior a la fecha inicial :)');
    END IF;
END;
/

