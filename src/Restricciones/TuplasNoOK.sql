/* Pruebas Fallidas de Tuplas (TuplasNoOK) */

-- 1. Correo invalido (sin @)
BEGIN
    INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, correo, telefono, direccion)
    VALUES (5002, 1, 1, 'Test Correo Fail', 'testcorreodominio.com', 3009998877, 'Dir Test');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Correo sin @): ' || SQLERRM);
END;
/

-- 2. Estado invalido
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (6002, 456456456, 5001, SYSDATE, SYSDATE + 365, 1000000, 'Invalido', 'S');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Estado invalido): ' || SQLERRM);
END;
/

-- 3. Renovable invalido
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (6003, 789789789, 5001, SYSDATE, SYSDATE + 365, 1000000, 'Activa', 'X');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Renovable invalido): ' || SQLERRM);
END;
/

-- 4. Prima negativa (Constraint anterior)
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (6004, 111111111, 5001, SYSDATE, SYSDATE + 365, -100, 'Activa', 'S');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado (Prima negativa): ' || SQLERRM);
END;
/
