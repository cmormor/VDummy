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

-- Tabla de tiendas
CREATE TABLE tiendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    ubicacion VARCHAR(255)
);

-- Tabla de tallas
CREATE TABLE tallas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    talla VARCHAR(2) NOT NULL,  -- S, M, L, XL
    pecho DECIMAL(5, 2) NOT NULL,
    cintura DECIMAL(5, 2) NOT NULL,
    cadera DECIMAL(5, 2) NOT NULL
);

-- Tabla de prendas
CREATE TABLE prendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    talla_id INT,  -- Relación con la tabla tallas
    tienda_id INT,  -- Relación con la tabla tiendas
    FOREIGN KEY (talla_id) REFERENCES tallas(id),
    FOREIGN KEY (tienda_id) REFERENCES tiendas(id)
);

-- Tabla de carrito (opcional)
CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,  -- Relación con la tabla usuarios
    prenda_id INT,   -- Relación con la tabla prendas
    talla_id INT,    -- Relación con la tabla tallas
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (prenda_id) REFERENCES prendas(id),
    FOREIGN KEY (talla_id) REFERENCES tallas(id)
);

-- Insertar datos en la tabla tallas
INSERT INTO tallas (talla, pecho, cintura, cadera) VALUES
('S', 90.00, 70.00, 95.00),
('M', 100.00, 80.00, 105.00),
('L', 110.00, 90.00, 115.00),
('XL', 120.00, 100.00, 125.00);
