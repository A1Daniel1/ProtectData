--------------------------------------------------------------------------------
--- fallan restriccione de atributo
--------------------------------------------------------------------------------

--- CK_Polizas_Renovable

INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente, idSeguro)
VALUES (999999999, 9999999, DATE '2024-03-01', DATE '2025-03-05', 800000, 'Activa', 'X', 1, 2); 

--- CK_Polizas_Prima
INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente, idSeguro)
VALUES (999999999, 9999999, DATE '2024-03-01', DATE '2025-03-05', -2, 'Activa', 'S', 1, 2); 

--- CK_Polizas_Estado

INSERT INTO Polizas (idPoliza, numeroPoliza, fechaInic, fechaFin, prima, estado, renovable, idCliente, idSeguro)
VALUES (999999999, 9999999, DATE '2024-03-01', DATE '2025-03-05', -2, 'xd', 'S', 1, 2);

--- CK_Beneficiarios_Porcentaje

INSERT INTO beneficiarios (idbeneficiario, idpoliza, nombre, relacion, porcentaje)
VALUES (9999999, 999999, 'daniel', 'padre', 101);

--- CK_Reclamaciones_Monto

INSERT INTO reclamaciones (idreclamacion, idpoliza, fecha, monto, estado, descripcion)
VALUES (31231231, 312312, SYSDATE, -1000, 'OK', 'LKDSFJASDÑLKFJASÑKLFJ');

--- CK_Clientes_Correo

INSERT INTO clientes (idcliente, idagencia, idasesor, nombre, correo, telefono, direccion)
VALUES (12123123, 1312312, 312312, 'daniel', 'daniel@blablabla-com', 5555, 'no me la se');

--- CK_Seguros_Tipo

INSERT INTO seguros (idseguro, idaseguradora, nombre, tipo, descripcion)
VALUES (1212, 12121, 'Seguros shrek', 'nose', 'jdfñaskjfasdkjfaslkdfj');



--------------------------------------------------------------------------------
--- fallan llaves primarias
--------------------------------------------------------------------------------
INSERT INTO Aseguradoras (idAseguradora, nombre, telefono, nit, direccion) VALUES (1, 'Seguros Bolivar', 3000000001, 900000001, 'Calle 1 # 1-1');
INSERT INTO Agencias (idAgencia, nombre, direccion, idAseguradora) VALUES (1, 'Agencia 1', 'Carrera 1 # 1-1', 1);
INSERT INTO Seguros (idSeguro, nombre, tipo, descripcion, idAseguradora) VALUES (1, 'Seguro 1', 'Vehiculo', 'Descripcion del seguro 1', 1);
INSERT INTO Sucursales (idSucursal, idAgencia, nombre, direccion) VALUES (1, 6, 'Sucursal 1', 'Avenida 1 # 1-1');
INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo) VALUES (1, 6, 10, 1000001, 'Daniela Vargas', 3100000001, 'asesor1@email.com');
INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, correo, telefono, direccion) VALUES (1, 5, 5, 'Maria Sanchez', 'cliente1@email.com', 3200000001, 'Transversal 1 # 1-1');
INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro) VALUES (1, 10001, 39, TO_DATE('2025-12-25', 'YYYY-MM-DD'), TO_DATE('2029-08-31', 'YYYY-MM-DD'), 2089768.33, 'Activa', 'N', 5);
INSERT INTO Pagos (idPago, idCliente, idPoliza, fechaPago, monto, metodoPago) VALUES (1, 15, 147, TO_DATE('2025-12-22', 'YYYY-MM-DD'), 224996.97, 'EFECTIVO');
INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje) VALUES (1, 177, 'Isabella Diaz', 'Madre', 100);
INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax) VALUES (1, 36, 'Cobertura especial 1', 13111953.87);
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion) VALUES (1, 135, TO_DATE('2025-12-21', 'YYYY-MM-DD'), 445506.43, 'Pendiente', 'Reclamacion por evento 1');

--------------------------------------------------------------------------------
--- fallan llaves unicas
--------------------------------------------------------------------------------
--- PENDIENTEEEEE

INSERT INTO Asesores (idAsesor, idAgencia, idSucursal, cedula, nombre, telefono, correo) VALUES (51, 2, 19, 1000050, 'Laura Perez', 3100000050, 'asesor50@email.com');
INSERT INTO Clientes (idCliente, idAgencia, idAsesor, nombre, correo, telefono, direccion) VALUES (101, 6, 27, 'Diego Garcia', 'cliente100@email.com', 3200000100, 'Transversal 100 # 100-100');
INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable, idSeguro) VALUES (201, 10200, 58, TO_DATE('2025-12-10', 'YYYY-MM-DD'), TO_DATE('2030-03-29', 'YYYY-MM-DD'), 4749235.29, 'Cancelada', 'N', 2);

--------------------------------------------------------------------------------
--- fallan FK
--------------------------------------------------------------------------------

--- que salga error de FK

--------------------------------------------------------------------------------
--- tipos de dato
--------------------------------------------------------------------------------