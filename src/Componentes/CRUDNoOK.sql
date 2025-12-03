/* Pruebas Fallidas  */

-- Intento de insertar cliente duplicado (PK)
BEGIN
    PC_Clientes.AdicionarCliente(1001, 1, 1, 'Juan Perez Duplicado', 'juan.fake@email.com', 3000000000, 'Calle Falsa');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado al duplicar cliente: ' || SQLERRM);
END;
/

-- Intento de insertar poliza con cliente inexistente (FK)
BEGIN
    PC_Polizas.AdicionarPoliza(2002, 999999, 9999, SYSDATE, SYSDATE + 365, 100000, 'Activa', 'S', 8001);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado al usar cliente inexistente: ' || SQLERRM);
END;
/

-- Intento de renovar poliza inexistente
BEGIN
    PC_Polizas.RenovarPoliza(9999, SYSDATE + 365);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado al renovar poliza inexistente: ' || SQLERRM);
END;
/

-- Probando enviar NULL en campo obligatorio en este caso el de id poliza
BEGIN
    PC_Reclamos.RegistrarReclamo(3002, NULL, SYSDATE, 0, 'Pendiente', 'Test Null');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado al insertar nulo en campo obligatorio: ' || SQLERRM);
END;
/
