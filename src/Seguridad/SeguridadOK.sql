/*==========================================
  Prueba para ADMIN
==========================================*/

DECLARE
    v_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Prueba de seguridad para ADMIN_APP ===');

    -- Limpieza previa para evitar errores de duplicados
    DELETE FROM Polizas WHERE idPoliza IN (8001, 9001);
    DELETE FROM Clientes WHERE idCliente IN (8001, 9001);
    DELETE FROM Seguros WHERE idSeguro = 100;
    DELETE FROM Aseguradoras WHERE idAseguradora = 800;
    COMMIT;

    -- 0) Crear Seguro de prueba (Necesario para FK de Polizas)
    INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
    VALUES (100, 'Seguro Test Seguridad', 'Vida', 'Seguro para pruebas de seguridad', 1);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('- OK: Seguro 100 creado para pruebas.');

    -- 1) Crear una aseguradora
    PKG_Admin.CrearAseguradora(
        p_idAseguradora => 800,
        p_nombre        => 'Aseguradora Global Admin',
        p_telefono      => 3118000000,
        p_nit           => 800800800,
        p_direccion     => 'Calle Admin Global'
    );
    DBMS_OUTPUT.PUT_LINE('- OK: ADMIN_APP creó una aseguradora mediante PKG_Admin.CrearAseguradora.');

    -- Verificar en tabla
    SELECT COUNT(*)
    INTO   v_count
    FROM   Aseguradoras
    WHERE  idAseguradora = 800;

    IF v_count = 1 THEN
        DBMS_OUTPUT.PUT_LINE('- OK: Aseguradora 800 existe en tabla Aseguradoras.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('- ERROR: Aseguradora 800 no se encuentra en la tabla.');
    END IF;


    -- 2) Crear cliente y póliza usando PKG_Admin (que reutiliza PC_Clientes y PC_Polizas)
    PKG_Admin.CrearCliente(
        p_idCliente => 8001,
        p_idAgencia => 1,
        p_idAsesor  => 1,
        p_nombre    => 'Cliente Admin Seguridad',
        p_correo    => 'cliente.admin.seg@demo.com',
        p_telefono  => 3020000000,
        p_direccion => 'Calle Admin 123'
    );
    DBMS_OUTPUT.PUT_LINE('- OK: ADMIN_APP creó cliente 8001 mediante PKG_Admin.CrearCliente.');

    PKG_Admin.CrearPoliza(
        p_idPoliza     => 8001,
        p_numeroPoliza => 998001,
        p_idCliente    => 8001,
        p_fechaInic    => SYSDATE,
        p_fechaFin     => SYSDATE + 365,
        p_prima        => 900000,
        p_estado       => 'VIGENTE',
        p_renovable    => 'S',
        p_idSeguro     => 100
    );
    DBMS_OUTPUT.PUT_LINE('- OK: ADMIN_APP creó póliza 8001 para cliente 8001.');

    -- 3) Consulta libre de pólizas
    SELECT COUNT(*)
    INTO   v_count
    FROM   Polizas;

    DBMS_OUTPUT.PUT_LINE('- ADMIN_APP puede ver todas las pólizas. Total de pólizas actuales: ' || v_count);

END;
/

/*===========================
  Prueba para ASESOR
 ===========================*/

DECLARE
    v_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Prueba de seguridad para ASESOR_APP ===');

    -- 1) Crear un cliente vía PKG_Asesor (reutiliza PC_Clientes)
    PKG_Asesor.CrearCliente(
        p_idCliente => 9001,
        p_idAgencia => 1,
        p_idAsesor  => 1,
        p_nombre    => 'Cliente Asesor Seguridad',
        p_correo    => 'cliente.asesor.seg@demo.com',
        p_telefono  => 3001230000,
        p_direccion => 'Calle Asesor 100'
    );
    DBMS_OUTPUT.PUT_LINE('- OK: Cliente creado mediante PKG_Asesor.CrearCliente');

    -- Verificar que el cliente quedó en la tabla Clientes
    SELECT COUNT(*)
    INTO   v_count
    FROM   Clientes
    WHERE  idCliente = 9001;

    IF v_count = 1 THEN
        DBMS_OUTPUT.PUT_LINE('- OK: Cliente 9001 existe en tabla Clientes');
    ELSE
        DBMS_OUTPUT.PUT_LINE('- ERROR: Cliente 9001 NO se encuentra en tabla Clientes');
    END IF;


    -- 2) Crear una póliza para ese cliente
    PKG_Asesor.CrearPoliza(
        p_idPoliza     => 9001,
        p_numeroPoliza => 990001,
        p_idCliente    => 9001,
        p_fechaInic    => SYSDATE,
        p_fechaFin     => SYSDATE + 365,
        p_prima        => 500000,
        p_estado       => 'VIGENTE',
        p_renovable    => 'S',
        p_idSeguro     => 100 -- debe existir
    );
    DBMS_OUTPUT.PUT_LINE('- OK: Póliza 9001 creada mediante PKG_Asesor.CrearPoliza');

    -- Verificar que la póliza quedó registrada
    SELECT COUNT(*)
    INTO   v_count
    FROM   Polizas
    WHERE  idPoliza = 9001
       AND idCliente = 9001;

    IF v_count = 1 THEN
        DBMS_OUTPUT.PUT_LINE('- OK: Póliza 9001 asociada al cliente 9001 existe en tabla Polizas');
    ELSE
        DBMS_OUTPUT.PUT_LINE('- ERROR: Póliza 9001 NO se encuentra o no está ligada al cliente 9001');
    END IF;


    -- 3) Intento de operación que NO debe poder hacer: crear una aseguradora
    BEGIN
        PKG_Admin.CrearAseguradora(
            p_idAseguradora => 900,
            p_nombre        => 'Aseguradora Solo Admin',
            p_telefono      => 3110000000,
            p_nit           => 900999000,
            p_direccion     => 'Calle Prohibida'
        );
        DBMS_OUTPUT.PUT_LINE('- ERROR: ASESOR_APP pudo ejecutar PKG_Admin.CrearAseguradora (NO debería).');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('- OK: ASESOR_APP NO tiene permisos sobre PKG_Admin.CrearAseguradora: ' || SQLERRM);
    END;

END;
/
