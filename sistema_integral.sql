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



