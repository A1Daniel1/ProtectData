--- Restricciones de atributo 
--- Un solo atributo

ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Renovable CHECK (renovable IN ('S','N'));

ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Prima
CHECK (prima > 0);

ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Estado
CHECK (estado IN ('Activa', 'Vencida', 'Cancelada', 'Renovada', 'VIGENTE'));

ALTER TABLE Beneficiarios
ADD CONSTRAINT CK_Beneficiarios_Porcentaje CHECK (porcentaje BETWEEN 0 AND 100);

ALTER TABLE Reclamaciones
ADD CONSTRAINT CK_Reclamaciones_Monto
CHECK (monto > 0);

ALTER TABLE Clientes
ADD CONSTRAINT CK_Clientes_Correo
CHECK (correo LIKE '%_@__%.__%');

ALTER TABLE Seguros
ADD CONSTRAINT CK_Seguros_Tipo
CHECK (tipo IN ('Vida', 'Salud', 'Hogar', 'Vehiculo', 'Empresarial'));