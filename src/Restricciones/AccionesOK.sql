-- Prueba ON DELETE CASCADE (Beneficiarios)
-- Borrar Poliza 10, deberia borrar Beneficiarios 1 y 2
DELETE FROM Polizas WHERE idPoliza = 10;
-- Verificar:
SELECT * FROM Beneficiarios WHERE idPoliza = 10; -- Deberia ser vacio

-- Prueba ON DELETE SET NULL (Polizas)
-- Borrar Cliente 2, deberia poner NULL en Poliza 12.idCliente
DELETE FROM Clientes WHERE idCliente = 2;
-- Verificar:
SELECT * FROM Polizas WHERE idPoliza = 12; -- idCliente deberia ser NULL
