/* Pruebas Exitosas de Disparadores */

-- 0. PREPARACIÓN: Insertar Seguro de prueba (ID 999) para evitar el ORA-01400 en Polizas.
DECLARE
BEGIN
    INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
    VALUES (999, 'Test', 'Test', 'Para pruebas', 1);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        NULL;
END;
/

-- 1. Insertar Poliza con fechas validas
BEGIN
    -- CORRECCIÓN: Se añade idSeguro (999) y se usa idCliente existente (1).
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro)
    VALUES (3001, 111222333, 1, SYSDATE, SYSDATE + 365, 800000, 'Activa', 'S', 999);
    DBMS_OUTPUT.PUT_LINE('Poliza 3001 insertada correctamente (Fechas validas).');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FALLO INESPERADO: ' || SQLERRM);
END;
/

-- 2. Insertar Reclamo valido (Poliza Activa y fecha dentro de rango)
BEGIN
    INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
    VALUES (4001, 3001, SYSDATE + 10, 200000, 'Pendiente', 'Prueba Trigger OK');
    DBMS_OUTPUT.PUT_LINE('Reclamo 4001 insertado correctamente (Poliza Activa y fecha valida).');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FALLO INESPERADO: ' || SQLERRM);
END;
/


-- Coberturas de la póliza 1 (TOTAL: 10,000)
INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (1, 1, 'Cobertura muerte accidental', 6000);

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (2, 1, 'Cobertura invalidez total', 4000);

-- Reclamación ya existente por 3,000
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (1, 1, SYSDATE, 3000, 'APROBADA', 'Reclamación inicial');

-- Nueva reclamación de 2,000: 3000 + 2000 = 5000 <= 10000 
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (2, 1, SYSDATE, 2000, 'EN PROCESO', 'Segunda reclamación');

---------------------------------------------------------------------------

--Creamos Poliza con una prima razonable y luego insertar coberturas que si pasan el trigger
BEGIN
    
    INSERT INTO Polizas (
        idPoliza, numeroPoliza, idCliente,
        fechaInic, fechaFin,
        prima, estado, renovable, idSeguro
    )
    VALUES (
        30,            
        999000,
        1,              
        DATE '2024-05-01',
        DATE '2025-05-01',
        1000000,        
        'VIGENTE',
        'S',
        100             
    );

    -- Cobertura 1: 7,000,000
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (20, 30, 'Cobertura básica vida', 7000000);

    -- Cobertura 2: 8,000,000  → suma = 15,000,000 ≤ 20,000,000 (NO DEBE FALLAR)
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (21, 30, 'Cobertura adicional accidente', 8000000);

    DBMS_OUTPUT.PUT_LINE('Prueba OK: coberturas de la póliza 30 se insertaron sin violar el trigger.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR (no esperado) en prueba EXITOSA: ' || SQLERRM);
END;
/




-- LIMPIEZA 
DELETE FROM Reclamaciones WHERE idReclamacion = 4001;
DELETE FROM Polizas WHERE idPoliza = 3001;
DELETE FROM Seguros WHERE idSeguro = 999;
COMMIT;







