CREATE DATABASE exemplos_normalizacao;

/*
--VIOLA 1FN
CREATE TABLE cliente_nao_normalizado (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    telefones VARCHAR(200) NOT NULL 
);

-- Inserindo os dados de forma aglutinada
INSERT INTO cliente_nao_normalizado (nome, logradouro, bairro, cidade, uf, telefones) VALUES 
('Ana Souza', 'rua das flores, 100', 'centro', 'São Paulo', 'SP', '(11) 98765-4321, (11) 91111-2222'),
('Carlos Silva', 'avenida Paulista, 500', 'bela vista', 'São Paulo', 'SP', '(11) 93333-4444');

-- Consulta simples (sem JOIN, mas cheia de problemas de estrutura)
SELECT * FROM cliente_nao_normalizado;
*/




--1FN (MANEIRA CORRETA)
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (id_cliente) 
        REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE numeros (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    numero_telefonico VARCHAR(20) NOT NULL,
    CONSTRAINT fk_cliente_telefone FOREIGN KEY (id_cliente) 
        REFERENCES cliente(id) ON DELETE CASCADE
);


-- Inserindo os clientes 
INSERT INTO cliente (nome) VALUES 
('Ana Souza'),
('Carlos Silva');

-- Inserindo os endereços vinculados aos IDs dos clientes
INSERT INTO endereco (id_cliente, logradouro, bairro, cidade, uf) VALUES 
(1, 'rua das flores, 100', 'centro', 'São Paulo', 'SP'),
(2, 'avenida Paulista, 500', 'bela vista', 'São Paulo', 'SP');

-- Inserindo numeros vinculados aos IDs dos clientes
INSERT INTO numeros (id_cliente, numero_telefonico) VALUES 
(1, '(11) 98765-4321'),
(1, '(11) 91111-2222'),
(2, '(11) 93333-4444');


--Consulta de todos os dados (JOIN)

SELECT 
    c.id AS id_cliente,
    c.nome,
    e.logradouro,
    e.bairro,
    e.cidade,
    e.uf,
    n.numero_telefonico
FROM cliente c
LEFT JOIN endereco e ON c.id = e.id_cliente
LEFT JOIN numeros n ON c.id = n.id_cliente;
