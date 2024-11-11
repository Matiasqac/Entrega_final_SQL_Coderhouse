-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS sistema_integral;
USE sistema_integral;

-- Tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(50),
    genero ENUM('masculino', 'femenino', 'otro'),
    ubicacion VARCHAR(50),
    fecha_nacimiento DATE,
    fecha_registro DATE,
    categoria VARCHAR(15)
);

-- Tabla Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proveedor VARCHAR(50),
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    metodo_pago VARCHAR(30)
);

-- Tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empleado VARCHAR(50),
    ubicacion_empleado VARCHAR(50),
    fecha_nacimiento_empleado DATE,
    area_empleado ENUM('Administracion', 'Ventas', 'Tecnico')
);

-- Tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50),
    precio_unitario DECIMAL(10, 2),
    stock INT
);

-- Tabla Servicios
CREATE TABLE IF NOT EXISTS Servicios (
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50),
    tiempo_estimado INT
);

-- Tabla Items (intermedia para agrupar productos y servicios)
CREATE TABLE IF NOT EXISTS Items (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    tipo_item ENUM('Producto', 'Servicio') NOT NULL,
    id_producto INT DEFAULT NULL,
    id_servicio INT DEFAULT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) ON DELETE SET NULL,
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio) ON DELETE SET NULL
);

-- Tabla Ventas
CREATE TABLE IF NOT EXISTS Ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    total DECIMAL(10, 2),
    fecha_venta DATE,
    id_cliente INT,
    id_empleado INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- Tabla DetalleVentas
CREATE TABLE IF NOT EXISTS DetalleVentas (
    id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
    descuento DECIMAL(10, 2),
    total_linea_venta DECIMAL(10, 2),
    id_venta INT,
    id_item INT,
    id_empleado INT,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_item) REFERENCES Items(id_item),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- Tabla Compras
CREATE TABLE IF NOT EXISTS Compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    total_compra DECIMAL(10, 2),
    id_proveedor INT,
    id_empleado INT,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- Tabla DetalleCompras
CREATE TABLE IF NOT EXISTS DetalleCompras (
    id_detalle_compra INT PRIMARY KEY AUTO_INCREMENT,
    cantidad INT,
    descuento DECIMAL(10, 2),
    precio_unitario_compra DECIMAL(10, 2),
    total_linea_compra DECIMAL(10, 2),
    id_producto INT,
    id_compra INT,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_compra) REFERENCES Compras(id_compra)
);
