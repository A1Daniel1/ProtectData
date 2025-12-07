/* Pruebas Exitosas de Acciones (AccionesOK) */

-- Insertar Seguro de prueba (ID 999) para satisfacer la restricción NOT NULL de Polizas (ORA-01400)
DECLARE
BEGIN
    INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
    VALUES (999, 'Seguro Test', 'Test', 'Seguro para pruebas de acciones', 1);
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        NULL;
END;
/

-- Prueba de borrado en cascada (Poliza -> Reclamaciones/Pagos)
DECLARE
    v_count NUMBER;
    v_cliente_id NUMBER := 1;
BEGIN
    -- 1. Crear Poliza (INCLUYE idSeguro 999 - CORRECCIÓN ORA-01400)
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro)
    VALUES (7001, 999888777, v_cliente_id, SYSDATE, SYSDATE + 365, 2000000, 'Activa', 'S', 999);
    
    -- 1.5 Crear Cobertura (NECESARIO PARA EL TRIGGER trg_reclamaciones_cobertura_acumulada)
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (7001, 7001, 'Cobertura Test Cascada', 10000000);
    
    -- 2. Crear Reclamo asociado
    INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
    VALUES (8001, 7001, SYSDATE + 30, 500000, 'Pendiente', 'Test Cascada');
    
    -- 3. Crear Pago asociado
    INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
    VALUES (9001, v_cliente_id, 7001, SYSDATE, 2000000, 'EFECTIVO');
    
    -- 4. Eliminar Poliza
    DELETE FROM Polizas WHERE idPoliza = 7001;
    DBMS_OUTPUT.PUT_LINE('Poliza 7001 eliminada.');
    
    -- 5. Verificar que no existan reclamos ni pagos
    SELECT COUNT(*) INTO v_count FROM Reclamaciones WHERE idPoliza = 7001;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Reclamos eliminados en cascada correctamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FALLO: Reclamos no eliminados. Count: ' || v_count);
    END IF;
    
    SELECT COUNT(*) INTO v_count FROM Pagos WHERE idPoliza = 7001;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Pagos eliminados en cascada correctamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FALLO: Pagos no eliminados. Count: ' || v_count);
    END IF;

    COMMIT;
END;
/