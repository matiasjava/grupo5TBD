-- =========================================================
-- SEED DE DATOS 
-- =========================================================

-- 1) CLIENTES
INSERT INTO cliente (id_cliente, rut_cliente, nombre_cliente, email_cliente) VALUES
(1, '12.345.678-9', 'Ana Pérez',     'ana.perez@example.com'),
(2, '9.876.543-2',  'Luis Gómez',    'luis.gomez@example.com'),
(3, '15.111.222-3', 'María Torres',  'maria.torres@example.com'),
(4, '18.222.333-4', 'Jorge Silva',   'jorge.silva@example.com'),
(5, '20.333.444-5', 'Carla Rojas',   'carla.rojas@example.com');

-- 2) DIRECCIONES
INSERT INTO direccion (id_direccion, comuna,        region,                    id_cliente) VALUES
(101, 'Providencia',  'Región Metropolitana',       1),
(102, 'Maipú',        'Región Metropolitana',       1),
(103, 'Ñuñoa',        'Región Metropolitana',       2),
(104, 'Valparaíso',   'Región de Valparaíso',       2),
(105, 'Concepción',   'Región del Biobío',          3),
(106, 'La Serena',    'Región de Coquimbo',         3),
(107, 'Temuco',       'Región de La Araucanía',     4),
(108, 'Puerto Montt', 'Región de Los Lagos',        5),
(109, 'Santiago Centro', 'Región Metropolitana',    1),  
(110, 'Santiago Centro', 'Región Metropolitana',    2),  
(111, 'Providencia',     'Región Metropolitana',    3),  
(112, 'Santiago Centro', 'Región Metropolitana',    5), 
(113, 'Providencia',     'Región Metropolitana',    4);  

-- 3) MEDIOS DE TRANSPORTE
INSERT INTO medio_transporte (id_medio_transporte, nombre_transporte) VALUES
(1, 'Bicicleta'),
(2, 'Moto'),
(3, 'Auto'),
(4, 'Camioneta'),
(5, 'Scooter'),
(6, 'A pie');

-- 4) REPARTIDORES (mapeados a distintos medios)
INSERT INTO repartidor (id_repartidor, nombre, apellido, telefono, id_medio_transporte) VALUES
(201, 'Pedro', 'Lagos',   '+56911111111', 1),
(202, 'Diego', 'Vera',    '+56922222222', 2),
(203, 'Sofía', 'Navarro', '+56933333333', 3),
(204, 'Tomás', 'Ibarra',  '+56944444444', 4),
(205, 'Elisa', 'Muñoz',   '+56955555555', 5),
(206, 'Raúl',  'Pinto',   '+56966666666', 6);

-- 5) COMPAÑÍAS
INSERT INTO compania (id_compania, nombre_compania, id_direccion) VALUES
(301, 'Distribuciones Andinas', 101),
(302, 'Sur Logística',          107),
(303, 'Pacífico Retail',        104);

-- 6) PRODUCTOS
INSERT INTO producto (id_producto, nombre_producto, descripcion_producto, precio_producto, stock_producto) VALUES
(401, 'Café Grano 1kg',     'Arábica tostado medio',              10990.00, 300),
(402, 'Té Verde 100u',      'Bolsa filtrante premium',             5990.00, 500),
(403, 'Yerba Mate 500g',    'Selección especial',                   3990.00, 400),
(404, 'Leche A2 1L',        'Libre de A1 beta-caseína',             1790.00, 800),
(405, 'Granola 750g',       'Frutos secos y miel',                  7490.00, 250),
(406, 'Avena 1kg',          'Instantánea sin azúcar',               2490.00, 600);

-- 7) PRODUCTO vs COMPAÑÍA
INSERT INTO producto_compania (id_producto, id_compania) VALUES
(401, 301), (402, 301),
(403, 303), (404, 303),
(405, 302), (406, 302);

-- 8) PEDIDOS (fechas variadas 2023–2025, distintos estados y repartidores)
-- Estados de ejemplo: 'Creado', 'Preparación', 'Despachado', 'Entregado', 'Cancelado'
INSERT INTO pedido (id_pedido, fecha_pedido, estado, id_cliente, id_repartidor) VALUES
-- 2023
(501, '2023-01-17', 'Entregado',    1, 201),
(502, '2023-03-05', 'Entregado',    2, 202),
(503, '2023-05-22', 'Entregado',    3, 203),
(504, '2023-09-14', 'Entregado',    1, 202),
(505, '2023-12-02', 'Cancelado',    4, 206),
-- 2024
(506, '2024-02-11', 'Entregado',    2, 204),
(507, '2024-04-29', 'Entregado',    3, 205),
(508, '2024-07-07', 'Entregado',    5, 201),
(509, '2024-09-19', 'Entregado',    1, 203),
(510, '2024-11-30', 'Entregado',    4, 204),
-- 2025
(511, '2025-01-09', 'Entregado',    2, 205),
(512, '2025-03-15', 'Entregado',    3, 202),
(513, '2025-05-03', 'Preparación',  5, 206),
(514, '2025-06-21', 'Entregado',    1, 201),
(515, '2025-07-28', 'Despachado',   4, 204),
(516, '2025-08-05', 'Entregado',    5, 203),
(517, '2025-08-18', 'Entregado',    2, 202),
(518, '2025-09-02', 'Entregado',    3, 205),
(519, '2025-08-03', 'Entregado',    1, 201), 
(520, '2025-08-03', 'Entregado',    2, 202),  
(521, '2025-08-05', 'Entregado',    1, 202), 
(522, '2025-08-12', 'Entregado',    3, 201),  
(523, '2025-08-12', 'Entregado',    5, 202), 
(524, '2025-08-18', 'Entregado',    1, 201),  
(525, '2025-08-21', 'Entregado',    4, 202),  
(526, '2025-08-29', 'Entregado',    2, 201),  
(527, '2025-08-31', 'Entregado',    5, 202);  

-- 9) DETALLE DE PEDIDO (incluye id_cliente)
INSERT INTO pedido_detalle (id_pedido_deta, cantidad, precio_unitario, id_cliente, id_producto, id_pedido) VALUES
-- P501 (Ana, Providencia o Maipú según entrega)
(701, 2, 10990.00, 1, 401, 501),
(702, 1,  5990.00, 1, 402, 501),
-- P502 (Luis)
(703, 3,  3990.00, 2, 403, 502),
-- P503 (María)
(704, 6,  1790.00, 3, 404, 503),
(705, 1,  7490.00, 3, 405, 503),
-- P504 (Ana)
(706, 1,  2490.00, 1, 406, 504),
(707, 1,  5990.00, 1, 402, 504),
-- P505 (Jorge - cancelado)
(708, 2,  7490.00, 4, 405, 505),
-- P506 (Luis)
(709, 1, 10990.00, 2, 401, 506),
(710, 2,  1790.00, 2, 404, 506),
-- P507 (María)
(711, 4,  2490.00, 3, 406, 507),
-- P508 (Carla)
(712, 1, 10990.00, 5, 401, 508),
(713, 2,  5990.00,  5, 402, 508),
-- P509 (Ana)
(714, 1,  3990.00, 1, 403, 509),
-- P510 (Jorge)
(715, 2,  1790.00, 4, 404, 510),
-- P511 (Luis)
(716, 2,  2490.00, 2, 406, 511),
-- P512 (María)
(717, 1, 10990.00, 3, 401, 512),
(718, 2,  7490.00, 3, 405, 512),
-- P513 (Carla)
(719, 3,  3990.00, 5, 403, 513),
-- P514 (Ana)
(720, 2,  1790.00, 1, 404, 514),
(721, 1,  2490.00, 1, 406, 514),
-- P515 (Jorge)
(722, 1, 10990.00, 4, 401, 515),
-- P516 (Carla)
(723, 1,  5990.00, 5, 402, 516),
(724, 1,  7490.00, 5, 405, 516),
-- P517 (Luis)
(725, 2,  1790.00, 2, 404, 517),
-- P518 (María)
(726, 1,  2490.00, 3, 406, 518),
(727, 1,  3990.00, 3, 403, 518),
-- P519 (Ana)
(728, 2, 10990.00, 1, 401, 519),
(729, 1,  5990.00, 1, 402, 519),
-- P520 (2025-08-03) total 12.860 -> Luis
(730, 3,  1790.00, 2, 404, 520),
(731, 1,  7490.00, 2, 405, 520),
-- P521 (2025-08-05) total 22.970 -> Ana
(733, 2,  5990.00, 1, 402, 521),
-- P522 (2025-08-12) total 13.950 -> María
(734, 4,  2490.00, 3, 406, 522),
(735, 1,  3990.00, 3, 403, 522),
-- P523 (2025-08-12) total 21.980 -> Carla 
(736, 2, 10990.00, 5, 401, 523),
-- P524 (2025-08-18) total 14.980 -> Ana 
(737, 2,  7490.00, 1, 405, 524),
-- P525 (2025-08-21) total 17.970 -> Jorge
(738, 3,  5990.00, 4, 402, 525),
-- P526 (2025-08-29) total 15.970 -> Luis
(739, 1, 10990.00, 2, 401, 526),
(740, 2,  2490.00, 2, 406, 526),
-- P527 (2025-08-31) total 11.970 -> Carla
(741, 3,  3990.00, 5, 403, 527);

-- 10) ENTREGAS (ligan pedido a DIRECCIÓN -> comuna y a repartidor)
-- Distribuimos direcciones para que el mismo cliente tenga pedidos en comunas distintas
INSERT INTO entrega (id_entrega, id_pedido, id_repartidor, id_direccion) VALUES
-- Ana (id_cliente=1): Providencia y Maipú
(801, 501, 201, 101),  -- Providencia
(802, 504, 202, 102),  -- Maipú
(803, 509, 203, 101),  -- Providencia
(804, 514, 201, 102),  -- Maipú
-- Luis (id_cliente=2): Ñuñoa y Valparaíso
(805, 502, 202, 103),  -- Ñuñoa
(806, 506, 204, 104),  -- Valparaíso
(807, 511, 205, 103),  -- Ñuñoa
(808, 517, 202, 104),  -- Valparaíso
-- María (id_cliente=3): Concepción y La Serena
(809, 503, 203, 105),  -- Concepción
(810, 507, 205, 106),  -- La Serena
(811, 512, 202, 105),  -- Concepción
(812, 518, 205, 106),  -- La Serena
-- Jorge (id_cliente=4): Temuco
(813, 505, 206, 107),  -- Cancelado igual quedará registro de intento de entrega
(814, 510, 204, 107),
(815, 515, 204, 107),
-- Carla (id_cliente=5): Puerto Montt
(816, 508, 201, 108),
(817, 513, 206, 108),
(818, 516, 203, 108),
(819, 519, 201, 109),  
(820, 520, 202, 110),  
(821, 521, 202, 101),  
(822, 522, 201, 111),  
(823, 523, 202, 112),  
(824, 524, 201, 101),  
(825, 525, 202, 113),  
(826, 526, 201, 103),  
(827, 527, 202, 108);  
