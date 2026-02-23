

--Tabla Cliente
CREATE TABLE Cliente (
    idCliente INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(200)
);


--Tabla Empleado 
CREATE TABLE Empleado (
    idEmpleado INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50),
    telefono VARCHAR(20)
);



--Tabla Mesa 
CREATE TABLE Mesa (
    idMesa INT IDENTITY PRIMARY KEY,
    numero INT NOT NULL,
    capacidad INT NOT NULL
);


--Tabla Plato
CREATE TABLE Plato (
    idPlato INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2) NOT NULL
);


--Tabla Pedido
CREATE TABLE Pedido (
    idPedido INT IDENTITY PRIMARY KEY,
    idCliente INT NOT NULL,
    idMesa INT,
    fechaPedido DATETIME NOT NULL,
    total DECIMAL(10,2),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idMesa) REFERENCES Mesa(idMesa)
);


--Tabla EmpleadoPedido
CREATE TABLE EmpleadoPedido (
    idEmpleado INT,
    idPedido INT,
    PRIMARY KEY (idEmpleado, idPedido),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);



--Tabla DetallePedido 
CREATE TABLE DetallePedido (
    idDetalle INT IDENTITY PRIMARY KEY,
    idPedido INT NOT NULL,
    idPlato INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idPlato) REFERENCES Plato(idPlato)
);


--Tabla Pago
CREATE TABLE Pago (
    idPago INT IDENTITY PRIMARY KEY,
    idPedido INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fechaPago DATETIME NOT NULL,
    tipoPago VARCHAR(20),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);



INSERT INTO Cliente (nombre, telefono, direccion) VALUES
('Andrés Vargas', '970222280', 'Jr. Los Olivos'), 
('Valeria Luna', '970333390', 'Calle Mercaderes'), 
('Oscar Quiroz', '970444400', 'Av. Benavides'), 
('Natalia Soto', '970555510', 'Jr. Huallaga'), 
('Julian Meza', '970666620', 'Av. Larco'),
('Juan Pérez', '976123456', 'Av. Hoyos Rubio - Cajamarca'),
('María Sánchez', '987654321', 'Jr. Dos de Mayo - Cajamarca'),
('Luis Ramírez', '981234567', 'Barrio La Tulpuna'),
('Rosa Chávez', '975321654', 'Baños del Inca'),
('Carlos Flores', '982456789', 'Av. Atahualpa - Cajamarca'),
('Miguel Arroyo', '970111111', 'Jr. Amazonas - Cajamarca'),
('Elena Rojas', '970111112', 'Av. Atahualpa - Cajamarca'),
('Fernando Díaz', '970111113', 'Baños del Inca'),
('Patricia León', '970111114', 'Jr. Dos de Mayo'),
('Roberto Salazar', '970111115', 'Barrio La Tulpuna'),
('Maribel Ruiz', '970111116', 'Av. Hoyos Rubio'),
('César Valdivia', '970111117', 'Jr. Comercio'),
('Andrea Castillo', '970111118', 'Av. Independencia'),
('Jorge Cueva', '970111119', 'Barrio San Martín'),
('Daniela Correa', '970111120', 'Av. Grau'),
('Luis Paredes', '970111121', 'Jr. Ayacucho'),
('Paola Méndez', '970111122', 'Av. Universitaria'),
('Iván Torres', '970111123', 'Jr. Cajamarca'),
('Ruth Vásquez', '970111124', 'Barrio Santa Apolonia'),
('Óscar Quintana', '970111125', 'Av. La Paz'),
('Verónica Silva', '970111126', 'Jr. Lima'),
('Alberto Ríos', '970111127', 'Baños del Inca'),
('Karla Benavides', '970111128', 'Av. Atahualpa'),
('Mauricio Peralta', '970111129', 'Jr. Dos de Mayo'),
('Florencia Campos', '970111130', 'Barrio La Tulpuna'),
('Renzo Aguilar', '970111131', 'Av. Hoyos Rubio'),
('María Poma', '970111132', 'Jr. Comercio'),
('Diego Huerta', '970111133', 'Av. Independencia'),
('Rosa Villanueva', '970111134', 'Barrio San Martín'),
('Sergio Lozano', '970111135', 'Av. Grau'),
('Luciana Prado', '970111136', 'Jr. Ayacucho'),
('Kevin Farfán', '970111137', 'Av. Universitaria'),
('Diana Córdova', '970111138', 'Jr. Cajamarca'),
('Andrés Gálvez', '970111139', 'Santa Apolonia'),
('Natalia Chacón', '970111140', 'Av. La Paz'),
('Raúl Espinoza', '970111141', 'Jr. Lima'),
('Melissa Herrera', '970111142', 'Baños del Inca'),
('Pablo Navarro', '970111143', 'Av. Atahualpa'),
('Carolina Peña', '970111144', 'Jr. Dos de Mayo'),
('Jhonatan Cabrera', '970111145', 'La Tulpuna'),
('Alejandra Luján', '970111146', 'Av. Hoyos Rubio'),
('Cristian Soto', '970111147', 'Jr. Comercio'),
('Fiorella Zúñiga', '970111148', 'Av. Independencia'),
('Bruno Delgado', '970111149', 'Barrio San Martín'),
('Valeria Ramos', '970111150', 'Av. Grau'),
('Ricardo Molina', '970111151', 'Jr. Ayacucho'),
('Milagros Castañeda', '970111152', 'Av. Universitaria'),
('Eduardo Huamán', '970111153', 'Jr. Cajamarca'),
('Karen Alvarado', '970111154', 'Santa Apolonia'),
('Julio Tapia', '970111155', 'Av. La Paz'),
('Rocío Palacios', '970111156', 'Jr. Lima'),
('Hugo Benítez', '970111157', 'Baños del Inca'),
('Pamela Ordoñez', '970111158', 'Av. Atahualpa'),
('Álvaro Sánchez', '970111159', 'Jr. Dos de Mayo'),
('Claudia Rentería', '970111160', 'La Tulpuna'),
('Gerson Fuentes', '970111161', 'Av. Hoyos Rubio'),
('Noelia Cárdenas', '970111162', 'Jr. Comercio'),
('Sebastián Puga', '970111163', 'Av. Independencia'),
('Leslie Rojas', '970111164', 'Barrio San Martín'),
('Fabián Carrasco', '970111165', 'Av. Grau'),
('Lorena Chávez', '970111166', 'Jr. Ayacucho'),
('Marco Tello', '970111167', 'Av. Universitaria'),
('Sofía Lévano', '970111168', 'Jr. Cajamarca'),
('Alexis Hurtado', '970111169', 'Santa Apolonia'),
('Camila Risco', '970111170', 'Av. La Paz');


INSERT INTO Empleado (nombre, puesto, telefono) VALUES
('Ana Torres', 'Mesera', '965432111'),
('Fernando Paz', 'Mesero', '951098555'), 
('Marco Polo', 'Mesero', '955432111'), 
('Diana Soler', 'Cocinero', '954321222'), 
('Pedro Vilca', 'Cocinero', '964321222'),
('José Huamán', 'Administrador', '963210333');



INSERT INTO Mesa (numero, capacidad) VALUES
(1, 4),
(2, 4),
(3, 6),
(4, 2),
(5, 8);


INSERT INTO Plato (nombre, descripcion, precio) VALUES
('Cuy frito', 'Cuy frito con papas y ají', 35.00),
('Caldo verde', 'Sopa tradicional cajamarquina', 12.00),
('Chicharrón con mote', 'Cerdo crocante con mote', 18.00),
('Humitas', 'Humitas dulces y saladas', 8.00),
('Queso con miel', 'Queso cajamarquino artesanal', 10.00);




INSERT INTO Pedido (idCliente, idMesa, fechaPedido, total) VALUES
(1, 1, '2026-02-10 12:30', 47.00),
(2, 2, '2026-02-10 13:15', 35.00),
(3, 3, '2026-02-10 14:00', 20.00),
(4, 4, '2026-02-10 15:10', 18.00),
(5, 5, '2026-02-10 16:00', 45.00),
(6, 1, '2026-02-11 09:10', 47.00),
(7, 2, '2026-02-11 09:25', 35.00),
(8, 3, '2026-02-11 09:40', 20.00),
(9, 4, '2026-02-11 10:00', 18.00),
(10, 5, '2026-02-11 10:15', 45.00),
(11, 1, '2026-02-11 10:30', 50.00),
(12, 2, '2026-02-11 10:45', 32.00),
(13, 3, '2026-02-11 11:00', 22.00),
(14, 4, '2026-02-11 11:15', 19.00),
(15, 5, '2026-02-11 11:30', 48.00),
(16, 1, '2026-02-11 11:45', 46.00),
(17, 2, '2026-02-11 12:00', 34.00),
(18, 3, '2026-02-11 12:15', 21.00),
(19, 4, '2026-02-11 12:30', 18.50),
(20, 5, '2026-02-11 12:45', 44.00),
(21, 1, '2026-02-11 13:00', 49.00),
(22, 2, '2026-02-11 13:15', 36.00),
(23, 3, '2026-02-11 13:30', 23.00),
(24, 4, '2026-02-11 13:45', 19.50),
(25, 5, '2026-02-11 14:00', 46.00),
(26, 1, '2026-02-11 14:15', 48.00),
(27, 2, '2026-02-11 14:30', 33.00),
(28, 3, '2026-02-11 14:45', 24.00),
(29, 4, '2026-02-11 15:00', 20.00),
(30, 5, '2026-02-11 15:15', 47.00),
(31, 1, '2026-02-11 15:30', 45.00),
(32, 2, '2026-02-11 15:45', 31.00),
(33, 3, '2026-02-11 16:00', 22.50),
(34, 4, '2026-02-11 16:15', 18.00),
(35, 5, '2026-02-11 16:30', 43.00),
(36, 1, '2026-02-11 16:45', 49.00),
(37, 2, '2026-02-11 17:00', 34.00),
(38, 3, '2026-02-11 17:15', 25.00),
(39, 4, '2026-02-11 17:30', 21.00),
(40, 5, '2026-02-11 17:45', 46.00),
(41, 1, '2026-02-11 18:00', 50.00),
(42, 2, '2026-02-11 18:15', 38.00),
(43, 3, '2026-02-11 18:30', 26.00),
(44, 4, '2026-02-11 18:45', 22.00),
(45, 5, '2026-02-11 19:00', 48.00),
(46, 1, '2026-02-11 19:15', 47.00),
(47, 2, '2026-02-11 19:30', 35.00),
(48, 3, '2026-02-11 19:45', 24.00),
(49, 4, '2026-02-11 20:00', 20.00),
(50, 5, '2026-02-11 20:15', 45.00),
(51, 1, '2026-02-11 20:30', 49.00),
(52, 2, '2026-02-11 20:45', 37.00),
(53, 3, '2026-02-11 21:00', 26.00),
(54, 4, '2026-02-11 21:15', 23.00),
(55, 5, '2026-02-11 21:30', 47.00),
(56, 1, '2026-02-11 21:45', 46.00),
(57, 2, '2026-02-11 22:00', 34.00),
(58, 3, '2026-02-11 22:15', 25.00),
(59, 4, '2026-02-11 22:30', 21.00),
(60, 5, '2026-02-11 22:45', 44.00),
(61, 1, '2026-02-12 09:00', 48.00),
(62, 2, '2026-02-12 09:20', 36.00),
(63, 3, '2026-02-12 09:40', 22.00),
(64, 4, '2026-02-12 10:00', 19.00),
(65, 5, '2026-02-12 10:20', 45.00),
(66, 1, '2026-02-12 10:40', 47.00),
(67, 2, '2026-02-12 11:00', 35.00),
(68, 3, '2026-02-12 11:20', 24.00),
(69, 4, '2026-02-12 11:40', 20.00),
(70, 5, '2026-02-12 12:00', 46.00);


INSERT INTO DetallePedido (idPedido, idPlato, cantidad, precio) VALUES
(1, 2, 2, 12.00), -- Caldo verde
(1, 5, 1, 10.00), -- Queso con miel
(2, 1, 1, 35.00), -- Cuy frito
(3, 4, 2, 8.00),  -- Humitas
(4, 3, 1, 18.00), -- Chicharrón
(5, 1, 1, 35.00),
(5, 4, 1, 8.00),
(6, 2, 1, 12.00),
(6, 5, 1, 10.00),
(7, 4, 2, 16.00),
(8, 1, 1, 35.00),
(9, 3, 1, 18.00),
(9, 2, 1, 12.00),
(10, 4, 2, 16.00),
(10, 5, 1, 10.00),
(11, 2, 2, 24.00),
(12, 1, 1, 35.00),
(12, 4, 1, 8.00),
(13, 3, 1, 18.00),
(14, 2, 1, 12.00),
(14, 5, 1, 10.00),
(15, 1, 1, 35.00),
(16, 4, 3, 24.00),
(17, 2, 1, 12.00),
(17, 3, 1, 18.00),
(18, 5, 2, 20.00),
(19, 1, 1, 35.00),
(19, 2, 1, 12.00),
(20, 4, 2, 16.00),
(21, 3, 1, 18.00),
(22, 2, 2, 24.00),
(23, 1, 1, 35.00),
(24, 4, 2, 16.00),
(24, 5, 1, 10.00),
(25, 3, 1, 18.00),
(26, 2, 1, 12.00),
(26, 4, 1, 8.00),
(27, 1, 1, 35.00),
(28, 5, 2, 20.00),
(29, 3, 1, 18.00),
(30, 2, 2, 24.00),
(31, 1, 1, 35.00),
(32, 4, 2, 16.00),
(33, 2, 1, 12.00),
(33, 5, 1, 10.00),
(34, 3, 1, 18.00),
(35, 1, 1, 35.00),
(35, 4, 1, 8.00),
(36, 2, 2, 24.00),
(37, 5, 2, 20.00),
(38, 1, 1, 35.00),
(39, 3, 1, 18.00),
(39, 2, 1, 12.00),
(40, 4, 3, 24.00),
(41, 1, 1, 35.00),
(42, 2, 1, 12.00),
(42, 5, 1, 10.00),
(43, 3, 1, 18.00),
(44, 4, 2, 16.00),
(45, 1, 1, 35.00),
(46, 2, 2, 24.00),
(47, 5, 2, 20.00),
(48, 3, 1, 18.00),
(49, 4, 2, 16.00),
(50, 1, 1, 35.00),
(51, 2, 1, 12.00),
(51, 4, 1, 8.00),
(52, 3, 1, 18.00),
(53, 1, 1, 35.00),
(54, 5, 2, 20.00),
(55, 2, 2, 24.00),
(56, 4, 2, 16.00),
(57, 1, 1, 35.00),
(58, 3, 1, 18.00),
(59, 2, 1, 12.00),
(59, 5, 1, 10.00),
(60, 4, 3, 24.00),
(61, 1, 1, 35.00),
(62, 2, 2, 24.00),
(63, 3, 1, 18.00),
(64, 5, 2, 20.00),
(65, 1, 1, 35.00),
(66, 4, 2, 16.00),
(67, 2, 1, 12.00),
(67, 3, 1, 18.00),
(68, 1, 1, 35.00),
(69, 5, 2, 20.00),
(70, 3, 1, 18.00);



INSERT INTO Pago (idPedido, monto, fechaPago, tipoPago) VALUES
(1, 47.00, '2026-02-10 12:45', 'Efectivo'),
(2, 35.00, '2026-02-10 13:30', 'Yape'),
(3, 20.00, '2026-02-10 14:10', 'Plin'),
(4, 18.00, '2026-02-10 15:20', 'Efectivo'),
(5, 45.00, '2026-02-10 16:15', 'Tarjeta'),
(6, 22.00, '2026-02-10 16:40', 'Yape'),
(7, 30.00, '2026-02-10 17:10', 'Plin'),
(8, 15.00, '2026-02-10 17:30', 'Efectivo'),
(9, 28.00, '2026-02-10 18:00', 'Tarjeta'),
(10, 40.00, '2026-02-10 18:20', 'Yape'),
(11, 18.00, '2026-02-10 18:40', 'Plin'),
(12, 25.00, '2026-02-10 19:00', 'Efectivo'),
(13, 32.00, '2026-02-10 19:20', 'Tarjeta'),
(14, 20.00, '2026-02-10 19:40', 'Yape'),
(15, 35.00, '2026-02-10 20:00', 'Plin'),
(16, 27.00, '2026-02-10 20:20', 'Efectivo'),
(17, 45.00, '2026-02-10 20:40', 'Tarjeta'),
(18, 19.00, '2026-02-10 21:00', 'Yape'),
(19, 33.00, '2026-02-10 21:20', 'Plin'),
(20, 26.00, '2026-02-10 21:40', 'Efectivo'),
(21, 38.00, '2026-02-10 22:00', 'Tarjeta'),
(22, 24.00, '2026-02-10 22:20', 'Yape'),
(23, 29.00, '2026-02-10 22:40', 'Plin'),
(24, 17.00, '2026-02-10 23:00', 'Efectivo'),
(25, 41.00, '2026-02-10 23:20', 'Tarjeta'),
(26, 36.00, '2026-02-11 09:00', 'Yape'),
(27, 21.00, '2026-02-11 09:20', 'Plin'),
(28, 23.00, '2026-02-11 09:40', 'Efectivo'),
(29, 34.00, '2026-02-11 10:00', 'Tarjeta'),
(30, 27.00, '2026-02-11 10:20', 'Yape'),
(31, 39.00, '2026-02-11 10:40', 'Plin'),
(32, 16.00, '2026-02-11 11:00', 'Efectivo'),
(33, 42.00, '2026-02-11 11:20', 'Tarjeta'),
(34, 28.00, '2026-02-11 11:40', 'Yape'),
(35, 31.00, '2026-02-11 12:00', 'Plin'),
(36, 20.00, '2026-02-11 12:20', 'Efectivo'),
(37, 44.00, '2026-02-11 12:40', 'Tarjeta'),
(38, 26.00, '2026-02-11 13:00', 'Yape'),
(39, 37.00, '2026-02-11 13:20', 'Plin'),
(40, 18.00, '2026-02-11 13:40', 'Efectivo'),
(41, 33.00, '2026-02-11 14:00', 'Tarjeta'),
(42, 22.00, '2026-02-11 14:20', 'Yape'),
(43, 29.00, '2026-02-11 14:40', 'Plin'),
(44, 25.00, '2026-02-11 15:00', 'Efectivo'),
(45, 41.00, '2026-02-11 15:20', 'Tarjeta'),
(46, 34.00, '2026-02-11 15:40', 'Yape'),
(47, 27.00, '2026-02-11 16:00', 'Plin'),
(48, 19.00, '2026-02-11 16:20', 'Efectivo'),
(49, 45.00, '2026-02-11 16:40', 'Tarjeta'),
(50, 38.00, '2026-02-11 17:00', 'Yape'),
(51, 21.00, '2026-02-11 17:20', 'Plin'),
(52, 32.00, '2026-02-11 17:40', 'Efectivo'),
(53, 28.00, '2026-02-11 18:00', 'Tarjeta'),
(54, 35.00, '2026-02-11 18:20', 'Yape'),
(55, 24.00, '2026-02-11 18:40', 'Plin'),
(56, 30.00, '2026-02-11 19:00', 'Efectivo'),
(57, 43.00, '2026-02-11 19:20', 'Tarjeta'),
(58, 26.00, '2026-02-11 19:40', 'Yape'),
(59, 37.00, '2026-02-11 20:00', 'Plin'),
(60, 22.00, '2026-02-11 20:20', 'Efectivo'),
(61, 39.00, '2026-02-12 09:00', 'Tarjeta'),
(62, 28.00, '2026-02-12 09:20', 'Yape'),
(63, 34.00, '2026-02-12 09:40', 'Plin'),
(64, 20.00, '2026-02-12 10:00', 'Efectivo'),
(65, 45.00, '2026-02-12 10:20', 'Tarjeta'),
(66, 31.00, '2026-02-12 10:40', 'Yape'),
(67, 27.00, '2026-02-12 11:00', 'Plin'),
(68, 36.00, '2026-02-12 11:20', 'Efectivo'),
(69, 41.00, '2026-02-12 11:40', 'Tarjeta'),
(70, 29.00, '2026-02-12 12:00', 'Efectivo');



INSERT INTO EmpleadoPedido (idEmpleado, idPedido) VALUES
-- Pedido 1
(1,1), -- Mesera
(4,1), -- Cocinera
-- Pedido 2
(2,2),
(5,2),
-- Pedido 3
(3,3),
(4,3),
-- Pedido 4
(1,4),
(5,4),
-- Pedido 5
(2,5),
(4,5);



Select * from Cliente; 
Select * from DetallePedido;
select * from Empleado; 
select * from Mesa; 
select * from Pago;
select * from Pedido; 
select * from Plato;

