CREATE VIEW ventas_por_categoria AS
SELECT
    p.categoria,
    SUM(t.unidades_vendidas) AS total_productos_vendidos
FROM
    tickets t
JOIN
    productos p ON t.eancode = p.eancode  -- Join con 'eancode'
GROUP BY
    p.categoria;