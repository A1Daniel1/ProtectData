-- =================================================================================================
-- HISTORIA DE USO 1: JUAN (Cliente Nuevo - Seguro de Auto)
-- =================================================================================================

-- Juan es un nuevo cliente que desea adquirir un seguro para su automovil. Debido a que no se encuentra en la base de datos
-- es necesario que haga el registro en el cual debe ingresar su nombre, un correo, un telefono celular y su direccion de residencia.

EXECUTE PC_Clientes.AdicionarCliente(1001, 1, 1, 'Juan', 'juan@mail.com', 3001234567, 'Calle 100 #10-10');


-- Despues de registrarse, Juan procede a comprar una poliza "Auto Premium" (ID 200) para asegurar su vehiculo.
-- Se registra la poliza con una vigencia de un año.

EXECUTE PC_Polizas.AdicionarPoliza(1001, 8888, 1001, SYSDATE, SYSDATE+365, 1500000, 'VIGENTE', 'S', 200);


-- Juan quiere asegurarse de que su esposa este protegida tambien, por lo que la agrega como beneficiaria de la poliza
-- con un porcentaje del 100%.

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (501, 1001, 'Maria Perez', 'Esposa', 100);


-- Ademas, decide agregar una cobertura adicional de Responsabilidad Civil Extracontractual para tener mayor proteccion
-- en caso de daños a terceros. Osea algo asi como un seguro de terceros.

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (601, 1001, 'Responsabilidad Civil Extracontractual', 500000000);


-- Una vez configurada su poliza con beneficiarios y coberturas, Juan realiza el pago de la prima correspondiente
-- utilizando su tarjeta.

EXECUTE PC_Pagos.RegistrarPago(1001, 1001, 1001, SYSDATE, 1500000, 'TARJETA');


-- Un mes despues, lamentablemente Juan tiene un accidente leve en un parqueadero y presenta una reclamacion
-- a la aseguradora para cubrir los daños.

EXECUTE PC_Reclamos.RegistrarReclamo(1001, 1001, SYSDATE+30, 200000, 'EN REVISION', 'Choque leve en parqueadero');


-- Finalmente, Juan quiere consultar un resumen de los pagos que ha realizado a la agencia para llevar un control
-- de sus gastos.

CREATE OR REPLACE VIEW V_PAGOS_JUAN AS
SELECT c.nombre AS Cliente, p.idPoliza, pa.fechaPago, pa.monto
FROM Clientes c, Pagos pa, Polizas p
WHERE c.idCliente = pa.idCliente
AND pa.idPoliza = p.idPoliza
AND c.idCliente = 1001;

SELECT * FROM V_PAGOS_JUAN;


-- =================================================================================================
-- HISTORIA DE USO 2: CAMILO (Cliente Nuevo - Nuevo Seguro de Hogar)
-- =================================================================================================

-- Camilo quiere asegurar su casa, pero al acercarse a la agencia se da cuenta de que aun no tienen configurado
-- el tipo de seguro especifico que el necesita. Por lo tanto, primero se registra como cliente en la Agencia Sur.

EXECUTE PC_Clientes.AdicionarCliente(1002, 2, 2, 'Camilo', 'camilo@mail.com', 3109876543, 'Carrera 50 #5-5');


-- La agencia, para atender la necesidad de Camilo, crea un nuevo tipo de seguro llamado "Hogar Seguro"
-- que cubre incendios, terremotos y robos.

EXECUTE PC_Seguros.AdicionarSeguro(300, 'Hogar Seguro', 'Hogar', 'Seguro contra incendios, terremotos y robo', 1);


-- Ahora que el seguro existe, Camilo procede a comprar la poliza de Hogar para su vivienda.

EXECUTE PC_Polizas.AdicionarPoliza(1002, 9999, 1002, SYSDATE, SYSDATE+365, 800000, 'VIGENTE', 'S', 300);


-- Camilo desea proteger a su mascota, por lo que agrega a su gato Manchas como beneficiario de la poliza.

INSERT INTO Beneficiarios (idBeneficiario, idPoliza, nombre, relacion, porcentaje)
VALUES (502, 1002, 'Manchas', 'Gato', 100);


-- Para mayor tranquilidad, Camilo decide agregar coberturas especificas para Incendio y Terremoto,
-- asi como para Hurto Calificado.

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (602, 1002, 'Incendio y Terremoto', 200000000);

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (603, 1002, 'Hurto Calificado', 50000000);


-- Camilo quiere revisar todos los detalles de su poliza, incluyendo la informacion del seguro y las coberturas
-- que acaba de adquirir, para verificar que todo este correcto.

CREATE OR REPLACE VIEW V_DETALLE_POLIZA_CAMILO AS
SELECT c.nombre AS Cliente, s.nombre AS Seguro, p.numeroPoliza, p.fechaInic, p.fechaFin, cob.descripcionC, cob.montoMax
FROM Clientes c, Polizas p, Seguros s, Coberturas cob
WHERE c.idCliente = p.idCliente
AND p.idSeguro = s.idSeguro
AND p.idPoliza = cob.idPoliza
AND c.idCliente = 1002;

SELECT * FROM V_DETALLE_POLIZA_CAMILO;


-- Satisfecho con el servicio, Camilo decide renovar su poliza anticipadamente para extender su proteccion
-- por un año mas.

EXECUTE PC_Polizas.RenovarPoliza(1002, SYSDATE+730);