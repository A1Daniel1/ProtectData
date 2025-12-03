/* Eliminacion de Restricciones de Acciones */

ALTER TABLE Beneficiarios DROP CONSTRAINT FK_Beneficiarios_Polizas;
ALTER TABLE Polizas DROP CONSTRAINT FK_Polizas_Clientes;
ALTER TABLE Reclamaciones DROP CONSTRAINT FK_Reclamaciones_Polizas;
ALTER TABLE Pagos DROP CONSTRAINT FK_Pagos_Polizas;
ALTER TABLE Seguros DROP CONSTRAINT FK_Seguros_Aseguradoras;
ALTER TABLE Polizas DROP CONSTRAINT FK_Polizas_Seguros;
