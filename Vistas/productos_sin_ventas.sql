CREATE VIEW productos_sin_ventas AS
SELECT
    p.descripcion
FROM
    productos p
LEFT JOIN
    tickets t ON p.eancode = t.eancode
WHERE
    t.id IS NULL;