/* Pruebas Exitosas de Tuplas (TuplasOK) */

-- Insertar Cliente con correo valido
BEGIN
    INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, correo, telefono, direccion)
    VALUES (5001, 1, 1, 'Test Correo OK', 'test.correo@dominio.com', 3009998877, 'Dir Test');
    DBMS_OUTPUT.PUT_LINE('Cliente 5001 insertado correctamente (Correo valido).');
END;
/

-- Insertar Poliza con Estado y Renovable validos
BEGIN
    INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
    VALUES (6001, 123123123, 5001, SYSDATE, SYSDATE + 365, 1000000, 'Activa', 'S');
    DBMS_OUTPUT.PUT_LINE('Poliza 6001 insertada correctamente (Estado y Renovable validos).');
END;
/
