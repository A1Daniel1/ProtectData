/* Especificacion de Paquetes de Componentes */

-- Paquete para Gestion de Clientes
CREATE OR REPLACE PACKAGE PC_Clientes AS
    PROCEDURE AdicionarCliente(
        p_idCliente IN NUMBER,
        p_idAgencia IN NUMBER,
        p_idAsesor IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_telefono IN NUMBER,
        p_direccion IN VARCHAR2
    );
    -- (Modificar, Eliminar, Consultar pendiente)
END PC_Clientes;
/

-- Paquete para Gestion de Polizas
CREATE OR REPLACE PACKAGE PC_Polizas AS
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
    );
    PROCEDURE RenovarPoliza(
        p_idPoliza IN NUMBER,
        p_nuevaFechaFin IN DATE
    );
END PC_Polizas;
/

-- Paquete para Gestion de Reclamos
CREATE OR REPLACE PACKAGE PC_Reclamos AS
    PROCEDURE RegistrarReclamo(
        p_idReclamacion IN NUMBER,
        p_idPoliza IN NUMBER,
        p_fecha IN DATE,
        p_monto IN NUMBER,
        p_estado IN VARCHAR2,
        p_descripcion IN VARCHAR2
    );
END PC_Reclamos;
/

-- Paquete para Gestion de Pagos (Cobranza)
CREATE OR REPLACE PACKAGE PC_Pagos AS
    PROCEDURE RegistrarPago(
        p_idPago IN NUMBER,
        p_idCliente IN NUMBER,
        p_idPoliza IN NUMBER,
        p_fechaPago IN DATE,
        p_monto IN NUMBER,
        p_metodoPago IN VARCHAR2
    );
END PC_Pagos;
/

-- Paquete para Gestion de Aseguradoras
CREATE OR REPLACE PACKAGE PC_Aseguradoras AS
    PROCEDURE AdicionarAseguradora(
        p_idAseguradora IN NUMBER,
        p_nombre IN VARCHAR2,
        p_telefono IN NUMBER,
        p_nit IN NUMBER,
        p_direccion IN VARCHAR2
    );
END PC_Aseguradoras;
/

-- Paquete para Gestion de Seguros
CREATE OR REPLACE PACKAGE PC_Seguros AS
    PROCEDURE AdicionarSeguro(
        p_idSeguro IN NUMBER,
        p_nombre IN VARCHAR2,
        p_tipo IN VARCHAR2,
        p_descripcion IN VARCHAR2,
        p_idAseguradora IN NUMBER
    );
END PC_Seguros;
/
