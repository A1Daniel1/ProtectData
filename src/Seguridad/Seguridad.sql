

/*==========================================
  SEGURIDAD: Creación de roles
 ==========================================*/

CREATE ROLE RL_ADMIN;
CREATE ROLE RL_ASESOR;
CREATE ROLE RL_ASEGURADORA;
CREATE ROLE RL_CLIENTE;

/*==========================================
  SEGURIDAD: Permisos (GRANT EXECUTE)
 ==========================================*/

-- Admin: puede usar todos los paquetes de actores
GRANT EXECUTE ON PKG_Admin       TO RL_ADMIN;
GRANT EXECUTE ON PKG_Asesor      TO RL_ADMIN;
GRANT EXECUTE ON PKG_Aseguradora TO RL_ADMIN;
GRANT EXECUTE ON PKG_Cliente     TO RL_ADMIN;
GRANT EXECUTE ON PKG_Auditor     TO RL_ADMIN;

-- Asesor: operaciones comerciales
GRANT EXECUTE ON PKG_Asesor      TO RL_ASESOR;

-- Aseguradora: gestión corporativa
GRANT EXECUTE ON PKG_Aseguradora TO RL_ASEGURADORA;

-- Cliente: consulta
GRANT EXECUTE ON PKG_Cliente     TO RL_CLIENTE;

/* Consulta de tablas en específico para el cliente */

GRANT SELECT ON Polizas        TO RL_CLIENTE;
GRANT SELECT ON Pagos          TO RL_CLIENTE;
GRANT SELECT ON Reclamaciones  TO RL_CLIENTE;

/*===========================
  USUARIOS DE LA APLICACIÓN
 ===========================*/

/*
CREATE USER ASESOR_JUAN IDENTIFIED BY juanL40;

CREATE USER ASESOR_LAURA IDENTIFIED BY lauraG10;

CREATE USER ADMIN_GENERAL IDENTIFIED BY admin123;

CREATE USER ASESOR_ELIAS IDENTIFIED BY elias_asesor79;

Create USER CL_SANTIAGO IDENTIFIED BY santitorres105;

-- Asignación de roles

GRANT RL_ASESOR TO ASESOR_JUAN;

GRANT RL_ASESOR TO ASESOR_LAURA;

GRANT RL_ADMIN TO ADMIN_GENERAL;

GRANT RL_CLIENTE TO CL_SANTIAGO;

GRANT RL_ASESOR TO ASESOR_ELIAS;
*/

-- Asignar todos los roles al usuario de pruebas
GRANT RL_ADMIN TO bd1000105317;
GRANT RL_ASESOR TO bd1000105317;
GRANT RL_ASEGURADORA TO bd1000105317;
GRANT RL_CLIENTE TO bd1000105317;


