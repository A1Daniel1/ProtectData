/*
    Script de Pruebas para Usuario: bd1000105317
    Objetivo: Verificar permisos de los roles RL_ADMIN, RL_ASESOR, RL_ASEGURADORA, RL_CLIENTE.
*/

SET SERVEROUTPUT ON;

DECLARE
    v_user VARCHAR2(50);
    v_count NUMBER;
BEGIN
    SELECT USER INTO v_user FROM DUAL;
    DBMS_OUTPUT.PUT_LINE('=== Iniciando pruebas con usuario: ' || v_user || ' ===');

    -- ==========================================
    -- 1. PRUEBA DE ROL ADMIN (PKG_Admin)
    -- ==========================================
    DBMS_OUTPUT.PUT_LINE('--- 1. Probando ROL ADMIN ---');
    
    -- 1.1 Crear Aseguradora
    BEGIN
        BD1000103871.PKG_Admin.CrearAseguradora(
            p_idAseguradora => 777,
            p_nombre        => 'Aseguradora Test User',
            p_telefono      => 3007777777,
            p_nit           => 777777777,
            p_direccion     => 'Calle 777'
        );
        DBMS_OUTPUT.PUT_LINE('OK: PKG_Admin.CrearAseguradora ejecutado.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR en PKG_Admin.CrearAseguradora: ' || SQLERRM);
    END;

    -- 1.2 Crear Cliente (como Admin)
    BEGIN
        BD1000103871.PKG_Admin.CrearCliente(
            p_idCliente => 7701,
            p_idAgencia => 1,
            p_idAsesor  => 1,
            p_nombre    => 'Cliente Test Admin',
            p_correo    => 'cliente.admin@test.com',
            p_telefono  => 3007701111,
            p_direccion => 'Dir Admin 7701'
        );
        DBMS_OUTPUT.PUT_LINE('OK: PKG_Admin.CrearCliente ejecutado.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR en PKG_Admin.CrearCliente: ' || SQLERRM);
    END;

    -- 1.3 Crear Poliza (como Admin)
    BEGIN
        BD1000103871.PKG_Admin.CrearPoliza(
            p_idPoliza     => 7701,
            p_numeroPoliza => 770001,
            p_idCliente    => 7701,
            p_fechaInic    => SYSDATE,
            p_fechaFin     => SYSDATE + 365,
            p_prima        => 1500000,
            p_estado       => 'VIGENTE',
            p_renovable    => 'S',
            p_idSeguro     => 100 -- Debe existir
        );
        DBMS_OUTPUT.PUT_LINE('OK: PKG_Admin.CrearPoliza ejecutado.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR en PKG_Admin.CrearPoliza: ' || SQLERRM);
    END;

    -- ==========================================
    -- 2. PRUEBA DE ROL ASESOR (PKG_Asesor)
    -- ==========================================
    DBMS_OUTPUT.PUT_LINE('--- 2. Probando ROL ASESOR ---');

    -- 2.1 Crear Cliente (como Asesor)
    BEGIN
        BD1000103871.PKG_Asesor.CrearCliente(
            p_idCliente => 7702,
            p_idAgencia => 1,
            p_idAsesor  => 1,
            p_nombre    => 'Cliente Test Asesor',
            p_correo    => 'cliente.asesor@test.com',
            p_telefono  => 3007702222,
            p_direccion => 'Dir Asesor 7702'
        );
        DBMS_OUTPUT.PUT_LINE('OK: PKG_Asesor.CrearCliente ejecutado.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR en PKG_Asesor.CrearCliente: ' || SQLERRM);
    END;

    -- 2.2 Crear Poliza (como Asesor)
    BEGIN
        BD1000103871.PKG_Asesor.CrearPoliza(
            p_idPoliza     => 7702,
            p_numeroPoliza => 770002,
            p_idCliente    => 7702,
            p_fechaInic    => SYSDATE,
            p_fechaFin     => SYSDATE + 365,
            p_prima        => 1200000,
            p_estado       => 'VIGENTE',
            p_renovable    => 'S',
            p_idSeguro     => 100
        );
        DBMS_OUTPUT.PUT_LINE('OK: PKG_Asesor.CrearPoliza ejecutado.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR en PKG_Asesor.CrearPoliza: ' || SQLERRM);
    END;

    -- ==========================================
    -- 3. PRUEBA DE ROL CLIENTE (PKG_Cliente y SELECTs)
    -- ==========================================
    DBMS_OUTPUT.PUT_LINE('--- 3. Probando ROL CLIENTE ---');

    -- 3.1 Consultar Mis Polizas (PKG_Cliente)
    -- Nota: PKG_Cliente.ConsultarMisPolizas suele retornar un cursor. 
    -- Aquí solo probamos que podemos llamar al paquete o procedimiento.
    -- Si es una función que retorna cursor, la llamada simple podría fallar si no se captura.
    -- Asumiremos que existe un procedimiento o función. Si falla, ajustaremos.
    -- Revisando Seguridad.sql, se da GRANT EXECUTE ON PKG_Cliente.
    
    BEGIN
        -- Intento de SELECT directo a tablas permitidas
        SELECT COUNT(*) INTO v_count FROM BD1000103871.Polizas;
        DBMS_OUTPUT.PUT_LINE('OK: SELECT sobre Polizas exitoso (Count: ' || v_count || ').');
        
        SELECT COUNT(*) INTO v_count FROM BD1000103871.Pagos;
        DBMS_OUTPUT.PUT_LINE('OK: SELECT sobre Pagos exitoso.');
        
        SELECT COUNT(*) INTO v_count FROM BD1000103871.Reclamaciones;
        DBMS_OUTPUT.PUT_LINE('OK: SELECT sobre Reclamaciones exitoso.');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR en SELECTs de Cliente: ' || SQLERRM);
    END;

    -- ==========================================
    -- 4. LIMPIEZA (Opcional, para no dejar basura)
    -- ==========================================
    -- Nota: El usuario bd100... podría no tener DELETE directo sobre las tablas
    -- si solo tiene los roles definidos en Seguridad.sql (que solo dan EXECUTE y SELECT).
    -- Si falla el DELETE, es esperado y correcto según seguridad.
    
    DBMS_OUTPUT.PUT_LINE('--- 4. Intento de Limpieza Directa (Prueba de restricción) ---');
    BEGIN
        EXECUTE IMMEDIATE 'DELETE FROM BD1000103871.Polizas WHERE idPoliza IN (7701, 7702)';
        DBMS_OUTPUT.PUT_LINE('ADVERTENCIA: El usuario pudo borrar Polizas directamente (¿Tiene permisos extra?).');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('OK (Esperado): No se puede borrar directamente (ORA-01031 o similar).');
    END;

    DBMS_OUTPUT.PUT_LINE('=== Pruebas Finalizadas ===');
END;
/
