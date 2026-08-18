-- ============================================================
-- EXERCÍCIOS — Principais Conceitos de SQL (na prática, com DuckDB)
-- Abra este arquivo junto do banco aula.duckdb:
--   duckdb aula.duckdb
-- Depois rode cada bloco (copie e cole, ou .read 01_exercicios.sql)
--
-- Dados disponíveis (veja 00_setup.sql):
--   clientes(id, nome, email, cidade, categoria)
--   pedidos(id, id_cliente, produto, valor)
-- ============================================================


-- ---------- 1. SELECT & FROM ----------
-- 1.1 Traga TODAS as colunas de todos os clientes.


-- 1.2 Traga apenas nome e cidade dos clientes.


-- 1.3 Renomeie a coluna "nome" para "cliente" no resultado (AS).



-- ---------- 2. WHERE ----------
-- 2.1 Clientes da cidade 'São Paulo'.


-- 2.2 Clientes da categoria 'Ouro'.


-- 2.3 Clientes cuja cidade começa com 'S' (LIKE).


-- 2.4 Clientes com categoria 'Ouro' OU 'Prata' (IN).


-- 2.5 Clientes que NÃO são 'Bronze' (<>).



-- ---------- 3. ORDER BY & LIMIT ----------
-- 3.1 Pedidos ordenados do maior para o menor valor.


-- 3.2 Os 3 pedidos de maior valor (ORDER BY + LIMIT).


-- 3.3 Clientes ordenados por cidade e, dentro da cidade, por nome.



-- ---------- 4. Funções agregadas ----------
-- 4.1 Quantos pedidos existem no total? (COUNT)


-- 4.2 Qual a soma de todos os valores vendidos? (SUM)


-- 4.3 Qual o valor médio dos pedidos? (AVG)


-- 4.4 Qual o maior e o menor valor de pedido? (MAX, MIN)



-- ---------- 5. GROUP BY & HAVING ----------
-- 5.1 Total gasto por cliente (id_cliente) — some valor, agrupando.


-- 5.2 Igual ao anterior, mas só clientes que gastaram mais de 500.
--     (dica: HAVING, não WHERE, porque o filtro é sobre o agregado)


-- 5.3 Quantos pedidos cada cliente fez?



-- ---------- 6. JOIN ----------
-- 6.1 Uma linha por pedido, mostrando o nome do cliente junto
--     (INNER JOIN clientes com pedidos por id_cliente = id).


-- 6.2 Nome do cliente, produto e valor de cada pedido, ordenado por valor desc.


-- 6.3 LEFT JOIN: liste TODOS os clientes, mesmo os que não têm pedido.
--     Repare que Diego (id 4) aparece com produto/valor em branco (NULL) —
--     ele é o único cliente sem nenhum pedido.


-- 6.4 Tente inserir um pedido "órfão", com id_cliente que não existe:
--       INSERT INTO pedidos VALUES (107, 99, 'Headset', 200);
--     Isso deve FALHAR com erro de chave estrangeira — é a mesma proteção
--     do exercício 11.1. Ou seja: nesta tabela (com FK ativa) é impossível
--     existir um pedido órfão, então RIGHT JOIN/FULL JOIN nunca vão exibir
--     um pedido "sem dono". A única linha sem par possível é do lado dos
--     CLIENTES sem pedido (Diego). Rode um RIGHT JOIN trocando a ordem das
--     tabelas (pedidos RIGHT JOIN clientes) e um FULL JOIN, e confirme que
--     o Diego aparece com produto/valor em branco em ambos.


-- 6.5 CROSS JOIN: combine clientes com pedidos sem nenhuma condição
--     (todo cliente com todo pedido). Quantas linhas o resultado tem?
--     (deveria ser 5 clientes × 6 pedidos = 30)



-- ---------- 7. Subconsultas ----------
-- 7.1 Nomes dos clientes que já fizeram algum pedido (subquery com IN).


-- 7.2 Clientes cujo total gasto é maior que a média geral de gasto por cliente
--     (subquery no WHERE comparando com um agregado).


-- 7.3 Para cada pedido, mostre também o valor médio geral dos pedidos
--     (subquery escalar no SELECT).



-- ---------- 8. UNION / INTERSECT / EXCEPT ----------
-- 8.1 Junte, sem repetir, as cidades dos clientes e os nomes dos produtos
--     em uma única coluna "valor" (só para praticar a sintaxe do UNION).
--     Dica: SELECT cidade AS valor FROM clientes UNION SELECT produto FROM pedidos;


-- 8.2 Cidades que aparecem MAIS de uma vez entre os clientes
--     (pense em GROUP BY + HAVING count(*) > 1 — não precisa de INTERSECT aqui,
--     mas tente também: compare com um segundo SELECT igual usando INTERSECT
--     para ver que dá vazio, já que INTERSECT compara duas consultas diferentes).



-- ---------- 9. INSERT, UPDATE, DELETE ----------
-- 9.1 Insira um novo cliente seu, com categoria 'Bronze' (deixe o DEFAULT agir,
--     ou seja, não informe a coluna categoria).


-- 9.2 Atualize a categoria desse cliente para 'Prata'.


-- 9.3 Delete esse cliente que você criou.



-- ---------- 10. CREATE TABLE / DDL ----------
-- 10.1 Crie uma tabela "produtos" com: id INTEGER PRIMARY KEY,
--      nome VARCHAR NOT NULL, preco DECIMAL(10,2) CHECK (preco > 0).


-- 10.2 Adicione uma coluna "telefone" à tabela clientes (ALTER TABLE).


-- 10.3 Apague a tabela "produtos" que você criou (DROP TABLE).



-- ---------- 11. Chaves primárias e estrangeiras ----------
-- 11.1 Tente inserir um pedido com id_cliente = 999 (que não existe).
--      Observe o erro — isso é a integridade referencial em ação.



-- ---------- 12. VIEW ----------
-- 12.1 Crie uma view "vw_resumo_clientes" com nome, cidade e total gasto
--      de cada cliente (JOIN + GROUP BY, como no exercício 5.1/6.1).


-- 12.2 Consulte a view como se fosse uma tabela normal.



-- ---------- 13. Window functions ----------
-- 13.1 Para cada pedido, mostre o valor e o RANK() do pedido dentro
--      da categoria do cliente (PARTITION BY categoria ORDER BY valor DESC).
--      Precisa de JOIN com clientes primeiro.


-- 13.2 Para cada cliente, mostre o total gasto e também o total gasto
--      acumulado (SUM() OVER, ordenado por total decrescente) — um
--      "running total" sem GROUP BY colapsar as linhas.



-- ---------- 14. Transações ----------
-- 14.1 Abra uma transação, atualize a categoria de um cliente,
--      confira o resultado, e dê ROLLBACK (a mudança deve desaparecer).
--      BEGIN;
--      UPDATE clientes SET categoria = 'Ouro' WHERE id = 4;
--      SELECT * FROM clientes WHERE id = 4;
--      ROLLBACK;
--      SELECT * FROM clientes WHERE id = 4;  -- categoria voltou ao normal?


-- 14.2 Repita o exercício acima, mas termine com COMMIT em vez de ROLLBACK.
