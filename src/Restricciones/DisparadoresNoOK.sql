/* Pruebas Fallidas de Disparadores (Actualizado) */

-- 1. Intento de insertar Poliza con fecha inicio en el pasado (hace 1 mes)
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (3002, 444555666, 1001, SYSDATE - 30, SYSDATE + 335, 800000, 'Activa', 'S');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Fecha inicio en pasado): ' || SQLERRM);
END;
/

-- 2. Intento de insertar Poliza con duracion muy corta (< 6 meses)
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (3003, 777888999, 1001, SYSDATE, SYSDATE + 30, 800000, 'Activa', 'S');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Duracion < 6 meses): ' || SQLERRM);
END;
/

-- 3. Intento de insertar Poliza con duracion muy larga (> 5 años)
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (3004, 000111222, 1001, SYSDATE, SYSDATE + 2000, 800000, 'Activa', 'S');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Duracion > 5 años): ' || SQLERRM);
END;
/

-- 4. Intento de insertar Reclamo para poliza Inactiva
-- Primero insertamos una poliza inactiva valida
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (3005, 333444555, 1001, SYSDATE, SYSDATE + 365, 800000, 'Cancelada', 'N');
    COMMIT;
END;
/

BEGIN
    INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
    VALUES (4002, 3005, SYSDATE + 10, 200000, 'Pendiente', 'Prueba Trigger Fail Estado');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Poliza Inactiva): ' || SQLERRM);
END;
/

-- Nueva reclamación de 8,000: 3000 + 8000 = 11,000 > 10,000 → ERROR
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (3, 1, SYSDATE, 8000, 'EN PROCESO', 'Reclamación que excede cobertura');

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (12, 10, 'Cobertura adicional pequeña', 1000000);

--Aqui tenemos una cobertura muy mayor a la prima que se paga
BEGIN
    -- Intento de agregar una cobertura adicional a la póliza 10
    -- Esta inserción DEBE FALLAR por exceder el límite (ya está en 75M)
    INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
    VALUES (22, 10, 'Cobertura extra prueba', 1000000);

    -- Si llega aquí, el trigger NO falló (lo cual estaría mal)
    DBMS_OUTPUT.PUT_LINE('ERROR: La inserción de cobertura en póliza 10 NO falló y debía fallar.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(
            'Error esperado (coberturas > prima * factor) en póliza 10: ' || SQLERRM
        );
END;
/




