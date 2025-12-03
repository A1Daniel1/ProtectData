/* Disparadores con Logica de Negocio */

-- Trigger 1: Validar que la fecha de fin de poliza sea mayor a la de inicio
CREATE OR REPLACE TRIGGER TRG_ValidarVigenciaPoliza
BEFORE INSERT OR UPDATE ON Polizas
FOR EACH ROW
BEGIN
    -- Validar que la fecha de inicio no sea anterior a ayer (permitir margen de error de 1 dia)
    IF :NEW.fechaInic < TRUNC(SYSDATE) - 1 THEN
        RAISE_APPLICATION_ERROR(-20011, 'La fecha de inicio de la poliza no puede ser anterior a la fecha actual.');
    END IF;

    -- Validar que la duracion de la poliza sea entre 6 meses (aprox 180 dias) y 5 años (aprox 1825 dias)
    IF (:NEW.fechaFin - :NEW.fechaInic) < 180 OR (:NEW.fechaFin - :NEW.fechaInic) > 1825 THEN
        RAISE_APPLICATION_ERROR(-20015, 'La vigencia de la poliza debe ser entre 6 meses y 5 años.');
    END IF;
    
    -- Validar consistencia basica (Fin > Inicio) - redundante con lo anterior pero buena practica
    IF :NEW.fechaFin <= :NEW.fechaInic THEN
        RAISE_APPLICATION_ERROR(-20016, 'La fecha de fin debe ser posterior a la de inicio.');
    END IF;
END;
/

-- Trigger 2: Validar que solo se puedan registrar reclamos a polizas Activas
-- y que la fecha del reclamo este dentro de la vigencia de la poliza
CREATE OR REPLACE TRIGGER TRG_ValidarReclamoActivo
BEFORE INSERT ON Reclamaciones
FOR EACH ROW
DECLARE
    v_estadoPoliza Polizas.estado%TYPE;
    v_fechaInic Polizas.fechaInic%TYPE;
    v_fechaFin Polizas.fechaFin%TYPE;
BEGIN
    SELECT estado, fechaInic, fechaFin 
    INTO v_estadoPoliza, v_fechaInic, v_fechaFin
    FROM Polizas
    WHERE idPoliza = :NEW.idPoliza;

    IF v_estadoPoliza != 'Activa' THEN
        RAISE_APPLICATION_ERROR(-20012, 'No se pueden registrar reclamos para polizas que no esten Activas.');
    END IF;

    IF :NEW.fecha < v_fechaInic OR :NEW.fecha > v_fechaFin THEN
        RAISE_APPLICATION_ERROR(-20013, 'La fecha del reclamo debe estar dentro de la vigencia de la poliza.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20014, 'La poliza asociada al reclamo no existe.');
END;
/

--Trigger 3 Este trigger valida que el valor de la suma de todas las reclamaciones
--no vaya a superar la suma de los montos maximos de las coberturas  

CREATE OR REPLACE TRIGGER trg_reclamaciones_cobertura_acumulada
BEFORE INSERT OR UPDATE ON Reclamaciones
FOR EACH ROW
DECLARE
    v_total_cobertura   NUMBER(10,2);
    v_total_reclamado   NUMBER(10,2);
BEGIN
    
    SELECT NVL(SUM(montoMax), 0)
    INTO   v_total_cobertura
    FROM   Coberturas
    WHERE  idPoliza = :NEW.idPoliza;

    IF v_total_cobertura = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20120,
            'La póliza no tiene coberturas registradas; no se puede registrar la reclamación.'
        );
    END IF;

   
    SELECT NVL(SUM(monto), 0)
    INTO   v_total_reclamado
    FROM   Reclamaciones
    WHERE  idPoliza = :NEW.idPoliza
      AND  idReclamacion <> NVL(:OLD.idReclamacion, -1);

  
    v_total_reclamado := v_total_reclamado + NVL(:NEW.monto, 0);

    IF v_total_reclamado > v_total_cobertura THEN
        RAISE_APPLICATION_ERROR(
            -20121,
            'La suma acumulada de reclamaciones supera la cobertura total de la póliza.'
        );
    END IF;
END;
/

--Trigger 4 La suma de coberturas no puede tener un valor absurdo con respecto a la prima

CREATE OR REPLACE TRIGGER trg_coberturas_vs_prima
BEFORE INSERT OR UPDATE ON Coberturas
FOR EACH ROW
DECLARE
    v_prima           Polizas.prima%TYPE;
    v_suma_coberturas NUMBER(10,2);
    v_factor_max      CONSTANT NUMBER := 20; 
BEGIN
   
    SELECT prima
    INTO   v_prima
    FROM   Polizas
    WHERE  idPoliza = :NEW.idPoliza;

   
    SELECT NVL(SUM(montoMax), 0)
    INTO   v_suma_coberturas
    FROM   Coberturas
    WHERE  idPoliza = :NEW.idPoliza
      AND  idCobertura <> NVL(:OLD.idCobertura, -1);

    
    v_suma_coberturas := v_suma_coberturas + NVL(:NEW.montoMax, 0);

   
    IF v_suma_coberturas > (v_prima * v_factor_max) THEN
        RAISE_APPLICATION_ERROR(
            -20300,
            'La suma de coberturas excede el máximo permitido respecto a la prima de la póliza.'
        );
    END IF;
END;
/



