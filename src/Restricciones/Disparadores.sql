-- Trigger: Activar poliza al registrar pago
CREATE OR REPLACE TRIGGER trg_activar_poliza
AFTER INSERT ON Pagos
FOR EACH ROW
BEGIN
    UPDATE Polizas
    SET estado = 'ACTIVA'
    WHERE idPoliza = :NEW.idPoliza;
END;
/

-- Trigger: Validar fechas de poliza
CREATE OR REPLACE TRIGGER trg_validar_fechas_poliza
BEFORE INSERT OR UPDATE ON Polizas
FOR EACH ROW
BEGIN
    IF :NEW.fechaFin <= :NEW.fechaInic THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha final debe ser posterior a la fecha inicial :)');
    END IF;
END;
/
