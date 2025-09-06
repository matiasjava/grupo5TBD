-- Sentencia 5:Lista de clientes por compañía que más ha pagado mensualmente.

SELECT DISTINCT ON (anio, mes, id_compania)
       anio, mes, compania, cliente, monto
FROM (
  SELECT
    EXTRACT(YEAR  FROM p.fecha_pedido) AS anio,
    EXTRACT(MONTH FROM p.fecha_pedido) AS mes,
    co.id_compania                      AS id_compania,
    co.nombre_compania                  AS compania,
    c.nombre_cliente                    AS cliente,
    SUM(d.cantidad * d.precio_unitario) AS monto
  FROM pedido p
  JOIN pedido_detalle d ON d.id_pedido    = p.id_pedido
  JOIN producto pr      ON pr.id_producto = d.id_producto
  JOIN compania co      ON co.id_compania = pr.id_compania
  JOIN cliente  c       ON c.id_cliente   = p.id_cliente
  GROUP BY
    EXTRACT(YEAR  FROM p.fecha_pedido),
    EXTRACT(MONTH FROM p.fecha_pedido),
    co.id_compania, co.nombre_compania, c.nombre_cliente
) x
ORDER BY anio, mes, id_compania, monto DESC, cliente ASC;



-- Sentencia 6: Pedido diario con más productos del último mes.

SELECT DISTINCT ON (dia)
       dia,
       id_pedido,
       total_productos
FROM (
  SELECT
    p.fecha_pedido  AS dia,
    p.id_pedido     AS id_pedido,
    SUM(d.cantidad) AS total_productos
  FROM pedido p
  JOIN pedido_detalle d ON d.id_pedido = p.id_pedido
  WHERE p.fecha_pedido BETWEEN DATE '2025-08-01' AND DATE '2025-08-31'
  GROUP BY p.fecha_pedido, p.id_pedido
) x
ORDER BY dia, total_productos DESC, id_pedido ASC;




-- Sentencia 9: Lista de repartidores que han llevado pedidos en moto o bicicleta a las comunas de Providencia y Santiago Centro.
SELECT DISTINCT r.id_repartidor, r.nombre, r.apellido FROM repartidor r
JOIN medio_transporte mt ON mt.id_medio_transporte = r.id_medio_transporte
WHERE mt.nombre_transporte IN ('moto', 'bicicleta')
  AND EXISTS (
        SELECT *
        FROM entrega e
        JOIN direccion d ON d.id_direccion = e.id_direccion
        WHERE e.id_repartidor = r.id_repartidor
          AND d.comuna = 'Providencia'
      )
  AND EXISTS (
        SELECT *
        FROM entrega e
        JOIN direccion d ON d.id_direccion = e.id_direccion
        WHERE e.id_repartidor = r.id_repartidor
          AND d.comuna = 'Santiago Centro'
      )
ORDER BY r.id_repartidor;

-- Sentencia 10: Lista de clientes que han gastado más diariamente el mes pasado.
SELECT dia, id_cliente, nombre_cliente, gasto FROM (
  SELECT
    p.fecha_pedido AS dia,
    c.id_cliente,
    c.nombre_cliente,
    SUM(pd.cantidad * pd.precio_unitario) AS gasto,
    RANK() OVER (
      PARTITION BY p.fecha_pedido
      ORDER BY SUM(pd.cantidad * pd.precio_unitario) DESC
    ) AS puesto
  FROM pedido p
  JOIN pedido_detalle pd ON pd.id_pedido = p.id_pedido
  JOIN cliente c         ON c.id_cliente = p.id_cliente
  WHERE p.fecha_pedido BETWEEN DATE '2025-08-01' AND DATE '2025-08-31'
  GROUP BY p.fecha_pedido, c.id_cliente, c.nombre_cliente
) AS x
WHERE x.puesto = 1
ORDER BY dia, id_cliente;