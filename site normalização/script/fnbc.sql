-- FNBC

DROP TABLE IF EXISTS aulas;
DROP TABLE IF EXISTS professores;

-- Tabela de professores
CREATE TABLE professores (
    id_professor SERIAL PRIMARY KEY,
    nome_professor VARCHAR(100) NOT NULL,
    sala VARCHAR(10) NOT NULL
);

-- Tabela de aulas
CREATE TABLE aulas (
    id_professor INT NOT NULL,
    disciplina VARCHAR(100) NOT NULL,

    PRIMARY KEY (id_professor, disciplina),

    FOREIGN KEY (id_professor)
        REFERENCES professores(id_professor)
        ON DELETE CASCADE
);

-- Inserindo os professores
INSERT INTO professores (nome_professor, sala)
VALUES
('Ana', 'A101'),
('Bruno', 'B202');

-- Inserindo as disciplinas ministradas
INSERT INTO aulas (id_professor, disciplina)
VALUES
(1, 'Matemática'),
(1, 'Física'),
(2, 'História');

-- Consultando os professores e suas salas
SELECT
    p.id_professor,
    p.nome_professor,
    p.sala,
    a.disciplina
FROM professores p
JOIN aulas a
    ON p.id_professor = a.id_professor
ORDER BY p.id_professor, a.disciplina;
