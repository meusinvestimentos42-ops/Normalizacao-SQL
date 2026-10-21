-- FNBC

------------------------------------
-- Forma incorreta de fazer a FNBC
------------------------------------

DROP TABLE IF EXISTS atribuicao_aulas;

-- ERRADO: Violando a FNBC
-- A chave primária é (estudante, disciplina), mas existe a dependência funcional:
-- professor -> disciplina (e professor -> sala), onde professor NÃO é chave candidata.
CREATE TABLE atribuicao_aulas (
    estudante VARCHAR(100) NOT NULL,
    disciplina VARCHAR(100) NOT NULL,
    professor VARCHAR(100) NOT NULL,
    sala VARCHAR(10) NOT NULL,

    PRIMARY KEY (estudante, disciplina)
);

-- Inserindo os dados
-- O Dr. Carlos ensina Matemática na Sala A101
-- A Dra. Ana ensina Física na Sala B202
INSERT INTO atribuicao_aulas (estudante, disciplina, professor, sala)
VALUES
('João', 'Matemática', 'Dr. Carlos', 'A101'),
('Maria', 'Matemática', 'Dr. Carlos', 'A101'), -- Repetição desnecessária de disciplina e sala do Dr. Carlos
('João', 'Física',     'Dra. Ana',   'B202');

-- Consulta exibindo a tabela não normalizada em FNBC
SELECT * FROM atribuicao_aulas;

------------------------------------
-- Forma correta de fazer
------------------------------------

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
