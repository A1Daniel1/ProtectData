-- Restricciones de Tupla (Multi-atributo)
ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Fechas
CHECK (fechaFin > fechaInic);

ALTER TABLE Pagos
ADD CONSTRAINT CK_Pagos_Metodo_Monto
CHECK (
    (metodoPago = 'EFECTIVO' AND monto <= 5000000)
    OR
    (metodoPago IN ('TRANSFERENCIA', 'TARJETA') AND monto > 0)
);

ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Prima
CHECK (prima > 0);

ALTER TABLE Reclamaciones
ADD CONSTRAINT CK_Reclamaciones_Monto
CHECK (monto > 0);

ALTER TABLE Clientes
ADD CONSTRAINT CK_Clientes_Correo
CHECK (correo LIKE '%_@__%.__%');

-- CORRECCIÓN: Se añade 'VIGENTE' a la lista de estados permitidos
ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Estado
CHECK (estado IN ('Activa', 'Vencida', 'Cancelada', 'Renovada', 'VIGENTE'));

ALTER TABLE Polizas
ADD CONSTRAINT CK_Polizas_Renovable
CHECK (renovable IN ('S', 'N'));

ALTER TABLE Seguros
ADD CONSTRAINT CK_Seguros_Tipo
CHECK (tipo IN ('Vida', 'Salud', 'Hogar', 'Vehiculo', 'Empresarial'));