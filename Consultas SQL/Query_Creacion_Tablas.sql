-- Database: Ventas_Productos

DROP DATABASE IF EXISTS "Ventas_Productos";

CREATE DATABASE "Ventas_Productos"
    WITH
    OWNER = admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

	CREATE TABLE productos (
    idcadena INTEGER,
    eancode VARCHAR(255),
    descripcion TEXT,
    id_sector INTEGER,
    sector VARCHAR(255),
    id_seccion INTEGER,
    seccion VARCHAR(255),
    id_categoria INTEGER,
    categoria VARCHAR(255),
    id_subcategoria INTEGER,
    subcategoria VARCHAR(255),
    fabricante VARCHAR(255),
    marca VARCHAR(255),
    contenido TEXT,
    pesovolumen DECIMAL,
    unidadmedida VARCHAR(255),
    ultmodificacion TIMESTAMP,
	id INTEGER PRIMARY KEY,
    granfamilia VARCHAR(255),
    familia VARCHAR(255),
    categoria_nueva VARCHAR(255),
    subcategoria_nueva VARCHAR(255)
);

CREATE TABLE tickets (
    punto INTEGER,
    ticket VARCHAR(255),
    fecha DATE,
    hora TIME,
    eancode VARCHAR(255),
    ean_desc TEXT,
    unidades_vendidas DECIMAL,
    precio_regular DECIMAL,
    precio_promocional DECIMAL,
    tipo_venta CHAR(1),
    idcadena INTEGER,
    ultmodificacion TIMESTAMP,
    anulado BOOLEAN,
	id INTEGER PRIMARY KEY
);

CREATE TABLE calendario (
    fecha DATE PRIMARY KEY,  -- Clave primaria
    dia_semana VARCHAR(20),
    mes VARCHAR(20),
    anio INTEGER
);

-- Tabla de relación para productos y tickets (muchos a muchos)
CREATE TABLE productos_tickets (
    producto_id INTEGER REFERENCES productos(id),
    ticket_id INTEGER REFERENCES tickets(id),
    PRIMARY KEY (producto_id, ticket_id)  -- Clave primaria compuesta
);

-- tickets y calendario (uno a muchos)
-- Un ticket tiene una fecha que se relaciona con una entrada en el calendario.
ALTER TABLE tickets ADD CONSTRAINT fk_fecha
FOREIGN KEY (fecha) REFERENCES calendario(fecha);

-- Insertar datos en productos_tickets utilizando eancode como dato comun
INSERT INTO productos_tickets (producto_id, ticket_id)
SELECT 
    p.id AS producto_id, 
    t.id AS ticket_id
FROM productos p
JOIN tickets t ON p.eancode = t.eancode;

-- Insertar datos en la tabla calendario utilizando una serie
WITH numbers AS (
    SELECT generate_series(1, 365) AS num
)
INSERT INTO public.calendario (fecha, dia_semana, mes, anio)
SELECT '2024-01-01'::date + num - 1,
       to_char('2024-01-01'::date + num - 1, 'Day'),
       to_char('2024-01-01'::date + num - 1, 'Month'),
       2024
FROM numbers;

-- DELETE FROM public.calendario;
--DELETE FROM public.productos;
--DELETE FROM public.tickets;
--DELETE FROM public.productos_tickets;