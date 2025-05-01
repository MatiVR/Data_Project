CREATE VIEW ventas_dias AS
SELECT
    t.fecha,
    SUM(t.unidades_vendidas * t.precio_promocional) AS facturacion_por_dia,
    SUM(t.unidades_vendidas) AS total_productos_vendidos,
    COUNT(DISTINCT t.ticket) AS total_tickets
FROM
    tickets t
GROUP BY
    t.fecha;