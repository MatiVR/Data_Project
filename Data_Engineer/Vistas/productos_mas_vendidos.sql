CREATE VIEW productos_mas_vendidos AS
SELECT
    p.descripcion,
    SUM(t.unidades_vendidas) AS total_unidades_vendidas
FROM
    tickets t
JOIN
    productos p ON t.eancode = p.eancode
GROUP BY
    p.descripcion
ORDER BY
    total_unidades_vendidas DESC;