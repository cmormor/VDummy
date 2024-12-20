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
    id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    ubicacion VARCHAR(255)
);

-- Crear tabla de tallas por tienda
CREATE TABLE tallas_por_tienda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tienda_id INT,  -- Relación con la tabla tiendas
    talla VARCHAR(2) NOT NULL,  -- S, M, L, XL
    pecho DECIMAL(5, 2) NOT NULL,
    cintura DECIMAL(5, 2) NOT NULL,
    cadera DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (tienda_id) REFERENCES tiendas(id),
    UNIQUE(tienda_id, talla)  -- No puede haber dos veces la misma talla en una tienda
);

-- Crear tabla de prendas
CREATE TABLE prendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    talla_id INT,  -- Relación con la tabla tallas_por_tienda
    tienda_id INT,  -- Relación con la tabla tiendas
    tipo_tela VARCHAR(255) NOT NULL,  -- Tipo de tela de la prenda
    ajuste VARCHAR(255) NOT NULL,  -- Ajuste de la prenda (Ajustada, Sueltita, Regular)
    cantidad INT NOT NULL,  -- Campo para controlar el stock
    FOREIGN KEY (talla_id) REFERENCES tallas_por_tienda(id),
    FOREIGN KEY (tienda_id) REFERENCES tiendas(id)
);

-- Crear tabla de carrito
CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,  -- Relación con la tabla usuarios
    prenda_id INT,   -- Relación con la tabla prendas
    talla_id INT,    -- Relación con la tabla tallas_por_tienda
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (prenda_id) REFERENCES prendas(id),
    FOREIGN KEY (talla_id) REFERENCES tallas_por_tienda(id)
);

-- Inserts en tabla tiendas
INSERT INTO tiendas (descripcion, ubicacion) 
VALUES 
    ('Luxury Fashion', 'Calle Principal 123'),
    ('Sporty Shop', 'Avenida Norte 456'),
    ('Casual Wear', 'Calle Sur 789');

-- Inserts en tabla tallas_por_tienda (ahora con 4 tallas por tienda)
-- Para "Luxury Fashion"
INSERT INTO tallas_por_tienda (tienda_id, talla, pecho, cintura, cadera) 
VALUES 
    (1, 'S', 85.0, 70.0, 90.0),
    (1, 'M', 95.0, 80.0, 100.0),
    (1, 'L', 105.0, 90.0, 110.0),
    (1, 'XL', 115.0, 100.0, 120.0);

-- Para "Sporty Shop"
INSERT INTO tallas_por_tienda (tienda_id, talla, pecho, cintura, cadera) 
VALUES 
    (2, 'S', 80.0, 65.0, 85.0),
    (2, 'M', 90.0, 75.0, 95.0),
    (2, 'L', 100.0, 85.0, 105.0),
    (2, 'XL', 110.0, 95.0, 115.0);

-- Para "Casual Wear"
INSERT INTO tallas_por_tienda (tienda_id, talla, pecho, cintura, cadera) 
VALUES 
    (3, 'S', 80.0, 65.0, 85.0),
    (3, 'M', 90.0, 75.0, 95.0),
    (3, 'L', 100.0, 85.0, 105.0),
    (3, 'XL', 110.0, 95.0, 115.0);

-- Insertar prendas para "Luxury Fashion"
INSERT INTO prendas (nombre, descripcion, precio, talla_id, tienda_id, tipo_tela, ajuste, cantidad) 
VALUES
    ('Vestido Largo', 'Vestido largo de seda para eventos elegantes.', 120.00, 1, 1, 'Seda', 'Ajustada', 10),
    ('Vestido Corto', 'Vestido corto de terciopelo ideal para fiestas.', 100.00, 2, 1, 'Terciopelo', 'Regular', 5),
    ('Mono', 'Mono de manga larga para ocasiones formales.', 150.00, 3, 1, 'Algodón', 'Ajustada', 7),
    ('Abrigo', 'Abrigo de lana con un toque sofisticado.', 200.00, 4, 1, 'Lana', 'Sueltita', 3);

-- Insertar prendas para "Sporty Shop"
INSERT INTO prendas (nombre, descripcion, precio, talla_id, tienda_id, tipo_tela, ajuste, cantidad) 
VALUES
    ('Camiseta Deportiva', 'Camiseta deportiva ligera para entrenamiento.', 25.00, 2, 2, 'Poliéster', 'Regular', 15),
    ('Pantalón de Chándal', 'Pantalón de chándal cómodo para hacer deporte.', 30.00, 3, 2, 'Algodón', 'Regular', 20),
    ('Sudadera de Chándal', 'Sudadera con capucha para entrenamiento y descanso.', 35.00, 4, 2, 'Poliéster', 'Sueltita', 10),
    ('Mallas Deportivas', 'Mallas ajustadas para correr o hacer ejercicio.', 20.00, 1, 2, 'Elastano', 'Ajustada', 25);

-- Insertar prendas para "Casual Wear"
INSERT INTO prendas (nombre, descripcion, precio, talla_id, tienda_id, tipo_tela, ajuste, cantidad) 
VALUES
    ('Vaquero', 'Jeans de corte recto, muy cómodos para el día a día.', 50.00, 3, 3, 'Denim', 'Regular', 30),
    ('Camiseta Oversize', 'Camiseta oversized, ideal para un look casual.', 30.00, 4, 3, 'Algodón', 'Sueltita', 40),
    ('Camiseta Ajustada', 'Camiseta ajustada para un look más entallado.', 25.00, 2, 3, 'Algodón', 'Ajustada', 50),
    ('Chaqueta', 'Chaqueta ligera de algodón para el otoño.', 70.00, 1, 3, 'Algodón', 'Regular', 15);

-- Verificar los datos insertados
SELECT * FROM tiendas;
SELECT * FROM tallas_por_tienda;
SELECT * FROM prendas;
