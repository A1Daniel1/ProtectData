-- Acciones de Referencia
-- Drop original FKs (defined in Foraneas.sql) and recreate with actions

-- Beneficiarios -> Polizas (ON DELETE CASCADE)
ALTER TABLE Beneficiarios DROP CONSTRAINT FK_Beneficiarios_Polizas;

ALTER TABLE Beneficiarios
ADD CONSTRAINT FK_Beneficiarios_Polizas
FOREIGN KEY (idPoliza)
REFERENCES Polizas(idPoliza)
ON DELETE CASCADE;

-- Polizas -> Clientes (ON DELETE SET NULL)
ALTER TABLE Polizas DROP CONSTRAINT FK_Polizas_Clientes;

ALTER TABLE Polizas
ADD CONSTRAINT FK_Polizas_Clientes
FOREIGN KEY (idCliente)
REFERENCES Clientes(idCliente)
ON DELETE SET NULL;
