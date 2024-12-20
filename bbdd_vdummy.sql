-- Crear base de datos
CREATE DATABASE v_dummy;
USE v_dummy;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    altura DECIMAL(5, 2) NOT NULL,
    pecho DECIMAL(5, 2) NOT NULL,
    cintura DECIMAL(5, 2) NOT NULL,
    cadera DECIMAL(5, 2) NOT NULL
);

-- Tabla de tiendas (usando el nombre como id)
CREATE TABLE tiendas (
    id VARCHAR(255) PRIMARY KEY,
    descripcion TEXT,
    ubicacion VARCHAR(255)
);

-- Tabla de tallas por tienda (cada tienda tiene sus propias tallas)
CREATE TABLE tallas_por_tienda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tienda_id VARCHAR(255),  -- Relación con la tabla tiendas (ahora id es el nombre)
    talla VARCHAR(2) NOT NULL,  -- S, M, L, XL
    pecho DECIMAL(5, 2) NOT NULL,
    cintura DECIMAL(5, 2) NOT NULL,
    cadera DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (tienda_id) REFERENCES tiendas(id),
    UNIQUE(tienda_id, talla)  -- No puede haber dos veces la misma talla en una tienda
);

-- Tabla de prendas (usando el nombre como id)
CREATE TABLE prendas (
    id VARCHAR(255) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    talla_id INT,  -- Relación con la tabla tallas_por_tienda
    tienda_id VARCHAR(255),  -- Relación con la tabla tiendas
    tipo_tela VARCHAR(255) NOT NULL,  -- Tipo de tela de la prenda
    ajuste VARCHAR(255) NOT NULL,  -- Ajuste de la prenda (Ajustada, Sueltita, Regular)
    cantidad INT NOT NULL,  -- Campo para controlar el stock
    FOREIGN KEY (talla_id) REFERENCES tallas_por_tienda(id),
    FOREIGN KEY (tienda_id) REFERENCES tiendas(id)
);

-- Tabla de carrito (opcional)
CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,  -- Relación con la tabla usuarios
    prenda_id VARCHAR(255),   -- Relación con la tabla prendas (ahora el id es el nombre)
    talla_id INT,    -- Relación con la tabla tallas_por_tienda
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (prenda_id) REFERENCES prendas(id),
    FOREIGN KEY (talla_id) REFERENCES tallas_por_tienda(id)
);

-- Insertar tiendas (id será el nombre de la tienda)
INSERT INTO tiendas (id, descripcion, ubicacion) VALUES
('Tienda Elegante', 'Ropa de alta calidad para ocasiones especiales.', 'Centro Comercial A'),
('Sporty Shop', 'Ropa deportiva cómoda y de calidad para entrenar y hacer deporte.', 'Centro Deportivo B'),
('Casual Wear', 'Ropa casual para el día a día con estilo moderno.', 'Centro Comercial C');

-- Insertar tallas por tienda (referenciando tiendas por su nombre)
-- Tienda Elegante (Tallas más pequeñas)
INSERT INTO tallas_por_tienda (tienda_id, talla, pecho, cintura, cadera) VALUES
('Tienda Elegante', 'S', 85, 65, 90),
('Tienda Elegante', 'M', 90, 70, 95),
('Tienda Elegante', 'L', 95, 75, 100),
('Tienda Elegante', 'XL', 100, 80, 105);

-- Sporty Shop (Tallas normales)
INSERT INTO tallas_por_tienda (tienda_id, talla, pecho, cintura, cadera) VALUES
('Sporty Shop', 'S', 90, 75, 95),
('Sporty Shop', 'M', 95, 80, 100),
('Sporty Shop', 'L', 100, 85, 105),
('Sporty Shop', 'XL', 105, 90, 110);

-- Casual Wear (Tallas más grandes)
INSERT INTO tallas_por_tienda (tienda_id, talla, pecho, cintura, cadera) VALUES
('Casual Wear', 'S', 95, 80, 105),
('Casual Wear', 'M', 100, 85, 110),
('Casual Wear', 'L', 105, 90, 115),
('Casual Wear', 'XL', 110, 95, 120);

-- Insertar prendas para Tienda Elegante (id será el nombre de la prenda)
INSERT INTO prendas (id, nombre, descripcion, precio, talla_id, tienda_id, tipo_tela, ajuste, cantidad) VALUES
('Vestido Largo', 'Vestido largo de seda para eventos elegantes.', 120.00, 1, 'Tienda Elegante', 'Seda', 'Ajustada', 10),
('Vestido Corto', 'Vestido corto de terciopelo ideal para fiestas.', 100.00, 2, 'Tienda Elegante', 'Terciopelo', 'Regular', 5),
('Mono', 'Mono de manga larga para ocasiones formales.', 150.00, 3, 'Tienda Elegante', 'Algodón', 'Ajustada', 7),
('Abrigo', 'Abrigo de lana con un toque sofisticado.', 200.00, 4, 'Tienda Elegante', 'Lana', 'Sueltita', 3);

-- Insertar prendas para Sporty Shop (id será el nombre de la prenda)
INSERT INTO prendas (id, nombre, descripcion, precio, talla_id, tienda_id, tipo_tela, ajuste, cantidad) VALUES
('Camiseta Deportiva', 'Camiseta deportiva ligera para entrenamiento.', 25.00, 2, 'Sporty Shop', 'Poliéster', 'Regular', 15),
('Pantalón de Chándal', 'Pantalón de chándal cómodo para hacer deporte.', 30.00, 3, 'Sporty Shop', 'Algodón', 'Regular', 20),
('Sudadera de Chándal', 'Sudadera con capucha para entrenamiento y descanso.', 35.00, 4, 'Sporty Shop', 'Poliéster', 'Sueltita', 10),
('Mallas Deportivas', 'Mallas ajustadas para correr o hacer ejercicio.', 20.00, 1, 'Sporty Shop', 'Elastano', 'Ajustada', 25);

-- Insertar prendas para Casual Wear (id será el nombre de la prenda)
INSERT INTO prendas (id, nombre, descripcion, precio, talla_id, tienda_id, tipo_tela, ajuste, cantidad) VALUES
('Vaquero', 'Jeans de corte recto, muy cómodos para el día a día.', 50.00, 3, 'Casual Wear', 'Denim', 'Regular', 30),
('Camiseta Oversize', 'Camiseta oversized, ideal para un look casual.', 30.00, 4, 'Casual Wear', 'Algodón', 'Sueltita', 40),
('Camiseta Ajustada', 'Camiseta ajustada para un look más entallado.', 25.00, 2, 'Casual Wear', 'Algodón', 'Ajustada', 50),
('Chaqueta', 'Chaqueta ligera de algodón para el otoño.', 70.00, 1, 'Casual Wear', 'Algodón', 'Regular', 15);
