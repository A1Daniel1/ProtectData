-- DisparadoresNoOK: trg_validar_fechas_poliza
-- Intento de actualizar fechas invalidas
UPDATE Polizas 
SET fechaFin = DATE '2023-01-01' 
WHERE idPoliza = 12;
-- Deberia fallar con error -20001
