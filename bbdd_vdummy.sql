CREATE DATABASE v_dummy;
USE v_dummy;

-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    altura DECIMAL(5, 2) NOT NULL,
    pecho DECIMAL(5, 2) NOT NULL,
    cintura DECIMAL(5, 2) NOT NULL,
    cadera DECIMAL(5, 2) NOT NULL
);

-- Crear tabla de tiendas
CREATE TABLE tiendas (
    nombre VARCHAR(255) PRIMARY KEY,  -- Nombre de la tienda como clave primaria
    descripcion TEXT,
    ubicacion VARCHAR(255)
);

-- Crear tabla de tallas por tienda
CREATE TABLE tallas_por_tienda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tienda_nombre VARCHAR(255),  -- Relación con el nombre de la tienda
    talla VARCHAR(2) NOT NULL,  -- S, M, L, XL
    pecho DECIMAL(5, 2) NOT NULL,
    cintura DECIMAL(5, 2) NOT NULL,
    cadera DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (tienda_nombre) REFERENCES tiendas(nombre),
    UNIQUE(tienda_nombre, talla)  -- No puede haber dos veces la misma talla en una tienda
);

-- Crear tabla de prendas
CREATE TABLE prendas (
    nombre VARCHAR(255) PRIMARY KEY,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    talla_id INT,  -- Relación con la tabla tallas_por_tienda
    tienda_nombre VARCHAR(255),  -- Relación con el nombre de la tienda
    tipo_tela VARCHAR(255) NOT NULL,  -- Tipo de tela de la prenda
    ajuste VARCHAR(255) NOT NULL,  -- Ajuste de la prenda (Ajustada, Sueltita, Regular)
    cantidad INT NOT NULL,  -- Campo para controlar el stock
    FOREIGN KEY (talla_id) REFERENCES tallas_por_tienda(id),
    FOREIGN KEY (tienda_nombre) REFERENCES tiendas(nombre)
);

-- Crear tabla de carrito
CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,  -- Relación con la tabla usuarios
    prenda_id INT,   -- Relación con la tabla prendas
    talla_id INT,    -- Relación con la tabla tallas_por_tienda
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (prenda_id) REFERENCES prendas(nombre),
    FOREIGN KEY (talla_id) REFERENCES tallas_por_tienda(id)
);

-- Inserts en tabla tiendas
INSERT INTO tiendas (nombre, descripcion, ubicacion) 
VALUES 
    ('Luxury Fashion', 'Tienda de ropa de alta gama', 'Calle Principal 123'),
    ('Sporty Shop', 'Tienda deportiva para entrenamiento', 'Avenida Norte 456'),
    ('Casual Wear', 'Tienda de ropa casual', 'Calle Sur 789');

-- Inserts en tabla tallas_por_tienda (ahora con 4 tallas por tienda)
-- Para "Luxury Fashion"
INSERT INTO tallas_por_tienda (tienda_nombre, talla, pecho, cintura, cadera) 
VALUES 
    ('Luxury Fashion', 'S', 85.0, 70.0, 90.0),
    ('Luxury Fashion', 'M', 95.0, 80.0, 100.0),
    ('Luxury Fashion', 'L', 105.0, 90.0, 110.0),
    ('Luxury Fashion', 'XL', 115.0, 100.0, 120.0);

-- Para "Sporty Shop"
INSERT INTO tallas_por_tienda (tienda_nombre, talla, pecho, cintura, cadera) 
VALUES 
    ('Sporty Shop', 'S', 80.0, 65.0, 85.0),
    ('Sporty Shop', 'M', 90.0, 75.0, 95.0),
    ('Sporty Shop', 'L', 100.0, 85.0, 105.0),
    ('Sporty Shop', 'XL', 110.0, 95.0, 115.0);

-- Para "Casual Wear"
INSERT INTO tallas_por_tienda (tienda_nombre, talla, pecho, cintura, cadera) 
VALUES 
    ('Casual Wear', 'S', 80.0, 65.0, 85.0),
    ('Casual Wear', 'M', 90.0, 75.0, 95.0),
    ('Casual Wear', 'L', 100.0, 85.0, 105.0),
    ('Casual Wear', 'XL', 110.0, 95.0, 115.0);

-- Insertar prendas para "Luxury Fashion"
INSERT INTO prendas (nombre, descripcion, precio, talla_id, tienda_nombre, tipo_tela, ajuste, cantidad) 
VALUES
    ('Vestido Largo', 'Vestido largo de seda para eventos elegantes.', 120.00, 1, 'Luxury Fashion', 'Seda', 'Ajustada', 10),
    ('Vestido Corto', 'Vestido corto de terciopelo ideal para fiestas.', 100.00, 2, 'Luxury Fashion', 'Terciopelo', 'Regular', 5),
    ('Mono', 'Mono de manga larga para ocasiones formales.', 150.00, 3, 'Luxury Fashion', 'Algodón', 'Ajustada', 7),
    ('Abrigo', 'Abrigo de lana con un toque sofisticado.', 200.00, 4, 'Luxury Fashion', 'Lana', 'Sueltita', 3);

-- Insertar prendas para "Sporty Shop"
INSERT INTO prendas (nombre, descripcion, precio, talla_id, tienda_nombre, tipo_tela, ajuste, cantidad) 
VALUES
    ('Camiseta Deportiva', 'Camiseta deportiva ligera para entrenamiento.', 25.00, 2, 'Sporty Shop', 'Poliéster', 'Regular', 15),
    ('Pantalón de Chándal', 'Pantalón de chándal cómodo para hacer deporte.', 30.00, 3, 'Sporty Shop', 'Algodón', 'Regular', 20),
    ('Sudadera de Chándal', 'Sudadera con capucha para entrenamiento y descanso.', 35.00, 4, 'Sporty Shop', 'Poliéster', 'Sueltita', 10),
    ('Mallas Deportivas', 'Mallas ajustadas para correr o hacer ejercicio.', 20.00, 1, 'Sporty Shop', 'Elastano', 'Ajustada', 25);

-- Insertar prendas para "Casual Wear"
INSERT INTO prendas (nombre, descripcion, precio, talla_id, tienda_nombre, tipo_tela, ajuste, cantidad) 
VALUES
    ('Vaquero', 'Jeans de corte recto, muy cómodos para el día a día.', 50.00, 3, 'Casual Wear', 'Denim', 'Regular', 30),
    ('Camiseta Oversize', 'Camiseta oversized, ideal para un look casual.', 30.00, 4, 'Casual Wear', 'Algodón', 'Sueltita', 40),
    ('Camiseta Ajustada', 'Camiseta ajustada para un look más entallado.', 25.00, 2, 'Casual Wear', 'Algodón', 'Ajustada', 50),
    ('Chaqueta', 'Chaqueta ligera de algodón para el otoño.', 70.00, 1, 'Casual Wear', 'Algodón', 'Regular', 15);

-- Verificar los datos insertados
SELECT * FROM tiendas;
SELECT * FROM tallas_por_tienda;
SELECT * FROM prendas;
