-- ================================================================
-- PROTEUS CRM - ESTRUCTURA DE BASE DE DATOS (SIMPLIFICADA)
-- ================================================================

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  usuario VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE campaigns (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) UNIQUE NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  estado VARCHAR(20) NOT NULL,
  fc_inicio DATE NOT NULL,
  fc_final DATE NOT NULL
);

CREATE TABLE contactos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  telefono VARCHAR(20),
  email VARCHAR(100),
  estado VARCHAR(20)
);

CREATE TABLE gestiones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_contacto INT NOT NULL,
  id_campaign INT NOT NULL,
  id_user INT NOT NULL,
  resultado VARCHAR(50),
  fecha DATETIME NOT NULL,
  FOREIGN KEY (id_contacto) REFERENCES contactos(id),
  FOREIGN KEY (id_campaign) REFERENCES campaigns(id),
  FOREIGN KEY (id_user) REFERENCES users(id)
);

-- Datos dummy para probar
INSERT INTO users (nombre, apellido, usuario, password)
VALUES ('Juan', 'Pérez', 'jperez', '12345');

INSERT INTO campaigns (codigo, nombre, estado, fc_inicio, fc_final)
VALUES ('VENTA2025', 'Campaña Ventas Q1', 'Activa', '2025-01-01', '2025-03-31');
