ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Renovable CHECK (renovable IN ('S','N'));

ALTER TABLE Beneficiarios
ADD CONSTRAINT CK_Beneficiarios_Porcentaje CHECK (porcentaje BETWEEN 0 AND 100);
