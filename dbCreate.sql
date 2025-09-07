CREATE TABLE cliente (
  id_cliente       INTEGER PRIMARY KEY,
  rut_cliente      VARCHAR(20) NOT NULL UNIQUE,
  nombre_cliente   VARCHAR(100) NOT NULL,
  email_cliente    VARCHAR(100)
);

CREATE TABLE direccion (
  id_direccion   INTEGER PRIMARY KEY,
  comuna         VARCHAR(100) NOT NULL,
  region         VARCHAR(100) NOT NULL,
  id_cliente     INTEGER NOT NULL
    REFERENCES cliente(id_cliente)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
);

CREATE TABLE medio_transporte (
  id_medio_transporte INTEGER PRIMARY KEY,
  nombre_transporte   VARCHAR(100) NOT NULL
);

CREATE TABLE repartidor (
  id_repartidor       INTEGER PRIMARY KEY,
  nombre              VARCHAR(100) NOT NULL,
  apellido            VARCHAR(100) NOT NULL,
  telefono            VARCHAR(15) NOT NULL,
  id_medio_transporte INTEGER NOT NULL
    REFERENCES medio_transporte(id_medio_transporte)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
);

CREATE TABLE compania (
  id_compania     INTEGER PRIMARY KEY,
  nombre_compania VARCHAR(100) NOT NULL,
  id_direccion    INTEGER NOT NULL
    REFERENCES direccion(id_direccion)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
);

CREATE TABLE producto (
  id_producto          INTEGER PRIMARY KEY,
  nombre_producto      VARCHAR(100) NOT NULL,
  descripcion_producto VARCHAR(500) NOT NULL,
  precio_producto      NUMERIC(10,2) NOT NULL,
  stock_producto       INTEGER NOT NULL
);

CREATE TABLE producto_compania (
  id_producto  INTEGER NOT NULL
    REFERENCES producto(id_producto)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  id_compania  INTEGER NOT NULL
    REFERENCES compania(id_compania)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  PRIMARY KEY (id_producto, id_compania)
);

CREATE TABLE pedido (
  id_pedido     INTEGER PRIMARY KEY,
  fecha_pedido  DATE NOT NULL,
  estado        VARCHAR(50) NOT NULL,
  id_cliente    INTEGER NOT NULL
    REFERENCES cliente(id_cliente)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  id_repartidor INTEGER NOT NULL
    REFERENCES repartidor(id_repartidor)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
);

CREATE TABLE pedido_detalle (
  id_pedido_deta  INTEGER PRIMARY KEY,
  cantidad        INTEGER NOT NULL,
  precio_unitario NUMERIC(10,2) NOT NULL,
  id_cliente      INTEGER NOT NULL
    REFERENCES cliente(id_cliente)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  id_producto     INTEGER NOT NULL
    REFERENCES producto(id_producto)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  id_pedido       INTEGER NOT NULL
    REFERENCES pedido(id_pedido)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
);

CREATE TABLE entrega (
  id_entrega    INTEGER PRIMARY KEY,
  id_pedido     INTEGER NOT NULL
    REFERENCES pedido(id_pedido)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  id_repartidor INTEGER NOT NULL
    REFERENCES repartidor(id_repartidor)
      ON UPDATE CASCADE
      ON DELETE RESTRICT,
  id_direccion  INTEGER NOT NULL
    REFERENCES direccion(id_direccion)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
);