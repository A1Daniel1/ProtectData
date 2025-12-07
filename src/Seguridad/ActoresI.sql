CREATE OR REPLACE PACKAGE BODY PKG_Admin AS

    PROCEDURE CrearCliente(
        p_idCliente   IN NUMBER,
        p_idAgencia   IN NUMBER,
        p_idAsesor    IN NUMBER,
        p_nombre      IN VARCHAR2,
        p_correo      IN VARCHAR2,
        p_telefono    IN NUMBER,
        p_direccion   IN VARCHAR2
    ) IS
    BEGIN
        PC_Clientes.AdicionarCliente(
            p_idCliente, p_idAgencia, p_idAsesor,
            p_nombre, p_correo, p_telefono, p_direccion
        );
    END CrearCliente;

    PROCEDURE CrearPoliza(
        p_idPoliza     IN NUMBER,
        p_numeroPoliza IN NUMBER,
        p_idCliente    IN NUMBER,
        p_fechaInic    IN DATE,
        p_fechaFin     IN DATE,
        p_prima        IN NUMBER,
        p_estado       IN VARCHAR2,
        p_renovable    IN CHAR,
        p_idSeguro     IN NUMBER
    ) IS
    BEGIN
        PC_Polizas.AdicionarPoliza(
            p_idPoliza, p_numeroPoliza, p_idCliente,
            p_fechaInic, p_fechaFin, p_prima,
            p_estado, p_renovable, p_idSeguro
        );
    END CrearPoliza;

    PROCEDURE RenovarPoliza(
        p_idPoliza      IN NUMBER,
        p_nuevaFechaFin IN DATE
    ) IS
    BEGIN
        PC_Polizas.RenovarPoliza(p_idPoliza, p_nuevaFechaFin);
    END RenovarPoliza;

    PROCEDURE RegistrarPago(
        p_idPago     IN NUMBER,
        p_idCliente  IN NUMBER,
        p_idPoliza   IN NUMBER,
        p_fechaPago  IN DATE,
        p_monto      IN NUMBER,
        p_metodoPago IN VARCHAR2
    ) IS
    BEGIN
        PC_Pagos.RegistrarPago(
            p_idPago, p_idCliente, p_idPoliza,
            p_fechaPago, p_monto, p_metodoPago
        );
    END RegistrarPago;

    PROCEDURE RegistrarReclamo(
        p_idReclamacion IN NUMBER,
        p_idPoliza      IN NUMBER,
        p_fecha         IN DATE,
        p_monto         IN NUMBER,
        p_estado        IN VARCHAR2,
        p_descripcion   IN VARCHAR2
    ) IS
    BEGIN
        PC_Reclamos.RegistrarReclamo(
            p_idReclamacion, p_idPoliza, p_fecha,
            p_monto, p_estado, p_descripcion
        );
    END RegistrarReclamo;

    PROCEDURE CrearAseguradora(
        p_idAseguradora IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_telefono      IN NUMBER,
        p_nit           IN NUMBER,
        p_direccion     IN VARCHAR2
    ) IS
    BEGIN
        PC_Aseguradoras.AdicionarAseguradora(
            p_idAseguradora, p_nombre, p_telefono, p_nit, p_direccion
        );
    END CrearAseguradora;

    PROCEDURE CrearSeguro(
        p_idSeguro      IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_tipo          IN VARCHAR2,
        p_descripcion   IN VARCHAR2,
        p_idAseguradora IN NUMBER
    ) IS
    BEGIN
        PC_Seguros.AdicionarSeguro(
            p_idSeguro, p_nombre, p_tipo,
            p_descripcion, p_idAseguradora
        );
    END CrearSeguro;

END PKG_Admin;
/

CREATE OR REPLACE PACKAGE BODY PKG_Asesor AS

    PROCEDURE CrearCliente(
        p_idCliente   IN NUMBER,
        p_idAgencia   IN NUMBER,
        p_idAsesor    IN NUMBER,
        p_nombre      IN VARCHAR2,
        p_correo      IN VARCHAR2,
        p_telefono    IN NUMBER,
        p_direccion   IN VARCHAR2
    ) IS
    BEGIN
        PC_Clientes.AdicionarCliente(
            p_idCliente, p_idAgencia, p_idAsesor,
            p_nombre, p_correo, p_telefono, p_direccion
        );
    END CrearCliente;

    PROCEDURE CrearPoliza(
        p_idPoliza     IN NUMBER,
        p_numeroPoliza IN NUMBER,
        p_idCliente    IN NUMBER,
        p_fechaInic    IN DATE,
        p_fechaFin     IN DATE,
        p_prima        IN NUMBER,
        p_estado       IN VARCHAR2,
        p_renovable    IN CHAR,
        p_idSeguro     IN NUMBER
    ) IS
    BEGIN
        PC_Polizas.AdicionarPoliza(
            p_idPoliza, p_numeroPoliza, p_idCliente,
            p_fechaInic, p_fechaFin, p_prima,
            p_estado, p_renovable, p_idSeguro
        );
    END CrearPoliza;

    PROCEDURE RegistrarPago(
        p_idPago     IN NUMBER,
        p_idCliente  IN NUMBER,
        p_idPoliza   IN NUMBER,
        p_fechaPago  IN DATE,
        p_monto      IN NUMBER,
        p_metodoPago IN VARCHAR2
    ) IS
    BEGIN
        PC_Pagos.RegistrarPago(
            p_idPago, p_idCliente, p_idPoliza,
            p_fechaPago, p_monto, p_metodoPago
        );
    END RegistrarPago;

    PROCEDURE RegistrarReclamo(
        p_idReclamacion IN NUMBER,
        p_idPoliza      IN NUMBER,
        p_fecha         IN DATE,
        p_monto         IN NUMBER,
        p_estado        IN VARCHAR2,
        p_descripcion   IN VARCHAR2
    ) IS
    BEGIN
        PC_Reclamos.RegistrarReclamo(
            p_idReclamacion, p_idPoliza, p_fecha,
            p_monto, p_estado, p_descripcion
        );
    END RegistrarReclamo;

END PKG_Asesor;
/

CREATE OR REPLACE PACKAGE BODY PKG_Aseguradora AS

    PROCEDURE CrearAseguradora(
        p_idAseguradora IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_telefono      IN NUMBER,
        p_nit           IN NUMBER,
        p_direccion     IN VARCHAR2
    ) IS
    BEGIN
        PC_Aseguradoras.AdicionarAseguradora(
            p_idAseguradora, p_nombre, p_telefono, p_nit, p_direccion
        );
    END CrearAseguradora;

    PROCEDURE CrearSeguro(
        p_idSeguro      IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_tipo          IN VARCHAR2,
        p_descripcion   IN VARCHAR2,
        p_idAseguradora IN NUMBER
    ) IS
    BEGIN
        PC_Seguros.AdicionarSeguro(
            p_idSeguro, p_nombre, p_tipo,
            p_descripcion, p_idAseguradora
        );
    END CrearSeguro;

END PKG_Aseguradora;
/

CREATE OR REPLACE PACKAGE BODY PKG_Cliente AS

    FUNCTION ConsultarPolizas(
        p_idCliente IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT *
            FROM Polizas
            WHERE idCliente = p_idCliente;
        RETURN cur;
    END ConsultarPolizas;

    FUNCTION ConsultarPagos(
        p_idCliente IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT *
            FROM Pagos
            WHERE idCliente = p_idCliente;
        RETURN cur;
    END ConsultarPagos;

    FUNCTION ConsultarReclamos(
        p_idCliente IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
            SELECT r.*
            FROM Reclamaciones r
            JOIN Polizas p ON p.idPoliza = r.idPoliza
            WHERE p.idCliente = p_idCliente;
        RETURN cur;
    END ConsultarReclamos;

END PKG_Cliente;
/





