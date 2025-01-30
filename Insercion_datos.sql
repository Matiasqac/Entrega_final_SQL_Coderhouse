-- Usar la base de datos
USE sistema_comercial;

-- Insertar 10 registros en la tabla Clientes
INSERT INTO Clientes (nombre_cliente, genero, ubicacion, fecha_nacimiento, fecha_registro, categoria)
VALUES
('Juan Pérez', 'Masculino', 'Av. Corrientes 1234, Buenos Aires', '1990-05-15', '2023-01-10', 'Bronce'),
('María López', 'Femenino', 'Calle Florida 567, Buenos Aires', '1985-08-22', '2023-02-05', 'Plata'),
('Carlos Sánchez', 'Masculino', 'Av. Santa Fe 789, Buenos Aires', '1995-03-30', '2023-03-12', 'Oro'),
('Ana García', 'Femenino', 'Calle Lavalle 456, Buenos Aires', '1988-11-10', '2023-04-18', 'VIP'),
('Luis Martínez', 'Masculino', 'Av. Rivadavia 321, Buenos Aires', '1992-07-25', '2023-05-22', 'Bronce'),
('Sofía Ramírez', 'Femenino', 'Calle Reconquista 654, Buenos Aires', '1998-09-14', '2023-06-30', 'Plata'),
('Jorge Torres', 'Masculino', 'Av. Callao 987, Buenos Aires', '1987-12-05', '2023-07-15', 'Oro'),
('Patricia Díaz', 'Femenino', 'Calle Paraguay 147, Buenos Aires', '1993-04-20', '2023-08-10', 'VIP'),
('Roberto Ruiz', 'Masculino', 'Av. Córdoba 258, Buenos Aires', '1991-06-18', '2023-09-05', 'Bronce'),
('Lucía Hernández', 'Femenino', 'Calle Suipacha 369, Buenos Aires', '1989-02-28', '2023-10-12', 'Plata');

-- Insertar 10 registros en la tabla Proveedores
INSERT INTO Proveedores (nombre_proveedor, direccion, ciudad, metodo_pago)
VALUES
('SegurTech', 'Av. Corrientes 1234, Buenos Aires', 'Buenos Aires', 'Transferencia'),
('AlarmasPro', 'Calle Florida 567, Buenos Aires', 'Buenos Aires', 'Cheque'),
('CamarasPlus', 'Av. Santa Fe 789, Buenos Aires', 'Buenos Aires', 'Efectivo'),
('SensoresSeguros', 'Calle Lavalle 456, Buenos Aires', 'Buenos Aires', 'Tarjeta'),
('CentralesConfianza', 'Av. Rivadavia 321, Buenos Aires', 'Buenos Aires', 'Transferencia'),
('VigilanciaTotal', 'Calle Reconquista 654, Buenos Aires', 'Buenos Aires', 'Cheque'),
('ElectroSeguridad', 'Av. Callao 987, Buenos Aires', 'Buenos Aires', 'Efectivo'),
('AlarmasExpress', 'Calle Paraguay 147, Buenos Aires', 'Buenos Aires', 'Tarjeta'),
('CamarasFull', 'Av. Córdoba 258, Buenos Aires', 'Buenos Aires', 'Transferencia'),
('SensoresPro', 'Calle Suipacha 369, Buenos Aires', 'Buenos Aires', 'Cheque');

-- Insertar 10 registros en la tabla Empleados
INSERT INTO Empleados (nombre_empleado, ubicacion_empleado, fecha_nacimiento_empleado, area_empleado)
VALUES
('Pedro Gómez', 'Av. Corrientes 1234, Buenos Aires', '1980-04-12', 'Ventas'),
('Laura Fernández', 'Calle Florida 567, Buenos Aires', '1982-07-25', 'Compras'),
('Javier Ramírez', 'Av. Santa Fe 789, Buenos Aires', '1985-09-18', 'Administración'),
('Mónica Torres', 'Calle Lavalle 456, Buenos Aires', '1988-11-30', 'Ventas'),
('Roberto Sánchez', 'Av. Rivadavia 321, Buenos Aires', '1990-02-14', 'Compras'),
('Sara López', 'Calle Reconquista 654, Buenos Aires', '1992-05-20', 'Administración'),
('Daniel García', 'Av. Callao 987, Buenos Aires', '1995-08-10', 'Ventas'),
('Patricia Ruiz', 'Calle Paraguay 147, Buenos Aires', '1987-12-05', 'Compras'),
('Alejandro Díaz', 'Av. Córdoba 258, Buenos Aires', '1993-03-22', 'Administración'),
('Gabriela Morales', 'Calle Suipacha 369, Buenos Aires', '1996-06-15', 'Ventas');

-- Insertar 10 registros en la tabla Productos
INSERT INTO Productos (nombre_producto, precio_unitario, stock)
VALUES
('Cámara IP 4MP', 1200.00, 50),
('DVR 8 Canales', 2500.00, 30),
('Central de Alarma', 4000.00, 20),
('Sensor de Movimiento', 300.00, 100),
('Sensor de Puerta', 250.00, 120),
('Cable UTP Cat6', 5.00, 500),
('Fuente de Poder 12V', 150.00, 80),
('NVR 16 Canales', 5000.00, 15),
('Cámara Bullet 5MP', 1500.00, 40),
('Teclado para Central', 800.00, 25);

-- Insertar 10 registros en la tabla Servicios
INSERT INTO Servicios (descripcion, precio_unitario_servicio, tiempo_estimado)
VALUES
('Instalación de Cámara IP', 500.00, 60),
('Configuración de DVR', 300.00, 30),
('Instalación de Central de Alarma', 800.00, 120),
('Configuración de Sensores', 200.00, 45),
('Mantenimiento de Sistema', 400.00, 90),
('Reparación de Cámaras', 600.00, 60),
('Instalación de NVR', 700.00, 90),
('Configuración de Monitor', 150.00, 30),
('Instalación de Sirena', 250.00, 45),
('Reemplazo de Batería', 100.00, 20);

-- Insertar 10 registros en la tabla Items (5 productos y 5 servicios)
INSERT INTO Items (tipo_item, id_producto, id_servicio)
VALUES
('Producto', 1, NULL),  -- Asociado al producto 1 (Cámara IP 4MP)
('Producto', 2, NULL),  -- Asociado al producto 2 (DVR 8 Canales)
('Producto', 3, NULL),  -- Asociado al producto 3 (Central de Alarma)
('Producto', 4, NULL),  -- Asociado al producto 4 (Sensor de Movimiento)
('Producto', 5, NULL),  -- Asociado al producto 5 (Sensor de Puerta)
('Servicio', NULL, 1),  -- Asociado al servicio 1 (Instalación de Cámara IP)
('Servicio', NULL, 2),  -- Asociado al servicio 2 (Configuración de DVR)
('Servicio', NULL, 3),  -- Asociado al servicio 3 (Instalación de Central de Alarma)
('Servicio', NULL, 4),  -- Asociado al servicio 4 (Configuración de Sensores)
('Servicio', NULL, 5);  -- Asociado al servicio 5 (Mantenimiento de Sistema)

-- Insertar 10 registros en la tabla Ventas
INSERT INTO Ventas (total, fecha_venta, id_cliente, id_empleado)
VALUES
(1200.00, '2023-01-15', 1, 1),
(2500.00, '2023-02-10', 2, 2),
(4000.00, '2023-03-20', 3, 3),
(300.00, '2023-04-25', 4, 4),
(250.00, '2023-05-30', 5, 5),
(5.00, '2023-06-05', 6, 6),
(150.00, '2023-07-10', 7, 7),
(5000.00, '2023-08-15', 8, 8),
(1500.00, '2023-09-20', 9, 9),
(800.00, '2023-10-25', 10, 10);

-- Insertar 10 registros en la tabla Detalle_Ventas
INSERT INTO Detalle_Ventas (descuento, total_linea_venta, cantidad, id_venta, id_item)
VALUES
(0, 1200.00, 1, 1, 1),
(0, 2500.00, 1, 2, 2),
(0, 4000.00, 1, 3, 3),
(0, 300.00, 1, 4, 4),
(0, 250.00, 1, 5, 5),
(0, 5.00, 1, 6, 6),
(0, 150.00, 1, 7, 7),
(0, 5000.00, 1, 8, 8),
(0, 1500.00, 1, 9, 9),
(0, 800.00, 1, 10, 10);

-- Insertar 10 registros en la tabla Compras
INSERT INTO Compras (total_compra, fecha_compra, id_proveedor, id_empleado)
VALUES
(1200.00, '2023-01-05', 1, 1),
(2500.00, '2023-02-10', 2, 2),
(4000.00, '2023-03-15', 3, 3),
(300.00, '2023-04-20', 4, 4),
(250.00, '2023-05-25', 5, 5),
(5.00, '2023-06-30', 6, 6),
(150.00, '2023-07-05', 7, 7),
(5000.00, '2023-08-10', 8, 8),
(1500.00, '2023-09-15', 9, 9),
(800.00, '2023-10-20', 10, 10);

-- Insertar 10 registros en la tabla Detalle_Compras
INSERT INTO Detalle_Compras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(1, 0, 1200.00, 1200.00, 1, 1),
(1, 0, 2500.00, 2500.00, 2, 2),
(1, 0, 4000.00, 4000.00, 3, 3),
(1, 0, 300.00, 300.00, 4, 4),
(1, 0, 250.00, 250.00, 5, 5),
(1, 0, 5.00, 5.00, 6, 6),
(1, 0, 150.00, 150.00, 7, 7),
(1, 0, 5000.00, 5000.00, 8, 8),
(1, 0, 1500.00, 1500.00, 9, 9),
(1, 0, 800.00, 800.00, 10, 10);
