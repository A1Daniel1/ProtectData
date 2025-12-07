/*==========================================
  XSEGURIDAD: LIMPIEZA DE USUARIOS Y ROLES
 ==========================================*/

-- 1. Eliminar usuarios de prueba
--DROP USER ASESOR_APP  CASCADE;
--DROP USER CLIENTE_APP CASCADE;
--DROP USER ADMIN_APP   CASCADE;

-- 2. Eliminar roles de aplicación
DROP ROLE RL_ASESOR;
DROP ROLE RL_CLIENTE;
DROP ROLE RL_ADMIN;
DROP ROLE RL_ASEGURADORA;

-- 3. Eliminar paquetes

DROP PACKAGE PKG_Asesor;
DROP PACKAGE PKG_Cliente;
DROP PACKAGE PKG_Admin;


/*==========================================
  XSEGURIDAD: Limpieza de pruebas
 ==========================================*/

-- 1. Primero eliminar dependencias (por si se usaron en otras pruebas)

DELETE FROM Pagos
WHERE idCliente IN (9001, 8001)
   OR idPoliza  IN (9001, 8001);

DELETE FROM Reclamaciones
WHERE idPoliza IN (9001, 8001);

DELETE FROM Beneficiarios
WHERE idPoliza IN (9001, 8001);

DELETE FROM Coberturas
WHERE idPoliza IN (9001, 8001);

-- 2. Luego las pólizas de prueba

DELETE FROM Polizas
WHERE idPoliza IN (9001, 8001);

-- 3. Luego los clientes de prueba

DELETE FROM Clientes
WHERE idCliente IN (9001, 8001);

-- 4. Finalmente la aseguradora de prueba creada por ADMIN_APP

DELETE FROM Aseguradoras
WHERE idAseguradora = 800;

COMMIT;
