-- ==========================================
-- RETAILPRO - BASE DE DATOS DE VENTAS
-- ==========================================


-- ==========================================
-- 1. ELIMINAR TABLAS SI YA EXISTEN
-- ==========================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


-- ==========================================
-- 2. CREACIÓN DE TABLAS
-- ==========================================

-- Tabla de categorías
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);


-- Tabla de productos
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    categoria_id INT NOT NULL,
    
    FOREIGN KEY (categoria_id)
        REFERENCES categorias(id_categoria)
);


-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);


-- Tabla de ventas
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    
    FOREIGN KEY (cliente_id)
        REFERENCES clientes(id_cliente),
        
    FOREIGN KEY (producto_id)
        REFERENCES productos(id_producto)
);


-- ==========================================
-- 3. CARGA DE CATEGORÍAS
-- ==========================================

INSERT INTO categorias (id_categoria, nombre)
VALUES
(1, 'Computación'),
(2, 'Celulares'),
(3, 'Audio');


-- ==========================================
-- 4. CARGA DE PRODUCTOS
-- ==========================================

INSERT INTO productos 
(id_producto, nombre, precio, categoria_id)
VALUES
(1, 'Notebook Lenovo', 850000.00, 1),
(2, 'Mouse Logitech', 25000.00, 1),
(3, 'Teclado Redragon', 45000.00, 1),
(4, 'Smartphone Samsung', 650000.00, 2),
(5, 'Auriculares Sony', 120000.00, 3);


-- ==========================================
-- 5. CARGA DE CLIENTES
-- ==========================================

INSERT INTO clientes 
(id_cliente, nombre, email, ciudad)
VALUES
(1, 'Ana Gomez', 'ana@email.com', 'Luján'),
(2, 'Juan Perez', 'juan@email.com', 'Moreno'),
(3, 'Sofia Martinez', 'sofia@email.com', 'Mercedes');


-- ==========================================
-- 6. CARGA DE VENTAS
-- ==========================================

INSERT INTO ventas
(id_venta, fecha, cliente_id, producto_id, cantidad)
VALUES
(1, '2026-08-01', 1, 1, 1),
(2, '2026-08-02', 2, 2, 2),
(3, '2026-08-03', 3, 5, 1),
(4, '2026-08-04', 1, 3, 1),
(5, '2026-08-05', 2, 4, 1),
(6, '2026-08-06', 3, 2, 3),
(7, '2026-08-07', 1, 5, 2),
(8, '2026-08-08', 2, 3, 1),
(9, '2026-08-09', 3, 4, 1),
(10, '2026-08-10', 1, 2, 2);