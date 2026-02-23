
--SEGURIDAD PARA LA BASE DE DATOS

USE SUMAQ_MIKHUY_BD;
GO



-- 1. CONFIGURACIÓN PARA EL ROL VENTAS (MESEROS/CAJA)

-- Crear Login y Usuario para el Vendedor
CREATE LOGIN login_vendedor WITH PASSWORD = 'Venta123!', CHECK_POLICY = ON;
GO
CREATE USER user_vendedor FOR LOGIN login_vendedor;
GO

-- Crear Rol y Asignar Permisos según las tablas
CREATE ROLE RolVentas;
GO

-- Permisos sobre el menú y clientes
GRANT SELECT ON dbo.Plato TO RolVentas;
GRANT SELECT ON dbo.Cliente TO RolVentas;

-- Permisos para gestionar la atención
GRANT SELECT, INSERT, UPDATE ON dbo.Pedido TO RolVentas;
GRANT SELECT, INSERT ON dbo.DetallePedido TO RolVentas;
GRANT SELECT, INSERT ON dbo.Pago TO RolVentas;
GRANT SELECT ON dbo.Mesa TO RolVentas;

-- Denegar el borrado de platos (Seguridad)
DENY DELETE ON dbo.Plato TO RolVentas;

-- Asignar el usuario al rol
ALTER ROLE RolVentas ADD MEMBER user_vendedor;
GO




-- 2. CONFIGURACIÓN PARA EL ROL ADMINISTRACIÓN/PERSONAL

-- Crear Login y Usuario para Administración
CREATE LOGIN login_admin WITH PASSWORD = 'Admin123!', CHECK_POLICY = ON;
GO
CREATE USER user_admin FOR LOGIN login_admin;
GO

-- Crear Rol
CREATE ROLE RolAdminSumaq;
GO

-- Permisos sobre personal y platos (Control total de configuración)
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Empleado TO RolAdminSumaq;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Plato TO RolAdminSumaq;
GRANT SELECT ON dbo.EmpleadoPedido TO RolAdminSumaq;

-- Asignar el usuario al rol
ALTER ROLE RolAdminSumaq ADD MEMBER user_admin;
GO




-- 3. HERRAMIENTAS DE VERIFICACIÓN
-- Ver permisos detallados del usuario vendedor
SELECT dp.name AS Usuario,
       p.permission_name,
       p.state_desc,
       OBJECT_NAME(p.major_id) AS Tabla
FROM sys.database_principals dp
JOIN sys.database_permissions p ON dp.principal_id = p.grantee_principal_id
WHERE dp.name = 'user_vendedor';

-- Verificar si el usuario tiene permiso de borrar platos (0 = No, 1 = Sí)
SELECT HAS_PERMS_BY_NAME('dbo.Plato', 'OBJECT', 'DELETE');




-- 4. PRUEBA DE IMPERSONACIÓN
-- Cambiar el contexto al vendedor para probar
EXECUTE AS USER = 'user_vendedor';

-- Intentar ver los platos (Debería funcionar)
SELECT * FROM dbo.Plato;

-- Volver al usuario original (SA / Tu usuario)
REVERT;


