ALTER TABLE Agencias ADD CONSTRAINT PK_Agencias PRIMARY KEY (idAgencia);
ALTER TABLE Sucursales ADD CONSTRAINT PK_Sucursales PRIMARY KEY (idSucursal);
ALTER TABLE Asesores ADD CONSTRAINT PK_Asesores PRIMARY KEY (idAsesor);
ALTER TABLE Clientes ADD CONSTRAINT PK_Clientes PRIMARY KEY (idCliente);
ALTER TABLE Polizas ADD CONSTRAINT PK_Polizas PRIMARY KEY (idPoliza);
ALTER TABLE Pagos ADD CONSTRAINT PK_Pagos PRIMARY KEY (idPago);
ALTER TABLE Beneficiarios ADD CONSTRAINT PK_Beneficiarios PRIMARY KEY (idBeneficiario);
ALTER TABLE Coberturas ADD CONSTRAINT PK_Coberturas PRIMARY KEY (idCobertura);
ALTER TABLE Reclamaciones ADD CONSTRAINT PK_Reclamaciones PRIMARY KEY (idReclamacion);

ALTER TABLE Aseguradoras ADD CONSTRAINT PK_Aseguradoras PRIMARY KEY (idAseguradora);
ALTER TABLE Seguros ADD CONSTRAINT PK_Seguros PRIMARY KEY (idSeguro);
