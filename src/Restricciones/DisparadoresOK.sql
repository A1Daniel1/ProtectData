/* Pruebas Exitosas de Disparadores */

-- 0. PREPARACIÓN: Insertar Seguro de prueba (ID 999) para evitar el ORA-01400 en Polizas.
DECLARE
BEGIN
    INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
    VALUES (99999, 'Test', 'Test', 'Para pruebas', 1);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        NULL;
END;
/

-- 1. Insertar Poliza con fechas validas
BEGIN
    -- CORRECCIÓN: Se añade idSeguro (99999) y se usa idCliente existente (1).
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro)
    VALUES (93001, 111222333, 1, SYSDATE, SYSDATE + 365, 800000, 'Activa', 'S', 99999);
    DBMS_OUTPUT.PUT_LINE('Poliza 93001 insertada correctamente (Fechas validas).');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FALLO INESPERADO: ' || SQLERRM);
END;
/

-- 2. Insertar Reclamo valido (Poliza Activa y fecha dentro de rango)
BEGIN
    -- Necesitamos cobertura primero
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (94001, 93001, 'Cobertura Trigger OK', 5000000);

    INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
    VALUES (94001, 93001, SYSDATE + 10, 200000, 'Pendiente', 'Prueba Trigger OK');
    DBMS_OUTPUT.PUT_LINE('Reclamo 94001 insertado correctamente (Poliza Activa y fecha valida).');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FALLO INESPERADO: ' || SQLERRM);
END;
/


-- Coberturas de la póliza 93001 (TOTAL: 10,000)
INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (90001, 93001, 'Cobertura muerte accidental', 6000);

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (90002, 93001, 'Cobertura invalidez total', 4000);

-- Reclamación ya existente por 3,000
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (90001, 93001, SYSDATE + 5, 3000, 'APROBADA', 'Reclamación inicial');

-- Nueva reclamación de 2,000: 3000 + 2000 = 5000 <= 10000 
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (90002, 93001, SYSDATE + 6, 2000, 'EN PROCESO', 'Segunda reclamación');

---------------------------------------------------------------------------

--Creamos Poliza con una prima razonable y luego insertar coberturas que si pasan el trigger
BEGIN
    
    INSERT INTO Polizas (
        idPoliza, numeroPoliza, idCliente,
        fechaInic, fechaFin,
        prima, estado, renovable, idSeguro
    )
    VALUES (
        90030,            
        999000,
        1,              
        SYSDATE, -- Use SYSDATE to avoid past date issues
        SYSDATE + 365,
        1000000,        
        'Activa', -- Use Activa instead of VIGENTE if check constraint requires it, or VIGENTE if allowed
        'S',
        99999             
    );

    -- Cobertura 1: 7,000,000
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (90020, 90030, 'Cobertura básica vida', 7000000);

    -- Cobertura 2: 8,000,000  → suma = 15,000,000 ≤ 20,000,000 (NO DEBE FALLAR)
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (90021, 90030, 'Cobertura adicional accidente', 8000000);

    DBMS_OUTPUT.PUT_LINE('Prueba OK: coberturas de la póliza 30 se insertaron sin violar el trigger.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR (no esperado) en prueba EXITOSA: ' || SQLERRM);
END;
/




-- LIMPIEZA 
DELETE FROM Reclamaciones WHERE idReclamacion IN (94001, 90001, 90002);
DELETE FROM Coberturas WHERE idPoliza IN (93001, 90030);
DELETE FROM Polizas WHERE idPoliza IN (93001, 90030);
DELETE FROM Seguros WHERE idSeguro = 99999;
COMMIT;







