/*
--VIOLA 2FN
CREATE TABLE matricula_nao_normalizada (
    aluno_id INT,
    curso_id INT,
    -- ERRO DE 2FN: O nome do aluno depende apenas de aluno_id (metade da chave)
    nome_aluno VARCHAR(100) NOT NULL, 
    -- ERRO DE 2FN: O nome do curso depende apenas de curso_id (a outra metade da chave)
    nome_curso VARCHAR(100) NOT NULL, 
    
    -- Chave primária composta
    PRIMARY KEY (aluno_id, curso_id)
);

-- Inserindo os dados de forma redundante
INSERT INTO matricula_nao_normalizada (aluno_id, curso_id, nome_aluno, nome_curso) VALUES 
(1, 1, 'Ana', 'Banco de Dados'),
(1, 2, 'Ana', 'Programacao'),       -- Repete o nome 'Ana' desnecessariamente
(2, 1, 'Pedro', 'Banco de Dados');  -- Repete o curso 'Banco de Dados' desnecessariamente

-- Consulta simples (sem JOINs)
SELECT 
    nome_aluno, 
    nome_curso 
FROM matricula_nao_normalizada;
*/

--2FN (MANEIRA CORRETA)
CREATE TABLE aluno(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE curso(
    id SERIAL PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL
);

CREATE TABLE matricula (
    aluno_id INT,
    curso_id INT,
    PRIMARY KEY (aluno_id, curso_id),
    FOREIGN KEY (aluno_id) REFERENCES aluno(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

INSERT INTO aluno (nome) VALUES ('Ana'),
('Pedro'),

INSERT INTO curso (nome) VALUES ('Banco de Dados'),
('Programacao'),

INSERT INTO matricula (aluno_id, curso_id) VALUES 
(1, 1), -- Ana faz Banco de Dados
(1, 2), -- Ana faz Programacao
(2, 1), -- Pedro faz Banco de Dados

SELECT 
    a.nome AS nome_aluno, 
    c.nome_curso AS curso_matriculado
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN curso c ON m.curso_id = c.id;
