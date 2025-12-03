/* Pruebas Exitosas (CRUDOK) */

-- Insertar un cliente valido
-- Asumiendo que existen Agencias y Asesores con ID 1 (si no, esto fallaria por FK, pero es una prueba logica)
BEGIN
    PC_Clientes.AdicionarCliente(1001, 1, 1, 'Juan Perez', 'juan.perez@email.com', 3001234567, 'Calle 123 #45-67');
    DBMS_OUTPUT.PUT_LINE('Cliente 1001 registrado exitosamente.');
END;
/
SELECT * FROM Clientes WHERE idCliente = 1001;

-- Insertar Aseguradora
BEGIN
    PC_Aseguradoras.AdicionarAseguradora(9001, 'Seguros Bolivar', 3001112233, 900123456, 'Calle 26 #50-20');
    DBMS_OUTPUT.PUT_LINE('Aseguradora 9001 registrada exitosamente.');
END;
/
SELECT * FROM Aseguradoras WHERE idAseguradora = 9001;

-- Insertar Seguro
BEGIN
    PC_Seguros.AdicionarSeguro(8001, 'Seguro Vida Total', 'Vida', 'Cobertura total', 9001);
    DBMS_OUTPUT.PUT_LINE('Seguro 8001 registrado exitosamente.');
END;
/
SELECT * FROM Seguros WHERE idSeguro = 8001;

-- Insertar una poliza valida (Actualizado con idSeguro)
BEGIN
    PC_Polizas.AdicionarPoliza(2001, 987654321, 1001, SYSDATE, SYSDATE + 365, 1500000, 'Activa', 'S', 8001);
    DBMS_OUTPUT.PUT_LINE('Poliza 2001 registrada exitosamente.');
END;
/
SELECT * FROM Polizas WHERE idPoliza = 2001;

-- Renovar poliza
BEGIN
    PC_Polizas.RenovarPoliza(2001, SYSDATE + 730);
    DBMS_OUTPUT.PUT_LINE('Poliza 2001 renovada exitosamente.');
END;
/
SELECT * FROM Polizas WHERE idPoliza = 2001;

-- Registrar un reclamo valido
BEGIN
    PC_Reclamos.RegistrarReclamo(3001, 2001, SYSDATE, 500000, 'Pendiente', 'Choque leve');
    DBMS_OUTPUT.PUT_LINE('Reclamo 3001 registrado exitosamente.');
END;
/
SELECT * FROM Reclamaciones WHERE idReclamacion = 3001;

-- Registrar un pago valido
BEGIN
    PC_Pagos.RegistrarPago(4001, 1001, 2001, SYSDATE, 1500000, 'Tarjeta');
    DBMS_OUTPUT.PUT_LINE('Pago 4001 registrado exitosamente.');
END;
/
SELECT * FROM Pagos WHERE idPago = 4001;
