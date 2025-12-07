--===========================
  --ACTOR: Administrador
--===========================

CREATE OR REPLACE PACKAGE PKG_Admin AS

    PROCEDURE CrearCliente(
        p_idCliente   IN NUMBER,
        p_idAgencia   IN NUMBER,
        p_idAsesor    IN NUMBER,
        p_nombre      IN VARCHAR2,
        p_correo      IN VARCHAR2,
        p_telefono    IN NUMBER,
        p_direccion   IN VARCHAR2
    );

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
    );

    
    PROCEDURE RenovarPoliza(
        p_idPoliza      IN NUMBER,
        p_nuevaFechaFin IN DATE
    );

    PROCEDURE RegistrarPago(
        p_idPago     IN NUMBER,
        p_idCliente  IN NUMBER,
        p_idPoliza   IN NUMBER,
        p_fechaPago  IN DATE,
        p_monto      IN NUMBER,
        p_metodoPago IN VARCHAR2
    );

    PROCEDURE RegistrarReclamo(
        p_idReclamacion IN NUMBER,
        p_idPoliza      IN NUMBER,
        p_fecha         IN DATE,
        p_monto         IN NUMBER,
        p_estado        IN VARCHAR2,
        p_descripcion   IN VARCHAR2
    );

    PROCEDURE CrearAseguradora(
        p_idAseguradora IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_telefono      IN NUMBER,
        p_nit           IN NUMBER,
        p_direccion     IN VARCHAR2
    );

    PROCEDURE CrearSeguro(
        p_idSeguro      IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_tipo          IN VARCHAR2,
        p_descripcion   IN VARCHAR2,
        p_idAseguradora IN NUMBER
    );
END PKG_Admin;
/

/*===========================
  ACTOR: Asesor 
 ===========================*/

CREATE OR REPLACE PACKAGE PKG_Asesor AS
    PROCEDURE CrearCliente(
        p_idCliente   IN NUMBER,
        p_idAgencia   IN NUMBER,
        p_idAsesor    IN NUMBER,
        p_nombre      IN VARCHAR2,
        p_correo      IN VARCHAR2,
        p_telefono    IN NUMBER,
        p_direccion   IN VARCHAR2
    );

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
    );

    PROCEDURE RegistrarPago(
        p_idPago     IN NUMBER,
        p_idCliente  IN NUMBER,
        p_idPoliza   IN NUMBER,
        p_fechaPago  IN DATE,
        p_monto      IN NUMBER,
        p_metodoPago IN VARCHAR2
    );

    PROCEDURE RegistrarReclamo(
        p_idReclamacion IN NUMBER,
        p_idPoliza      IN NUMBER,
        p_fecha         IN DATE,
        p_monto         IN NUMBER,
        p_estado        IN VARCHAR2,
        p_descripcion   IN VARCHAR2
    );
END PKG_Asesor;
/

/*===========================
  Actor: Cliente 
 ===========================*/
CREATE OR REPLACE PACKAGE PKG_Cliente AS
    FUNCTION ConsultarPolizas(
        p_idCliente IN NUMBER
    ) RETURN SYS_REFCURSOR;

    FUNCTION ConsultarPagos(
        p_idCliente IN NUMBER
    ) RETURN SYS_REFCURSOR;

    FUNCTION ConsultarReclamos(
        p_idCliente IN NUMBER
    ) RETURN SYS_REFCURSOR;
END PKG_Cliente;
/

/*==============================
  Actor: Aseguradora 
 ==============================*/
CREATE OR REPLACE PACKAGE PKG_Aseguradora AS
    PROCEDURE CrearAseguradora(
        p_idAseguradora IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_telefono      IN NUMBER,
        p_nit           IN NUMBER,
        p_direccion     IN VARCHAR2
    );

    PROCEDURE CrearSeguro(
        p_idSeguro      IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_tipo          IN VARCHAR2,
        p_descripcion   IN VARCHAR2,
        p_idAseguradora IN NUMBER
    );
END PKG_Aseguradora;
/


