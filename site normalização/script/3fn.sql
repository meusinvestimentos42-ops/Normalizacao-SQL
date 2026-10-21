--3FN
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
