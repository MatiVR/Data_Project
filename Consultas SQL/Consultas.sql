
-- 1. ¿Cuáles son los 5 productos más vendidos en el último mes?

WITH UltimoMes AS (
  SELECT MAX(fecha) AS ultima_fecha
  FROM tickets
)
SELECT 
    p.descripcion,
    CAST(SUM(t.unidades_vendidas) AS INTEGER) AS total_vendido
FROM
    productos p
INNER JOIN productos_tickets pt ON p.id = pt.producto_id
INNER JOIN tickets t ON pt.ticket_id = t.id
INNER JOIN UltimoMes um ON t.fecha BETWEEN um.ultima_fecha - INTERVAL '1 month' AND um.ultima_fecha
GROUP BY p.descripcion
ORDER BY total_vendido DESC
LIMIT 5;

-- 2. Obtener el total de ingresos generados por categoría en las últimas 3 semanas.

WITH UltimasTresSemanas AS (
  SELECT MAX(fecha) AS ultima_fecha
  FROM tickets
)
SELECT 
    p.categoria,
    SUM(t.unidades_vendidas * COALESCE(t.precio_promocional, t.precio_regular, 0))
FROM
    productos p
INNER JOIN productos_tickets pt ON p.id = pt.producto_id
INNER JOIN tickets t ON pt.ticket_id = t.id
INNER JOIN UltimasTresSemanas uts ON t.fecha BETWEEN uts.ultima_fecha - INTERVAL '3 weeks' AND uts.ultima_fecha
GROUP BY p.categoria;

-- 3. Listar los días con mayor venta y cantidad de tickets.

SELECT 
    t.fecha,
    COUNT(*) AS cantidad_tickets,
    CAST(SUM(t.unidades_vendidas) AS INTEGER) AS total_ventas
FROM
    tickets t
GROUP BY t.fecha
ORDER BY total_ventas DESC
LIMIT 10;  -- Ajusta el límite según tus necesidades

-- 4. Mostrar la categoría con el mayor volumen de ventas por sucursal.

SELECT DISTINCT ON (t.idcadena) 
    p.categoria,
    t.idcadena,
    CAST(SUM(t.unidades_vendidas)AS INTEGER)AS total_ventas
FROM
    productos p
INNER JOIN productos_tickets pt ON p.id = pt.producto_id
INNER JOIN tickets t ON pt.ticket_id = t.id
GROUP BY p.categoria, t.idcadena
ORDER BY t.idcadena, total_ventas DESC;
