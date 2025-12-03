-- Vista para el Agente de Seguros: Polizas proximas a vencer (en los proximos 30 dias)
CREATE OR REPLACE VIEW V_PolizasProximasVencer AS
SELECT 
    p.idPoliza,
    p.numeroPoliza,
    c.nombre AS NombreCliente,
    p.fechaFin,
    p.prima,
    p.estado
FROM Polizas p
JOIN Clientes c ON p.idCliente = c.idCliente
WHERE p.fechaFin BETWEEN SYSDATE AND SYSDATE + 30
  AND p.estado = 'Activa';

-- Vista para el Agente de Seguros: Historial de polizas de clientes
CREATE OR REPLACE VIEW V_HistorialPolizasCliente AS
SELECT 
    c.idCliente,
    c.nombre AS NombreCliente,
    p.idPoliza,
    p.numeroPoliza,
    p.fechaInic,
    p.fechaFin,
    p.estado
FROM Clientes c
JOIN Polizas p ON c.idCliente = p.idCliente;

-- Vista para el Asistente Administrativo: Reclamos pendientes
CREATE OR REPLACE VIEW V_ReclamosPendientes AS
SELECT 
    r.idReclamacion,
    p.numeroPoliza,
    c.nombre AS NombreCliente,
    r.fecha,
    r.monto,
    r.descripcion
FROM Reclamaciones r
JOIN Polizas p ON r.idPoliza = p.idPoliza
JOIN Clientes c ON p.idCliente = c.idCliente
WHERE r.estado = 'Pendiente';

-- Vista para el Agente de Cobranza: Pagos realizados (para analisis de cobranza)
CREATE OR REPLACE VIEW V_PagosRealizados AS
SELECT 
    pg.idPago,
    c.nombre AS NombreCliente,
    p.numeroPoliza,
    pg.fechaPago,
    pg.monto,
    pg.metodoPago
FROM Pagos pg
JOIN Clientes c ON pg.idCliente = c.idCliente
JOIN Polizas p ON pg.idPoliza = p.idPoliza;

-- Vista para el Cliente: Mis Polizas
CREATE OR REPLACE VIEW V_DetallePolizas AS
SELECT 
    p.idPoliza,
    p.numeroPoliza,
    p.fechaInic,
    p.fechaFin,
    p.prima,
    p.estado,
    c.nombre AS Asegurado,
    s.nombre AS NombreSeguro,
    a.nombre AS NombreAseguradora
FROM Polizas p
JOIN Clientes c ON p.idCliente = c.idCliente
JOIN Seguros s ON p.idSeguro = s.idSeguro
JOIN Aseguradoras a ON s.idAseguradora = a.idAseguradora;
