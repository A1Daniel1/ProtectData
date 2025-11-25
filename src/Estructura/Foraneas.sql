ALTER TABLE Sucursales ADD CONSTRAINT FK_Sucursales_Agencias FOREIGN KEY (idAgencia) REFERENCES Agencias(idAgencia);

ALTER TABLE Asesores ADD CONSTRAINT FK_Asesores_Agencias FOREIGN KEY (idAgencia) REFERENCES Agencias(idAgencia);
ALTER TABLE Asesores ADD CONSTRAINT FK_Asesores_Sucursales FOREIGN KEY (idSucursal) REFERENCES Sucursales(idSucursal);

ALTER TABLE Clientes ADD CONSTRAINT FK_Clientes_Agencias FOREIGN KEY (idAgencia) REFERENCES Agencias(idAgencia);
ALTER TABLE Clientes ADD CONSTRAINT FK_Clientes_Asesores FOREIGN KEY (idAsesor) REFERENCES Asesores(idAsesor);

ALTER TABLE Polizas ADD CONSTRAINT FK_Polizas_Clientes FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente);

ALTER TABLE Pagos ADD CONSTRAINT FK_Pagos_Clientes FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente);
ALTER TABLE Pagos ADD CONSTRAINT FK_Pagos_Polizas FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza);

ALTER TABLE Beneficiarios ADD CONSTRAINT FK_Beneficiarios_Polizas FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza);

ALTER TABLE Coberturas ADD CONSTRAINT FK_Coberturas_Polizas FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza);

ALTER TABLE Reclamaciones ADD CONSTRAINT FK_Reclamaciones_Polizas FOREIGN KEY (idPoliza) REFERENCES Polizas(idPoliza);
