-- 5FN
-- Forma incorreta de como fazer a 5FN

DROP TABLE IF EXISTS vendedor_empresa;
DROP TABLE IF EXISTS empresa_produto;
DROP TABLE IF EXISTS vendedor_produto;
DROP TABLE IF EXISTS negociacoes;

-- Tabela original sem a regra cíclica perfeita
CREATE TABLE negociacoes (
    vendedor VARCHAR(10) NOT NULL,
    empresa VARCHAR(10) NOT NULL,
    produto VARCHAR(10) NOT NULL,

    PRIMARY KEY (vendedor, empresa, produto)
);

-- Inserindo negociações onde NÃO existe dependência de junção perfeita
-- V1 vende P1 para E1.
-- V1 vende P2 para E2.
-- V2 vende P1 para E2.
INSERT INTO negociacoes (vendedor, empresa, produto)
VALUES
('V1', 'E1', 'P1'),
('V1', 'E2', 'P2'),
('V2', 'E2', 'P1');

------------------------------------------------------------------
-- ERRADO: Decompondo indevidamente em 3 tabelas menores
------------------------------------------------------------------

CREATE TABLE vendedor_empresa AS 
SELECT DISTINCT vendedor, empresa FROM negociacoes;

CREATE TABLE empresa_produto AS 
SELECT DISTINCT empresa, produto FROM negociacoes;

CREATE TABLE vendedor_produto AS 
SELECT DISTINCT vendedor, produto FROM negociacoes;

-- TENTATIVA DE RECONSTRUÇÃO (JOIN)
SELECT
    ve.vendedor,
    ve.empresa,
    ep.produto
FROM vendedor_empresa ve
JOIN empresa_produto ep ON ep.empresa = ve.empresa
JOIN vendedor_produto vp ON vp.vendedor = ve.vendedor AND vp.produto = ep.produto
ORDER BY ve.vendedor, ve.empresa, ep.produto;



-- Forma correta de fazer a 5FN

DROP TABLE IF EXISTS vendedor_empresa;
DROP TABLE IF EXISTS empresa_produto;
DROP TABLE IF EXISTS vendedor_produto;
DROP TABLE IF EXISTS negociacoes;

-- Tabela original: combinações válidas
CREATE TABLE negociacoes (
    vendedor VARCHAR(10) NOT NULL,
    empresa VARCHAR(10) NOT NULL,
    produto VARCHAR(10) NOT NULL,

    PRIMARY KEY (vendedor, empresa, produto)
);

-- Inserindo as negociações válidas
INSERT INTO negociacoes (vendedor, empresa, produto)
VALUES
('V1', 'E1', 'P1'),
('V1', 'E2', 'P2'),
('V2', 'E1', 'P2');

-- Consultando os dados originais
SELECT *
FROM negociacoes
ORDER BY vendedor, empresa, produto;

-- Decomposição dos relacionamentos em pares

CREATE TABLE vendedor_empresa (
    vendedor VARCHAR(10) NOT NULL,
    empresa VARCHAR(10) NOT NULL,

    PRIMARY KEY (vendedor, empresa)
);

CREATE TABLE empresa_produto (
    empresa VARCHAR(10) NOT NULL,
    produto VARCHAR(10) NOT NULL,

    PRIMARY KEY (empresa, produto)
);

CREATE TABLE vendedor_produto (
    vendedor VARCHAR(10) NOT NULL,
    produto VARCHAR(10) NOT NULL,

    PRIMARY KEY (vendedor, produto)
);

-- Gerando os relacionamentos a partir dos dados originais
INSERT INTO vendedor_empresa
SELECT DISTINCT vendedor, empresa
FROM negociacoes;

INSERT INTO empresa_produto
SELECT DISTINCT empresa, produto
FROM negociacoes;

INSERT INTO vendedor_produto
SELECT DISTINCT vendedor, produto
FROM negociacoes;

-- Consultando os relacionamentos separados
SELECT * FROM vendedor_empresa;
SELECT * FROM empresa_produto;
SELECT * FROM vendedor_produto;

-- Tentando reconstruir as negociações
-- A consulta pode gerar combinações falsas
SELECT
    ve.vendedor,
    ve.empresa,
    ep.produto
FROM vendedor_empresa ve
JOIN empresa_produto ep
    ON ep.empresa = ve.empresa
JOIN vendedor_produto vp
    ON vp.vendedor = ve.vendedor
   AND vp.produto = ep.produto
ORDER BY ve.vendedor, ve.empresa, ep.produto;
