-- Crear la base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS sistema_comercial;

-- Usar la base de datos
USE sistema_comercial;

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(30),
    genero ENUM('Masculino', 'Femenino', 'Otro'),
    ubicacion VARCHAR(30),
    fecha_nacimiento DATE,
    fecha_registro DATE,
    categoria VARCHAR(15)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(30),
    direccion VARCHAR(30),
    ciudad VARCHAR(30),
    metodo_pago VARCHAR(30)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empleado VARCHAR(30),
    ubicacion_empleado VARCHAR(30),
    fecha_nacimiento_empleado DATE,
    area_empleado ENUM('Ventas', 'Compras', 'Administración', 'Otro')
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(30),
    precio_unitario DECIMAL(10, 2),
    stock INT
);

-- Tabla Servicios
CREATE TABLE Servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(30),
    precio_unitario_servicio DECIMAL(10, 2),
    tiempo_estimado INT
);

-- Tabla Items
CREATE TABLE Items (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    tipo_item ENUM('Producto', 'Servicio'),
    id_producto INT,
    id_servicio INT,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio)
);

-- Tabla Ventas
CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    total DECIMAL(10, 2),
    fecha_venta DATE,
    id_cliente INT,
    id_empleado INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- Tabla Detalle Ventas
CREATE TABLE Detalle_Ventas (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    descuento DECIMAL(5, 2),
    total_linea_venta DECIMAL(10, 2),
    cantidad INT,
    id_venta INT,
    id_item INT,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_item) REFERENCES Items(id_item)
);

-- Tabla Compras
CREATE TABLE Compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    total_compra DECIMAL(10, 2),
    id_proveedor INT,
    id_empleado INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- Tabla Detalle Compras
CREATE TABLE Detalle_Compras (
    id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT,
    descuento DECIMAL(5, 2),
    precio_unitario_compra DECIMAL(10, 2),
    total_linea_compra DECIMAL(10, 2),
    id_producto INT,
    id_compra INT,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_compra) REFERENCES Compras(id_compra)
);


INSERT INTO Clientes (nombre_cliente, genero, ubicacion, fecha_nacimiento, fecha_registro, categoria)
VALUES
('Juan Pérez', 'masculino', 'Buenos Aires', '1985-07-15', '2024-01-01', 'particular'),
('María González', 'femenino', 'Córdoba', '1990-11-23', '2024-01-02', 'empresa'),
('Carlos López', 'masculino', 'Rosario', '1982-05-10', '2024-01-03', 'frecuente'),
('Ana Martínez', 'femenino', 'Mendoza', '1995-03-18', '2024-01-04', 'empresa'),
('Pedro Fernández', 'masculino', 'Salta', '1988-09-27', '2024-01-05', 'particular'),
('Laura Torres', 'femenino', 'Neuquén', '1993-12-12', '2024-01-06', 'frecuente'),
('Luis Silva', 'masculino', 'Santa Fe', '1987-02-08', '2024-01-07', 'empresa'),
('Sofía García', 'femenino', 'Tucumán', '1991-06-15', '2024-01-08', 'particular'),
('Diego Ramírez', 'masculino', 'Chaco', '1984-04-25', '2024-01-09', 'frecuente'),
('Camila Castillo', 'femenino', 'San Luis', '1996-08-30', '2024-01-10', 'empresa'),
('Andrés Moreno', 'masculino', 'La Plata', '1983-10-12', '2024-01-11', 'particular'),
('Natalia Ríos', 'femenino', 'Mar del Plata', '1994-07-22', '2024-01-12', 'frecuente'),
('Javier Ruiz', 'masculino', 'Bahía Blanca', '1986-11-05', '2024-01-13', 'empresa'),
('Valeria Díaz', 'femenino', 'San Juan', '1992-01-15', '2024-01-14', 'particular'),
('Guillermo Sosa', 'masculino', 'Río Gallegos', '1989-03-04', '2024-01-15', 'frecuente'),
('Carolina Vega', 'femenino', 'San Salvador', '1995-09-20', '2024-01-16', 'empresa'),
('Tomás Herrera', 'masculino', 'Formosa', '1990-12-01', '2024-01-17', 'particular'),
('Martina Ponce', 'femenino', 'Jujuy', '1993-02-19', '2024-01-18', 'frecuente'),
('Federico Molina', 'masculino', 'Trelew', '1988-06-06', '2024-01-19', 'empresa'),
('Lucía Álvarez', 'femenino', 'Ushuaia', '1991-08-14', '2024-01-20', 'particular');

 
INSERT INTO Proveedores (nombre_proveedor, direccion, ciudad, metodo_pago)
VALUES
('ElectroSur', 'Av. Libertador 1234', 'Buenos Aires', 'Transferencia bancaria'),
('TecnoCentro', 'Calle 25 de Mayo 567', 'Córdoba', 'Efectivo'),
('Distribuidora Norte', 'Ruta 9 KM 234', 'Rosario', 'Tarjeta de crédito'),
('Proveedora Patagónica', 'Av. San Martín 890', 'Neuquén', 'Transferencia bancaria'),
('Central de Insumos', 'Calle Corrientes 456', 'Santa Fe', 'Tarjeta de débito'),
('Insumos del Oeste', 'Av. Rivadavia 987', 'Mendoza', 'Transferencia bancaria'),
('Almacén Mayorista', 'Ruta Nacional 3 KM 45', 'La Plata', 'Cheque'),
('Proveedor Andino', 'Calle Las Heras 231', 'San Juan', 'Tarjeta de crédito'),
('Servicios del Sur', 'Av. Sarmiento 321', 'Trelew', 'Efectivo'),
('Distribuidora Austral', 'Calle Tierra del Fuego 12', 'Ushuaia', 'Transferencia bancaria');


INSERT INTO Empleados (nombre_empleado, ubicacion_empleado, fecha_nacimiento_empleado, area_empleado)
VALUES
('María López', 'Buenos Aires', '1985-03-15', 'Administracion'),
('Juan Pérez', 'Córdoba', '1990-07-12', 'Ventas'),
('Luciana Gómez', 'Rosario', '1988-09-21', 'Tecnico'),
('Martín Rodríguez', 'Mendoza', '1995-01-18', 'Ventas'),
('Sofía Fernández', 'Neuquén', '1992-11-05', 'Administracion'),
('Carlos Díaz', 'Santa Fe', '1987-05-25', 'Tecnico'),
('Valeria Sánchez', 'La Plata', '1983-08-30', 'Ventas'),
('Federico Álvarez', 'San Juan', '1993-12-10', 'Administracion'),
('Carolina Ortega', 'Trelew', '1991-02-20', 'Tecnico'),
('Diego Torres', 'Ushuaia', '1989-04-16', 'Ventas'),
('Ana Medina', 'Salta', '1984-06-19', 'Administracion'),
('Pablo Castro', 'Jujuy', '1996-10-22', 'Ventas'),
('Laura Morales', 'Bariloche', '1982-03-03', 'Tecnico'),
('Gustavo Ríos', 'Posadas', '1994-07-29', 'Ventas'),
('Natalia Vega', 'Tucumán', '1986-12-14', 'Administracion');

INSERT INTO Productos (nombre_producto, precio_unitario, stock)
VALUES
('Cámara de seguridad 1080p', 12000.00, 50),
('Cámara de seguridad 4K', 25000.00, 30),
('Kit de cámaras de 4 unidades', 60000.00, 20),
('Sensor de movimiento', 8000.00, 100),
('Sirena para alarma', 5000.00, 75),
('Control remoto para alarma', 3000.00, 150),
('Kit de alarma completo', 20000.00, 25),
('Cable coaxial 20m', 1200.00, 200),
('Cable UTP 30m', 1500.00, 180),
('Transformador 12V', 2500.00, 60),
('Panel de control de alarma', 15000.00, 15),
('Disco rígido 1TB', 8000.00, 40),
('Disco rígido 2TB', 15000.00, 30),
('Fuente de alimentación 5A', 5000.00, 50),
('Conector BNC', 500.00, 300),
('Conector RJ45', 400.00, 400),
('DVR 4 canales', 18000.00, 20),
('DVR 8 canales', 25000.00, 15),
('DVR 16 canales', 35000.00, 10),
('Monitor 21 pulgadas', 20000.00, 25),
('Monitor 24 pulgadas', 25000.00, 20),
('Micrófono ambiental', 5000.00, 50),
('Soporte para cámara', 1500.00, 100),
('Cámara IP 1080p', 18000.00, 30),
('Cámara IP 4K', 30000.00, 20),
('Videoportero básico', 20000.00, 25),
('Videoportero avanzado', 35000.00, 15),
('Control de acceso biométrico', 45000.00, 10),
('Tarjetas RFID', 1000.00, 500),
('Lector de tarjetas RFID', 8000.00, 50);

INSERT INTO Servicios (descripcion, tiempo_estimado)
VALUES
('Instalación de cámaras de seguridad', 240),
('Mantenimiento de sistemas de seguridad', 120),
('Configuración de alarmas', 90),
('Reparación de cámaras', 180),
('Actualización de firmware en DVR', 60),
('Instalación de videoporteros', 150),
('Capacitación en uso de sistemas de seguridad', 180),
('Diagnóstico de fallas en sistemas', 60),
('Optimización de redes para cámaras IP', 120),
('Asesoramiento en diseño de sistemas de seguridad', 90);


-- Insertar productos y servicios en la tabla Items
INSERT INTO Items (tipo_item, id_producto, id_servicio) VALUES
('Producto', 1, NULL), -- Cámara de seguridad 1080p
('Producto', 2, NULL), -- Cámara de seguridad 4K
('Producto', 3, NULL), -- Kit de cámaras de 4 unidades
('Producto', 4, NULL), -- Sensor de movimiento
('Producto', 5, NULL), -- Sirena para alarma
('Producto', 6, NULL), -- Control remoto para alarma
('Producto', 7, NULL), -- Kit de alarma completo
('Producto', 8, NULL), -- Cable coaxial 20m
('Producto', 9, NULL), -- Cable UTP 30m
('Producto', 10, NULL), -- Transformador 12V
('Producto', 11, NULL), -- Panel de control de alarma
('Producto', 12, NULL), -- Disco rígido 1TB
('Producto', 13, NULL), -- Disco rígido 2TB
('Producto', 14, NULL), -- Fuente de alimentación 5A
('Producto', 15, NULL), -- Conector BNC
('Producto', 16, NULL), -- Conector RJ45
('Producto', 17, NULL), -- DVR 4 canales
('Producto', 18, NULL), -- DVR 8 canales
('Producto', 19, NULL), -- DVR 16 canales
('Producto', 20, NULL), -- Monitor 21 pulgadas
('Producto', 21, NULL), -- Monitor 24 pulgadas
('Producto', 22, NULL), -- Micrófono ambiental
('Producto', 23, NULL), -- Soporte para cámara
('Producto', 24, NULL), -- Cámara IP 1080p
('Producto', 25, NULL), -- Cámara IP 4K
('Producto', 26, NULL), -- Videoportero básico
('Producto', 27, NULL), -- Videoportero avanzado
('Producto', 28, NULL), -- Control de acceso biométrico
('Producto', 29, NULL), -- Tarjetas RFID
('Producto', 30, NULL), -- Lector de tarjetas RFID
('Servicio', NULL, 1), -- Instalación de cámaras de seguridad
('Servicio', NULL, 2), -- Mantenimiento de sistemas de seguridad
('Servicio', NULL, 3), -- Configuración de alarmas
('Servicio', NULL, 4), -- Reparación de cámaras
('Servicio', NULL, 5), -- Actualización de firmware en DVR
('Servicio', NULL, 6), -- Instalación de videoporteros
('Servicio', NULL, 7), -- Capacitación en uso de sistemas de seguridad
('Servicio', NULL, 8), -- Diagnóstico de fallas en sistemas
('Servicio', NULL, 9), -- Optimización de redes para cámaras IP
('Servicio', NULL, 10); -- Asesoramiento en diseño de sistemas de seguridad


INSERT INTO Ventas (total, fecha_venta, id_cliente, id_empleado) VALUES
(35000.00, '2024-12-01', 1, 5),
(15000.00, '2024-12-02', 2, 3),
(20000.00, '2024-12-03', 3, 7),
(18000.00, '2024-12-04', 4, 2),
(24000.00, '2024-12-05', 5, 8),
(30000.00, '2024-12-06', 6, 4),
(22000.00, '2024-12-07', 7, 1),
(28000.00, '2024-12-08', 8, 6),
(25000.00, '2024-12-09', 9, 9),
(26000.00, '2024-12-10', 10, 10),
(31000.00, '2024-12-11', 11, 3),
(33000.00, '2024-12-12', 12, 2),
(35000.00, '2024-12-13', 13, 4),
(20000.00, '2024-12-14', 14, 5),
(22000.00, '2024-12-15', 15, 7),
(24000.00, '2024-12-16', 1, 6),
(21000.00, '2024-12-17', 2, 9),
(18000.00, '2024-12-18', 3, 10),
(27000.00, '2024-12-19', 4, 8),
(32000.00, '2024-12-20', 5, 1),
(28000.00, '2024-12-21', 6, 2),
(30000.00, '2024-12-22', 7, 3),
(33000.00, '2024-12-23', 8, 4),
(31000.00, '2024-12-24', 9, 5),
(35000.00, '2024-12-25', 10, 6),
(22000.00, '2024-12-26', 11, 7);

-- Inserción en DetalleVentas, cada venta incluye al menos dos items (productos o servicios)
INSERT INTO DetalleVentas (descuento, total_linea_venta, id_venta, id_item)
VALUES
(0.00, 12000.00, 26, 1),  -- Venta 26: Producto (Cámara de seguridad 1080p)
(0.00, 12000.00, 26, 10), -- Venta 26: Servicio (Instalación de cámaras de seguridad)

(0.00, 25000.00, 27, 2),  -- Venta 27: Producto (Cámara de seguridad 4K)
(0.00, 25000.00, 27, 7),  -- Venta 27: Servicio (Mantenimiento de sistemas de seguridad)

(0.00, 60000.00, 28, 3),  -- Venta 28: Producto (Kit de cámaras de 4 unidades)
(0.00, 60000.00, 28, 9),  -- Venta 28: Servicio (Configuración de alarmas)

(0.00, 8000.00, 29, 4),   -- Venta 29: Producto (Sensor de movimiento)
(0.00, 8000.00, 29, 6),   -- Venta 29: Servicio (Reparación de cámaras)

(0.00, 5000.00, 30, 5),   -- Venta 30: Producto (Sirena para alarma)
(0.00, 5000.00, 30, 4),   -- Venta 30: Servicio (Diagnóstico de fallas en sistemas)

(0.00, 20000.00, 31, 6),  -- Venta 31: Producto (Kit de alarma completo)
(0.00, 20000.00, 31, 8),  -- Venta 31: Servicio (Capacitación en uso de sistemas de seguridad)

(0.00, 1200.00, 32, 7),   -- Venta 32: Producto (Cable coaxial 20m)
(0.00, 1200.00, 32, 2),   -- Venta 32: Servicio (Actualización de firmware en DVR)

(0.00, 1500.00, 33, 8),   -- Venta 33: Producto (Cable UTP 30m)
(0.00, 1500.00, 33, 3),   -- Venta 33: Servicio (Optimización de redes para cámaras IP)

(0.00, 2500.00, 34, 9),   -- Venta 34: Producto (Transformador 12V)
(0.00, 2500.00, 34, 5),   -- Venta 34: Servicio (Instalación de videoporteros)

(0.00, 15000.00, 35, 10), -- Venta 35: Producto (Panel de control de alarma)
(0.00, 15000.00, 35, 7),  -- Venta 35: Servicio (Mantenimiento de sistemas de seguridad)

(0.00, 8000.00, 36, 11),  -- Venta 36: Producto (Disco rígido 1TB)
(0.00, 8000.00, 36, 6),   -- Venta 36: Servicio (Reparación de cámaras)

(0.00, 15000.00, 37, 12), -- Venta 37: Producto (Disco rígido 2TB)
(0.00, 15000.00, 37, 4),  -- Venta 37: Servicio (Diagnóstico de fallas en sistemas)

(0.00, 5000.00, 38, 13),  -- Venta 38: Producto (Fuente de alimentación 5A)
(0.00, 5000.00, 38, 2),   -- Venta 38: Servicio (Instalación de cámaras de seguridad)

(0.00, 4000.00, 39, 14),  -- Venta 39: Producto (Conector BNC)
(0.00, 4000.00, 39, 10),  -- Venta 39: Servicio (Capacitación en uso de sistemas de seguridad)

(0.00, 35000.00, 40, 15), -- Venta 40: Producto (DVR 4 canales)
(0.00, 35000.00, 40, 11), -- Venta 40: Servicio (Actualización de firmware en DVR)

(0.00, 10000.00, 41, 16), -- Venta 41: Producto (Monitor 21 pulgadas)
(0.00, 10000.00, 41, 6),  -- Venta 41: Servicio (Reparación de cámaras)

(0.00, 18000.00, 42, 17), -- Venta 42: Producto (Monitor 24 pulgadas)
(0.00, 18000.00, 42, 5),  -- Venta 42: Servicio (Instalación de videoporteros)

(0.00, 20000.00, 43, 18), -- Venta 43: Producto (Micrófono ambiental)
(0.00, 20000.00, 43, 7),  -- Venta 43: Servicio (Mantenimiento de sistemas de seguridad)

(0.00, 25000.00, 44, 19), -- Venta 44: Producto (Soporte para cámara)
(0.00, 25000.00, 44, 4),  -- Venta 44: Servicio (Diagnóstico de fallas en sistemas)

(0.00, 5000.00, 45, 20),  -- Venta 45: Producto (Cámara IP 1080p)
(0.00, 5000.00, 45, 1),   -- Venta 45: Servicio (Instalación de cámaras de seguridad)

(0.00, 30000.00, 46, 21), -- Venta 46: Producto (Cámara IP 4K)
(0.00, 30000.00, 46, 12), -- Venta 46: Servicio (Disco rígido 2TB)

(0.00, 4000.00, 47, 22),  -- Venta 47: Producto (Videoportero básico)
(0.00, 4000.00, 47, 8),   -- Venta 47: Servicio (Capacitación en uso de sistemas de seguridad)

(0.00, 15000.00, 48, 23), -- Venta 48: Producto (Videoportero avanzado)
(0.00, 15000.00, 48, 3),  -- Venta 48: Servicio (Optimización de redes para cámaras IP)

(0.00, 5000.00, 49, 24),  -- Venta 49: Producto (Control de acceso biométrico)
(0.00, 5000.00, 49, 9),   -- Venta 49: Servicio (Transformador 12V)

(0.00, 25000.00, 50, 25), -- Venta 50: Producto (Tarjetas RFID)
(0.00, 25000.00, 50, 2),  -- Venta 50: Servicio (Instalación de cámaras de seguridad)

(0.00, 18000.00, 51, 26); -- Venta 51: Producto (Lector de tarjetas RFID)
(0.00, 18000.00, 51, 6);  -- Venta 51: Servicio (Reparación de cámaras);


-- Inserciones en la tabla Compras
INSERT INTO Compras (total_compra, id_proveedor, id_empleado)
VALUES
(15000.00, 3, 5),   -- Compra 1
(25000.00, 2, 8),   -- Compra 2
(35000.00, 5, 10),  -- Compra 3
(22000.00, 1, 4),   -- Compra 4
(18000.00, 6, 3),   -- Compra 5
(30000.00, 7, 6),   -- Compra 6
(12000.00, 4, 9),   -- Compra 7
(5000.00, 3, 7),    -- Compra 8
(40000.00, 2, 12),  -- Compra 9
(20000.00, 1, 11),  -- Compra 10
(27000.00, 8, 13),  -- Compra 11
(18000.00, 6, 14),  -- Compra 12
(35000.00, 5, 8),   -- Compra 13
(25000.00, 4, 2),   -- Compra 14
(28000.00, 7, 5);   -- Compra 15


-- Detalles de compra para la compra 1
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(2, 0.00, 12000.00, 24000.00, 1, 1),  -- Producto: Cámara de seguridad 1080p
(1, 500.00, 2500.00, 2500.00, 5, 1);  -- Producto: Sirena para alarma

-- Detalles de compra para la compra 2
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(3, 200.00, 15000.00, 45000.00, 10, 2), -- Producto: Panel de control de alarma
(5, 100.00, 5000.00, 25000.00, 2, 2);  -- Producto: Cámara de seguridad 4K

-- Detalles de compra para la compra 3
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(1, 0.00, 25000.00, 25000.00, 7, 3),  -- Producto: Kit de alarma completo
(2, 0.00, 8000.00, 16000.00, 16, 3);  -- Producto: DVR 4 canales

-- Detalles de compra para la compra 4
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(5, 300.00, 1500.00, 7500.00, 9, 4),  -- Producto: Cable UTP 30m
(3, 200.00, 5000.00, 15000.00, 3, 4); -- Producto: Sensor de movimiento

-- Detalles de compra para la compra 5
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(2, 0.00, 5000.00, 10000.00, 19, 5),  -- Producto: Monitor 21 pulgadas
(1, 0.00, 35000.00, 35000.00, 20, 5); -- Producto: DVR 8 canales

-- Detalles de compra para la compra 6
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(3, 0.00, 12000.00, 36000.00, 6, 6),  -- Producto: Control remoto para alarma
(4, 0.00, 1000.00, 4000.00, 15, 6);  -- Producto: Conector BNC

-- Detalles de compra para la compra 7
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(2, 100.00, 12000.00, 24000.00, 4, 7),  -- Producto: Cable coaxial 20m
(1, 0.00, 20000.00, 20000.00, 18, 7);  -- Producto: DVR 16 canales

-- Detalles de compra para la compra 8
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(1, 0.00, 35000.00, 35000.00, 9, 8),  -- Producto: Fuente de alimentación 5A
(3, 0.00, 18000.00, 54000.00, 14, 8); -- Producto: Disco rígido 1TB

-- Detalles de compra para la compra 9
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(2, 500.00, 15000.00, 30000.00, 17, 9),  -- Producto: DVR 4 canales
(3, 0.00, 3000.00, 9000.00, 16, 9);    -- Producto: Soporte para cámara

-- Detalles de compra para la compra 10
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(3, 100.00, 18000.00, 54000.00, 10, 10), -- Producto: Dispositivo de videoportero
(1, 1000.00, 35000.00, 35000.00, 15, 10); -- Producto: DVR 8 canales

-- Detalles de compra para la compra 11
INSERT INTO DetalleCompras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
VALUES
(3, 200.00, 2000.00, 6000.00, 3, 11), -- Producto: Control de acceso biométrico
(5, 0.00, 1000.00, 5000.00, 13, 11); -- Producto: Tarjetas RFID

-- Creacion de vista 1 ventas por cliente
CREATE VIEW VentasPorCliente AS
SELECT 
    c.id_cliente,
    c.nombre_cliente,
    SUM(v.total) AS total_ventas
FROM 
    Clientes c
JOIN 
    Ventas v ON c.id_cliente = v.id_cliente
GROUP BY 
    c.id_cliente, c.nombre_cliente;

-- Creacion de vista 2 mejores vendedores ultimo mes

CREATE VIEW MejoresVendedoresUltimoMes AS
SELECT 
    e.id_empleado,
    e.nombre_empleado,
    SUM(v.total) AS total_vendido
FROM 
    Empleados e
JOIN 
    Ventas v ON e.id_empleado = v.id_empleado
WHERE 
    MONTH(v.fecha_venta) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
    AND YEAR(v.fecha_venta) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY 
    e.id_empleado, e.nombre_empleado
ORDER BY 
    total_vendido DESC
LIMIT 5;


-- FUNCIONES

-- Creacion de funcion 1 descuento por cliente

DELIMITER $$

CREATE FUNCTION PromedioDescuentoPorCliente(id_cliente INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    -- Declaramos una variable para almacenar el promedio
    DECLARE promedio_descuento DECIMAL(10, 2);
    
    -- Calculamos el promedio de descuento
    SELECT 
        AVG(dv.descuento) INTO promedio_descuento
    FROM 
        Ventas v
    JOIN 
        Detalle_Ventas dv ON v.id_venta = dv.id_venta
    WHERE 
        v.id_cliente = id_cliente;

    -- Retornamos el promedio
    RETURN IFNULL(promedio_descuento, 0);
END$$

DELIMITER ;


-- Creacion de funcion 2 porcentaje de servicios adquiridos por cliente

DELIMITER $$

CREATE FUNCTION PorcentajeVentasServiciosPorCliente(id_cliente INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    -- Variables para almacenar el total de ventas y las ventas de servicios
    DECLARE total_ventas_cliente DECIMAL(10, 2);
    DECLARE total_servicios_cliente DECIMAL(10, 2);
    DECLARE porcentaje_servicios DECIMAL(10, 2);

    -- Calculamos el total de ventas del cliente
    SELECT 
        SUM(dv.total_linea_venta) INTO total_ventas_cliente
    FROM 
        Ventas v
    JOIN 
        Detalle_Ventas dv ON v.id_venta = dv.id_venta
    WHERE 
        v.id_cliente = id_cliente;

    -- Calculamos el total de ventas de servicios del cliente
    SELECT 
        SUM(dv.total_linea_venta) INTO total_servicios_cliente
    FROM 
        Ventas v
    JOIN 
        Detalle_Ventas dv ON v.id_venta = dv.id_venta
    JOIN 
        Items i ON dv.id_item = i.id_item
    WHERE 
        v.id_cliente = id_cliente
        AND i.tipo_item = 'Servicio';

    -- Calculamos el porcentaje de ventas de servicios
    SET porcentaje_servicios = IFNULL((total_servicios_cliente / total_ventas_cliente) * 100, 0);

    -- Retornamos el porcentaje
    RETURN porcentaje_servicios;
END$$

DELIMITER ;


-- Cfreamos el Store Procedure 1, insercion de nuevos productos

DELIMITER //

CREATE PROCEDURE AgregarProducto(
    IN p_nombre_producto VARCHAR(30),
    IN p_precio_unitario DECIMAL(10, 2),
    IN p_stock INT
)
BEGIN
    -- Verificar si el producto ya existe
    IF EXISTS (SELECT 1 FROM Productos WHERE nombre_producto = p_nombre_producto) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto ya existe en el inventario.';
    ELSE
        -- Insertar el nuevo producto
        INSERT INTO Productos (nombre_producto, precio_unitario, stock)
        VALUES (p_nombre_producto, p_precio_unitario, p_stock);
    END IF;
END;
//

DELIMITER ;


-- Creacion de Store Procedure 2 , hacer una compra y actualizar el stock del producto

DELIMITER $$

CREATE PROCEDURE RegistrarCompraYActualizarStock(
    IN p_id_proveedor INT,
    IN p_id_empleado INT,
    IN p_id_producto INT,
    IN p_cantidad INT,
    IN p_precio_unitario DECIMAL(10,2)
)
BEGIN
    DECLARE v_total_compra DECIMAL(10,2);

    -- Calcular el total de la compra
    SET v_total_compra = p_precio_unitario * p_cantidad;

    -- Registrar la compra en la tabla Compras
    INSERT INTO Compras (total_compra, id_proveedor, id_empleado)
    VALUES (v_total_compra, p_id_proveedor, p_id_empleado);

    -- Obtener el ID de la compra registrada
    DECLARE v_id_compra INT;
    SET v_id_compra = LAST_INSERT_ID();

    -- Insertar el detalle de la compra
    INSERT INTO Detalle_Compras (cantidad, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
    VALUES (p_cantidad, p_precio_unitario, v_total_compra, p_id_producto, v_id_compra);

    -- Actualizar el stock del producto
    UPDATE Productos
    SET stock = stock + p_cantidad
    WHERE id_producto = p_id_producto;

    -- Mensaje de confirmación
    SELECT CONCAT('Compra registrada con ID: ', v_id_compra) AS Mensaje;
END $$

DELIMITER ;


-- Creacion del Store Procedure 3, hacer una venta de un producto y actualizar stock

DELIMITER $$

CREATE PROCEDURE RegistrarVentaConDetalleSimple(
    IN p_total DECIMAL(10, 2),
    IN p_fecha DATE,
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    -- Declarar variables locales
    DECLARE v_id_venta INT;

    -- Insertar en la tabla Ventas
    INSERT INTO Ventas (total, fecha_venta, id_cliente, id_empleado)
    VALUES (p_total, p_fecha, p_id_cliente, p_id_empleado);

    -- Obtener el ID de la venta recién insertada
    SET v_id_venta = LAST_INSERT_ID();

    -- Insertar en la tabla Detalle_Ventas
    INSERT INTO Detalle_Ventas (descuento, total_linea_venta, cantidad, id_venta, id_item)
    VALUES (
        0,  -- Descuento por defecto
        p_total,  -- Total línea
        p_cantidad,  -- Cantidad
        v_id_venta,  -- ID de la venta
        (SELECT id_item FROM Items WHERE id_producto = p_id_producto) -- ID del item correspondiente al producto
    );

    -- Actualizar el stock del producto
    UPDATE Productos
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;
END$$

DELIMITER ;

-- Creacion de Trigger para tener en una tabla do.en se vea la modificacion de precios 


-- 1)primero creamos la tabla

CREATE TABLE Historial_Precios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(10, 2),
    precio_nuevo DECIMAL(10, 2),
    fecha_cambio DATETIME,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- ahora creamos el trigger
DELIMITER //

CREATE TRIGGER HistorialPrecioProducto
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.precio_unitario <> NEW.precio_unitario THEN
        INSERT INTO Historial_Precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (NEW.id_producto, OLD.precio_unitario, NEW.precio_unitario, NOW());
    END IF;
END //

DELIMITER ;

-- Creacion de Trigger 2 Registro de modificaciones de stock

--1) creamos la tabla

CREATE TABLE Historial_Stock (
    id_historial_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    cantidad_anterior INT,
    cantidad_nueva INT,
    tipo_cambio ENUM('Aumento', 'Disminución'),
    fecha_cambio DATETIME,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);


-- ahora creamos el trigger

DELIMITER //

CREATE TRIGGER HistorialStockProducto
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.stock <> NEW.stock THEN
        -- Insertamos el cambio de stock en el historial
        INSERT INTO Historial_Stock (id_producto, cantidad_anterior, cantidad_nueva, tipo_cambio, fecha_cambio)
        VALUES (NEW.id_producto, OLD.stock, NEW.stock, 
            IF(NEW.stock > OLD.stock, 'Aumento', 'Disminución'), NOW());
    END IF;
END //

DELIMITER ;


