    
USE SUMAQ_MIKHUY_BD

--Procedimiento Almacenado

--1)
GO
CREATE PROCEDURE sp_PedidosPorFechaYEmpleado
    @fechaInicio DATETIME,
    @fechaFin DATETIME,
    @idEmpleado INT
AS
BEGIN
    SELECT 
        P.idPedido,
        C.nombre AS Cliente,
        E.nombre AS Empleado,
        M.numero AS Mesa,
        P.fechaPedido,
        P.total
    FROM Pedido P
    INNER JOIN Cliente C ON P.idCliente = C.idCliente
    INNER JOIN Mesa M ON P.idMesa = M.idMesa
    INNER JOIN EmpleadoPedido EP ON P.idPedido = EP.idPedido
    INNER JOIN Empleado E ON EP.idEmpleado = E.idEmpleado
    WHERE 
        P.fechaPedido BETWEEN @fechaInicio AND @fechaFin
        AND E.idEmpleado = @idEmpleado
    ORDER BY P.fechaPedido ASC;
END;

EXEC sp_PedidosPorFechaYEmpleado 
    @fechaInicio = '2026-02-10',
    @fechaFin = '2026-02-11',
    @idEmpleado = 1;



--2)
GO
CREATE PROCEDURE sp_RegistrarPedido
    @idCliente INT,
    @idMesa INT,
    @total DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Pedido (idCliente, idMesa, fechaPedido, total)
    VALUES (@idCliente, @idMesa, GETDATE(), @total);
END;


exec sp_RegistrarPedido @idCliente = 1, @idMesa = 2, @total = 50.00;
EXEC sp_RegistrarPedido 1, 2, 45.00;
SeLECT * FROM Pedido;



--3)Registrar Cliente
GO
CREATE PROCEDURE sp_RegistrarCliente
    @nombre VARCHAR(100),
    @telefono VARCHAR(20),
    @direccion VARCHAR(200)
AS
BEGIN
    INSERT INTO Cliente(nombre, telefono, direccion)
    VALUES(@nombre, @telefono, @direccion);
END;

EXEC sp_RegistrarCliente 
    @nombre = 'Juan Pérez',
    @telefono = '987654321',
    @direccion = 'Av. Hoyos Rubio - Cajamarca';

    select * from cliente
    where idCliente = 6;



-- 4. Registrar DetallePedido
GO
CREATE PROCEDURE sp_RegistrarDetalle
    @idPedido INT,
    @idPlato INT,
    @cantidad INT,
    @precio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO DetallePedido(idPedido, idPlato, cantidad, precio)

    VALUES(@idPedido, @idPlato, @cantidad, @precio);
END;

EXEC sp_RegistrarDetalle
    @idPedido = 1,
    @idPlato = 1,
    @cantidad = 2,
    @precio = 25.50;

    select * from DetallePedido
    where idPedido = 1 and idPlato = 1 and cantidad = 2 and precio = 25.50;






--Trigger

--1)
GO
CREATE TRIGGER trg_VerificarMontoPago
ON Pago
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE monto <= 0
    )
    BEGIN
        PRINT 'Error: El monto debe ser mayor que 0';
    END
    ELSE
    BEGIN
        INSERT INTO Pago (idPedido, monto, fechaPago, tipoPago)
        SELECT idPedido, monto, fechaPago, tipoPago
        FROM inserted;
    END
END;

INSERT INTO Pago VALUES (1, -10, GETDATE(), 'Efectivo');



-- 2. Actualizar automáticamente el total del pedido cuando se inserta un detalle:
GO
CREATE TRIGGER trg_ActualizarTotalPedido
ON DetallePedido
AFTER INSERT
AS
BEGIN
    UPDATE Pedido
    SET total = (
        SELECT SUM(cantidad * precio)
        FROM DetallePedido
        WHERE idPedido = Pedido.idPedido
    )
    WHERE idPedido IN (SELECT idPedido FROM inserted);
END;

INSERT INTO DetallePedido(idPedido, idPlato, cantidad, precio)
VALUES (1, 1, 2, 35.00);

SELECT total FROM Pedido WHERE idPedido = 1;



-- 3. Evitar cantidad negativa en DetallePedido
GO
CREATE TRIGGER trg_NoPrecioNegativo
ON Plato
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE precio <= 0)
    BEGIN
        RAISERROR('El precio no puede ser negativo o cero.',16,1);
        ROLLBACK;
    END
END;

DELETE FROM Pedido WHERE idPedido = 1;

INSERT INTO Plato(nombre, descripcion, precio)
VALUES ('Prueba', 'Prueba', -5);



--- 4. Evitar eliminar pedidos que ya tienen pagos:Trigger para evitar eli-minar un pedido que ya tiene pagos registrados
GO
CREATE TRIGGER trg_NoEliminarPedidoPagado
ON Pedido
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Pago p
        INNER JOIN deleted d
        ON p.idPedido = d.idPedido
    )
    BEGIN
        RAISERROR('No se puede eliminar un pedido que ya tiene pagos regis-trados.',16,1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM Pedido
        WHERE idPedido IN (SELECT idPedido FROM deleted);
    END
END;

DELETE FROM Pedido
WHERE idPedido = 1;





--Vista
--1)
GO
CREATE VIEW vw_PedidosCompletos
AS
SELECT 
    P.idPedido,
    C.nombre AS Cliente,
    E.nombre AS Empleado,
    M.numero AS Mesa,
    P.fechaPedido,
    P.total
FROM Pedido P
INNER JOIN Cliente C ON P.idCliente = C.idCliente
INNER JOIN Mesa M ON P.idMesa = M.idMesa
INNER JOIN EmpleadoPedido EP ON P.idPedido = EP.idPedido
INNER JOIN Empleado E ON EP.idEmpleado = E.idEmpleado;
GO

SELECT * FROM vw_PedidosCompletos;



--2. Vista de pedidos con datos del cliente y mesa
GO
CREATE VIEW vw_PedidosDetalle
AS
SELECT 
    p.idPedido,
    c.nombre AS Cliente,
    m.numero AS Mesa,
    p.fechaPedido,
    p.total
FROM Pedido p
INNER JOIN Cliente c ON p.idCliente = c.idCliente
LEFT JOIN Mesa m ON p.idMesa = m.idMesa;

SELECT * FROM vw_PedidosDetalle;



-- 3. Vista de Pagos con Cliente
GO
CREATE VIEW vw_PagosDetalle
AS
SELECT 
    p.idPago,
    c.nombre AS Cliente,
    p.monto,
    p.tipoPago,
    p.fechaPago
FROM Pago p
INNER JOIN Pedido pe ON p.idPedido = pe.idPedido
INNER JOIN Cliente c ON pe.idCliente = c.idCliente;

SELECT * FROM vw_PagosDetalle;



--4. Vista de Platos Vendidos
GO
CREATE VIEW vw_PlatosVendidos
AS
SELECT 
    pl.nombre,
    SUM(d.cantidad) AS TotalVendido
FROM DetallePedido d
INNER JOIN Plato pl ON d.idPlato = pl.idPlato
GROUP BY pl.nombre;




-- 5. Vista de Ventas por Día
GO
CREATE VIEW vw_VentasPorDia
AS
SELECT 
    CAST(fechaPedido AS DATE) AS Fecha,
    SUM(total) AS TotalVentas
FROM Pedido
GROUP BY CAST(fechaPedido AS DATE);

SELECT * FROM vw_VentasPorDia;




--Funciones
--1. Total de pedidos de un cliente
GO
CREATE FUNCTION fn_CantidadPedidosCliente(@idCliente INT)
RETURNS INT
AS
BEGIN
    DECLARE @cantidad INT;

    SELECT @cantidad = COUNT(*)
    FROM Pedido
    WHERE idCliente = @idCliente;

    RETURN ISNULL(@cantidad,0);
END;

SELECT nombre,
       dbo.fn_CantidadPedidosCliente(idCliente) AS CantidadPedidos
FROM Cliente;




--2. Total de ventas generales
GO
CREATE FUNCTION fn_TotalVentas()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = SUM(total)
    FROM Pedido;

    RETURN ISNULL(@total,0);
END;

SELECT dbo.fn_TotalVentas() AS TotalGeneral;




-- 3. Total vendido por plato
GO
CREATE FUNCTION fn_TotalVendidoPlato(@idPlato INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;

    SELECT @total = SUM(cantidad)
    FROM DetallePedido
    WHERE idPlato = @idPlato;

    RETURN ISNULL(@total,0);
END;

SELECT dbo.fn_TotalVendidoPlato(1) AS TotalVendido;




--4. Promedio de venta por pedido
GO
CREATE FUNCTION fn_PromedioVenta()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @prom DECIMAL(10,2);

    SELECT @prom = AVG(total)
    FROM Pedido;

    RETURN ISNULL(@prom,0);
END;

SELECT dbo.fn_PromedioVenta() AS Promedio;



