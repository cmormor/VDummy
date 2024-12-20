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
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Modificado a INT AUTO_INCREMENT
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
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Modificado a INT AUTO_INCREMENT
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
