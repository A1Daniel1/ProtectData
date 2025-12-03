-- Indice para buscar polizas por fecha de fin (Consultar polizas proximas a vencer)
CREATE INDEX IDX_Polizas_FechaFin ON Polizas(fechaFin);

-- Indice para buscar polizas por cliente (Consultar historial de polizas de un cliente)
CREATE INDEX IDX_Polizas_Cliente ON Polizas(idCliente);

-- Indice para buscar reclamos por estado (Consultar reclamos pendientes)
CREATE INDEX IDX_Reclamaciones_Estado ON Reclamaciones(estado);

-- Indice para buscar pagos por cliente (Consultar pagos atrasados/historial)
CREATE INDEX IDX_Pagos_Cliente ON Pagos(idCliente);

