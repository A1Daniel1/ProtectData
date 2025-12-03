/* Eliminacion de Restricciones de Tupla */

ALTER TABLE Polizas DROP CONSTRAINT CK_Polizas_Fechas;
ALTER TABLE Pagos DROP CONSTRAINT CK_Pagos_Metodo_Monto;
ALTER TABLE Polizas DROP CONSTRAINT CK_Polizas_Prima;
ALTER TABLE Reclamaciones DROP CONSTRAINT CK_Reclamaciones_Monto;
ALTER TABLE Clientes DROP CONSTRAINT CK_Clientes_Correo;
ALTER TABLE Polizas DROP CONSTRAINT CK_Polizas_Estado;
ALTER TABLE Polizas DROP CONSTRAINT CK_Polizas_Renovable;
ALTER TABLE Seguros DROP CONSTRAINT CK_Seguros_Tipo;
