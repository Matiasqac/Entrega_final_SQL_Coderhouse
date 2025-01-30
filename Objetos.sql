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
    id_producto INT NULL,
    id_servicio INT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio),
    CHECK (
        (id_producto IS NOT NULL AND id_servicio IS NULL) OR
        (id_producto IS NULL AND id_servicio IS NOT NULL)
    )
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
    fecha_compra DATE NOT NULL,
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

-- Tabla Historial de Precios
CREATE TABLE Historial_Precios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(10, 2),
    precio_nuevo DECIMAL(10, 2),
    fecha_cambio DATETIME,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla Historial de Stock
CREATE TABLE Historial_Stock (
    id_historial_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    cantidad_anterior INT,
    cantidad_nueva INT,
    tipo_cambio ENUM('Aumento', 'Disminución'),
    fecha_cambio DATETIME,
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);


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
    -- Declarar variables locales al inicio del bloque
    DECLARE v_total_compra DECIMAL(10,2);
    DECLARE v_id_compra INT;

    -- Calcular el total de la compra
    SET v_total_compra = p_precio_unitario * p_cantidad;

    -- Registrar la compra en la tabla Compras
    INSERT INTO Compras (total_compra, id_proveedor, id_empleado)
    VALUES (v_total_compra, p_id_proveedor, p_id_empleado);

    -- Obtener el ID de la compra registrada
    SET v_id_compra = LAST_INSERT_ID();

    -- Insertar el detalle de la compra
    INSERT INTO Detalle_Compras (cantidad, descuento, precio_unitario_compra, total_linea_compra, id_producto, id_compra)
    VALUES (p_cantidad, 0, p_precio_unitario, v_total_compra, p_id_producto, v_id_compra);

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



-- Trigger Historial de Precio Producto
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

-- Trigger Historial de Stock Producto
DELIMITER //
CREATE TRIGGER HistorialStockProducto
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.stock <> NEW.stock THEN
        INSERT INTO Historial_Stock (id_producto, cantidad_anterior, cantidad_nueva, tipo_cambio, fecha_cambio)
        VALUES (NEW.id_producto, OLD.stock, NEW.stock, IF(NEW.stock > OLD.stock, 'Aumento', 'Disminución'), NOW());
    END IF;
END //
DELIMITER ;

