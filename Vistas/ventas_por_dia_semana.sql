CREATE VIEW ventas_por_dia_semana AS
SELECT
    c.dia_semana,
    SUM(t.unidades_vendidas * t.precio_promocional) AS facturacion_total
FROM
    tickets t
JOIN
    calendario c ON t.fecha = c.fecha
GROUP BY
    c.dia_semana
ORDER BY
    facturacion_total DESC;