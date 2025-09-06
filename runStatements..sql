
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