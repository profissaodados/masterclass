-- ============================================================
-- GABARITO — só espie depois de tentar em 01_exercicios.sql :)
-- ============================================================

-- 1.1
SELECT * FROM clientes;

-- 1.2
SELECT nome, cidade FROM clientes;

-- 1.3
SELECT nome AS cliente, cidade FROM clientes;

-- 2.1
SELECT * FROM clientes WHERE cidade = 'São Paulo';

-- 2.2
SELECT * FROM clientes WHERE categoria = 'Ouro';

-- 2.3
SELECT * FROM clientes WHERE cidade LIKE 'S%';

-- 2.4
SELECT * FROM clientes WHERE categoria IN ('Ouro', 'Prata');

-- 2.5
SELECT * FROM clientes WHERE categoria <> 'Bronze';

-- 3.1
SELECT * FROM pedidos ORDER BY valor DESC;

-- 3.2
SELECT * FROM pedidos ORDER BY valor DESC LIMIT 3;

-- 3.3
SELECT * FROM clientes ORDER BY cidade, nome;

-- 4.1
SELECT count(*) AS total_pedidos FROM pedidos;

-- 4.2
SELECT sum(valor) AS soma_valores FROM pedidos;

-- 4.3
SELECT avg(valor) AS valor_medio FROM pedidos;

-- 4.4
SELECT max(valor) AS maior, min(valor) AS menor FROM pedidos;

-- 5.1
SELECT id_cliente, sum(valor) AS total_gasto
FROM pedidos
GROUP BY id_cliente;

-- 5.2
SELECT id_cliente, sum(valor) AS total_gasto
FROM pedidos
GROUP BY id_cliente
HAVING sum(valor) > 500;

-- 5.3
SELECT id_cliente, count(*) AS qtd_pedidos
FROM pedidos
GROUP BY id_cliente;

-- 6.1
SELECT p.*, c.nome
FROM pedidos p
INNER JOIN clientes c ON p.id_cliente = c.id;

-- 6.2
SELECT c.nome, p.produto, p.valor
FROM clientes c
INNER JOIN pedidos p ON p.id_cliente = c.id
ORDER BY p.valor DESC;

-- 6.3
SELECT c.nome, p.produto, p.valor
FROM clientes c
LEFT JOIN pedidos p ON p.id_cliente = c.id;

-- 6.4
-- Isso FALHA de propósito (Constraint Error) — a FK protege contra pedido órfão:
INSERT INTO pedidos VALUES (107, 99, 'Headset', 200);

-- RIGHT JOIN com a ordem invertida mostra o mesmo efeito do LEFT JOIN (6.3):
SELECT c.nome, p.produto, p.valor
FROM pedidos p
RIGHT JOIN clientes c ON p.id_cliente = c.id;

-- FULL JOIN: mostra tudo dos dois lados; aqui não existe pedido órfão
-- (a FK não deixa), então o resultado é igual ao LEFT/RIGHT acima.
SELECT c.nome, p.produto, p.valor
FROM clientes c
FULL JOIN pedidos p ON p.id_cliente = c.id;

-- 6.5
SELECT count(*) FROM clientes CROSS JOIN pedidos;  -- 30

-- 7.1
SELECT nome
FROM clientes
WHERE id IN (SELECT DISTINCT id_cliente FROM pedidos);

-- 7.2
SELECT nome
FROM clientes c
WHERE (SELECT sum(valor) FROM pedidos p WHERE p.id_cliente = c.id)
      > (SELECT avg(total) FROM (
            SELECT sum(valor) AS total FROM pedidos GROUP BY id_cliente
        ) t);

-- 7.3
SELECT id, produto, valor,
       (SELECT avg(valor) FROM pedidos) AS media_geral
FROM pedidos;

-- 8.1
SELECT cidade AS valor FROM clientes
UNION
SELECT produto FROM pedidos;

-- 8.2
SELECT cidade, count(*) FROM clientes GROUP BY cidade HAVING count(*) > 1;

SELECT cidade FROM clientes
INTERSECT
SELECT cidade FROM clientes;  -- mesmas duas consultas -> retorna todas as cidades distintas

-- 9.1
INSERT INTO clientes (id, nome, email, cidade) VALUES
    (6, 'Seu Nome', 'seunome@example.com', 'Fortaleza');

-- 9.2
UPDATE clientes SET categoria = 'Prata' WHERE id = 6;

-- 9.3
DELETE FROM clientes WHERE id = 6;

-- 10.1
CREATE TABLE produtos (
    id     INTEGER PRIMARY KEY,
    nome   VARCHAR NOT NULL,
    preco  DECIMAL(10,2) CHECK (preco > 0)
);

-- 10.2
ALTER TABLE clientes ADD COLUMN telefone VARCHAR(20);

-- 10.3
DROP TABLE produtos;

-- 11.1 — deve dar erro de violação de chave estrangeira
INSERT INTO pedidos VALUES (999, 999, 'Item fantasma', 10);

-- 12.1
CREATE VIEW vw_resumo_clientes AS
SELECT c.nome, c.cidade, sum(p.valor) AS total_gasto
FROM clientes c
JOIN pedidos p ON p.id_cliente = c.id
GROUP BY c.nome, c.cidade;

-- 12.2
SELECT * FROM vw_resumo_clientes;

-- 13.1
SELECT c.nome, c.categoria, p.produto, p.valor,
       rank() OVER (PARTITION BY c.categoria ORDER BY p.valor DESC) AS posicao_na_categoria
FROM pedidos p
JOIN clientes c ON c.id = p.id_cliente;

-- 13.2
SELECT nome, total_gasto,
       sum(total_gasto) OVER (ORDER BY total_gasto DESC) AS acumulado
FROM (
    SELECT c.nome, sum(p.valor) AS total_gasto
    FROM clientes c
    JOIN pedidos p ON p.id_cliente = c.id
    GROUP BY c.nome
) t;

-- 14.1
BEGIN;
UPDATE clientes SET categoria = 'Ouro' WHERE id = 4;
SELECT * FROM clientes WHERE id = 4;   -- categoria = 'Ouro' aqui dentro da transação
ROLLBACK;
SELECT * FROM clientes WHERE id = 4;   -- categoria = 'Bronze' de novo

-- 14.2
BEGIN;
UPDATE clientes SET categoria = 'Ouro' WHERE id = 4;
COMMIT;
SELECT * FROM clientes WHERE id = 4;   -- agora ficou 'Ouro' de vez
-- (se quiser voltar ao estado original da aula, rode de novo o 00_setup.sql)
