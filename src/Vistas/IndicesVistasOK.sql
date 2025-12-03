-- Consultar polizas proximas a vencer
SELECT * FROM V_PolizasProximasVencer;

-- Consultar historial de un cliente especifico (ejemplo id 1)
SELECT * FROM V_HistorialPolizasCliente WHERE idCliente = 1;

-- Consultar reclamos pendientes
SELECT * FROM V_ReclamosPendientes;

-- Consultar pagos realizados
SELECT * FROM V_PagosRealizados ORDER BY fechaPago DESC;

-- Consultar detalle de polizas
SELECT * FROM V_DetallePolizas;
