/* Implementacion de Paquetes de Componentes (Cuerpo) */

-- Cuerpo Paquete Gestion de Clientes
CREATE OR REPLACE PACKAGE BODY PC_Clientes AS
    PROCEDURE AdicionarCliente(
        p_idCliente IN NUMBER,
        p_idAgencia IN NUMBER,
        p_idAsesor IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_telefono IN NUMBER,
        p_direccion IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, correo, telefono, direccion)
        VALUES (p_idCliente, p_idAgencia, p_idAsesor, p_nombre, p_correo, p_telefono, p_direccion);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20001, 'El cliente ya existe.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error al registrar cliente: ' || SQLERRM);
    END AdicionarCliente;
END PC_Clientes;
/

-- Cuerpo Paquete Gestion de Polizas
CREATE OR REPLACE PACKAGE BODY PC_Polizas AS
    PROCEDURE AdicionarPoliza(
        p_idPoliza IN NUMBER,
        p_numeroPoliza IN NUMBER,
        p_idCliente IN NUMBER,
        p_fechaInic IN DATE,
        p_fechaFin IN DATE,
        p_prima IN NUMBER,
        p_estado IN VARCHAR2,
        p_renovable IN CHAR,
        p_idSeguro IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro)
        VALUES (p_idPoliza, p_numeroPoliza, p_idCliente, p_fechaInic, p_fechaFin, p_prima, p_estado, p_renovable, p_idSeguro);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20003, 'La poliza ya existe.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Error al registrar poliza: ' || SQLERRM);
    END AdicionarPoliza;

    PROCEDURE RenovarPoliza(
        p_idPoliza IN NUMBER,
        p_nuevaFechaFin IN DATE
    ) IS
    BEGIN
        UPDATE Polizas
        SET fechaFin = p_nuevaFechaFin, estado = 'Renovada'
        WHERE idPoliza = p_idPoliza;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Poliza no encontrada para renovacion.');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error al renovar poliza: ' || SQLERRM);
    END RenovarPoliza;
END PC_Polizas;
/

-- Cuerpo Paquete Gestion de Reclamos
CREATE OR REPLACE PACKAGE BODY PC_Reclamos AS
    PROCEDURE RegistrarReclamo(
        p_idReclamacion IN NUMBER,
        p_idPoliza IN NUMBER,
        p_fecha IN DATE,
        p_monto IN NUMBER,
        p_estado IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
        VALUES (p_idReclamacion, p_idPoliza, p_fecha, p_monto, p_estado, p_descripcion);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20007, 'El reclamo ya existe.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20008, 'Error al registrar reclamo: ' || SQLERRM);
    END RegistrarReclamo;
END PC_Reclamos;
/

-- Cuerpo Paquete Gestion de Pagos
CREATE OR REPLACE PACKAGE BODY PC_Pagos AS
    PROCEDURE RegistrarPago(
        p_idPago IN NUMBER,
        p_idCliente IN NUMBER,
        p_idPoliza IN NUMBER,
        p_fechaPago IN DATE,
        p_monto IN NUMBER,
        p_metodoPago IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago)
        VALUES (p_idPago, p_idCliente, p_idPoliza, p_fechaPago, p_monto, p_metodoPago);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20009, 'El pago ya existe.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error al registrar pago: ' || SQLERRM);
    END RegistrarPago;
END PC_Pagos;
/

-- Cuerpo Paquete Gestion de Aseguradoras
CREATE OR REPLACE PACKAGE BODY PC_Aseguradoras AS
    PROCEDURE AdicionarAseguradora(
        p_idAseguradora IN NUMBER,
        p_nombre IN VARCHAR2,
        p_telefono IN NUMBER,
        p_nit IN NUMBER,
        p_direccion IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Aseguradoras (idAseguradora, nombre, telefono, nit, direccion)
        VALUES (p_idAseguradora, p_nombre, p_telefono, p_nit, p_direccion);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20017, 'La aseguradora ya existe.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20018, 'Error al registrar aseguradora: ' || SQLERRM);
    END AdicionarAseguradora;
END PC_Aseguradoras;
/

-- Cuerpo Paquete Gestion de Seguros
CREATE OR REPLACE PACKAGE BODY PC_Seguros AS
    PROCEDURE AdicionarSeguro(
        p_idSeguro IN NUMBER,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_descripcion IN VARCHAR2,
        p_idAseguradora IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora)
        VALUES (p_idSeguro, p_nombre, p_tipo, p_descripcion, p_idAseguradora);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20019, 'El seguro ya existe.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20020, 'Error al registrar seguro: ' || SQLERRM);
    END AdicionarSeguro;
END PC_Seguros;
/
