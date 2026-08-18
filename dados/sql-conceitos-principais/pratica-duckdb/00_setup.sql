-- ============================================================
-- Setup do banco de prática — mesmos dados da aula "Principais
-- Conceitos de SQL" (tabelas clientes e pedidos)
-- ============================================================

DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id         INTEGER PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    email      VARCHAR(150) UNIQUE,
    cidade     VARCHAR(100),
    categoria  VARCHAR(20) DEFAULT 'Bronze'
               CHECK (categoria IN ('Bronze','Prata','Ouro'))
);

CREATE TABLE pedidos (
    id          INTEGER PRIMARY KEY,
    id_cliente  INTEGER REFERENCES clientes(id),
    produto     VARCHAR(100) NOT NULL,
    valor       DECIMAL(10,2) CHECK (valor > 0)
);

INSERT INTO clientes (id, nome, email, cidade, categoria) VALUES
    (1, 'Ana',   'ana@example.com',   'Recife',      'Ouro'),
    (2, 'Bruno', 'bruno@example.com', 'São Paulo',   'Prata'),
    (3, 'Carla', 'carla@example.com', 'Salvador',    'Ouro'),
    (4, 'Diego', 'diego@example.com', 'Curitiba',    'Bronze'),
    (5, 'Elis',  'elis@example.com',  'São Paulo',   'Prata');

INSERT INTO pedidos (id, id_cliente, produto, valor) VALUES
    (101, 1, 'Notebook', 3500),
    (102, 2, 'Mouse',      80),
    (103, 1, 'Teclado',   250),
    (104, 3, 'Monitor',   900),
    (105, 5, 'Cadeira',   600),
    (106, 2, 'Fone',      150);

SELECT 'clientes' AS tabela, count(*) AS linhas FROM clientes
UNION ALL
SELECT 'pedidos', count(*) FROM pedidos;
