-- Identificador: Consultas de comprobación rápida
SELECT * FROM Clientes WHERE idCliente > 43 and idcliente < 60;
SELECT * FROM Polizas WHERE idPoliza IN (10,12);
SELECT * FROM Beneficiarios WHERE idPoliza = 10;
SELECT * FROM Pagos WHERE idPago IN (1,2);
