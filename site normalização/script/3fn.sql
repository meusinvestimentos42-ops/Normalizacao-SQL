/*
--VIOLA 3FN
CREATE TABLE funcionario_nao_normalizado (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_departamento INT NOT NULL,
    -- ERRO DE 3FN: nome_departamento depende de id_departamento (que não é a chave primária)
    nome_departamento VARCHAR(100) NOT NULL
);

-- Inserindo os dados de forma duplicada
INSERT INTO funcionario_nao_normalizado (nome, id_departamento, nome_departamento) VALUES 
('Ana', 1, 'financeiro'),
('Bruno', 1, 'financeiro'),  -- Repete o nome do departamento 'financeiro'
('Caio', 2, 'vendas');

-- Consulta simples (sem necessidade de JOIN)
SELECT 
    id AS id_funcionario,
    nome AS nome_funcionario,
    nome_departamento
FROM funcionario_nao_normalizado;
*/

--3FN (MANEIRA CORRETA)
CREATE TABLE departamento(
    id SERIAL PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE funcionario(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
    id_departamento INT REFERENCES departamento(id_departamento)
);

INSERT INTO departamento (nome) VALUES ('financeiro'),
('vendas'),

INSERT INTO funcionario (nome, id_departamento) VALUES ('Ana', 1),
('Bruno', 1),
('Caio',2),

SELECT 
    f.id_funcionario,
    f.nome AS nome_funcionario,
    d.nome_departamento
FROM funcionario f
JOIN departamento d ON f.id_departamento = d.id_departamento;
