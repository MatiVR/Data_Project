SELECT * FROM tickets LIMIT 5;
SELECT * FROM productos LIMIT 5;
SELECT * FROM productos_tickets LIMIT 5;
SELECT * FROM calendario where anio = 2023 LIMIT 5;

SELECT 
    p.id AS producto_id, 
    t.id AS ticket_id, 
    p.eancode AS producto_ean, 
    t.eancode AS ticket_ean
FROM productos p
JOIN tickets t ON p.eancode = t.eancode
LIMIT 10;

INSERT INTO productos_tickets (producto_id, ticket_id)
SELECT 
    p.id AS producto_id, 
    t.id AS ticket_id
FROM productos p
JOIN tickets t ON p.eancode = t.eancode;