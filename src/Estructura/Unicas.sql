ALTER TABLE Asesores ADD CONSTRAINT UK_Asesores_Cedula UNIQUE (cedula);
ALTER TABLE Clientes ADD CONSTRAINT UK_Clientes_Correo UNIQUE (correo);
ALTER TABLE Polizas ADD CONSTRAINT UK_Polizas_Numero UNIQUE (numeroPoliza);
