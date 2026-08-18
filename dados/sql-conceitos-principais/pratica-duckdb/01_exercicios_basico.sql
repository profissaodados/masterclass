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
select * from clientes


-- 1.2 Traga apenas nome e cidade dos clientes.
select nome, cidade from clientes


-- 1.3 Renomeie a coluna "nome" para "cliente" no resultado (AS).
select nome as cliente, cidade from clientes
select * from pedidos


-- ---------- 2. WHERE ----------
-- 2.1 Clientes da cidade 'São Paulo'.
select * from clientes where cidade = 'São Paulo'

-- 2.2 Clientes da categoria 'Ouro'.
select * from clientes 
where categoria = 'Ouro'

-- 2.3 Clientes cuja cidade começa com 'S' (LIKE).
select * from clientes where cidade like 'S%'


-- 2.4 Clientes com categoria 'Ouro' OU 'Prata' (IN).
select * from clientes where categoria IN('Ouro','Prata')

-- 2.5 Clientes que NÃO são 'Bronze' (<>).
select * from clientes where categoria <> 'Bronze'


-- ---------- 3. ORDER BY & LIMIT ----------
-- 3.1 Pedidos ordenados do maior para o menor valor.
select * from pedidos order by valor asc

-- 3.2 Os 3 pedidos de maior valor (ORDER BY + LIMIT).
select * from pedidos order by valor desc limit 3

-- 3.3 Clientes ordenados por cidade e por nome.
select * from clientes 
order by cidade asc, nome desc


-- ---------- 4. Funções agregadas ----------
-- 4.1 Quantos pedidos existem no total? (COUNT)


-- 4.2 Qual a soma de todos os valores vendidos? (SUM)


-- 4.3 Qual o valor médio dos pedidos? (AVG)


-- 4.4 Qual o maior e o menor valor de pedido? (MAX, MIN)
