--2FN
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
