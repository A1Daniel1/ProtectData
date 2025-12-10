-- 2. Intento de insertar Poliza con duracion muy corta (< 6 meses)
INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
VALUES (3003, 777888999, 1001, SYSDATE, SYSDATE + 30, 800000, 'Activa', 'S');


-- 3. Intento de insertar Poliza con duracion muy larga (> 5 años)
INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
VALUES (3004, 000111222, 1001, SYSDATE, SYSDATE + 2000, 800000, 'Activa', 'S');


-- 4. Intento de insertar Reclamo para poliza Inactiva
-- Primero insertamos una poliza inactiva valida
INSERT INTO Polizas (idPoliza, numeroPoliza, idCliente, fechaInic, fechaFin, prima, estado, renovable)
VALUES (3005, 333444555, 1001, SYSDATE, SYSDATE + 365, 800000, 'Cancelada', 'N');


INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (4002, 3005, SYSDATE + 10, 200000, 'Pendiente', 'Prueba Trigger Fail Estado');


-- Nueva reclamación de 8,000: 3000 + 8000 = 11,000 > 10,000 → ERROR
INSERT INTO Reclamaciones (idReclamacion, idPoliza, fecha, monto, estado, descripcion)
VALUES (3, 1, SYSDATE, 8000, 'EN PROCESO', 'Reclamación que excede cobertura');

INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (12, 10, 'Cobertura adicional pequeña', 1000000);

--Aqui tenemos una cobertura muy mayor a la prima que se paga
-- Intento de agregar una cobertura adicional a la póliza 10
-- Esta inserción DEBE FALLAR por exceder el límite (ya está en 75M)
INSERT INTO Coberturas (idCobertura, idPoliza, descripcionC, montoMax)
VALUES (22, 10, 'Cobertura extra prueba', 1000000);




