-- 4FN

--Exemplo de como não fazer a 4FN

DROP TABLE IF EXISTS medicos_atributos;
DROP TABLE IF EXISTS medicos;

-- Tabela de médicos
CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome_medico VARCHAR(100) NOT NULL
);

-- ERRADO: Misturando duas dependências multivaloradas independentes (especialidade e idioma)
CREATE TABLE medicos_atributos (
    id_medico INT NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    idioma VARCHAR(50) NOT NULL,

    PRIMARY KEY (id_medico, especialidade, idioma),

    FOREIGN KEY (id_medico)
        REFERENCES medicos(id_medico)
        ON DELETE CASCADE
);

-- Inserindo o médico
INSERT INTO medicos (nome_medico)
VALUES ('Dr. Carlos');

-- ERRADO: Para associar 2 especialidades e 3 idiomas, 
-- é preciso criar o produto cartesiano (2 × 3 = 6 linhas)!
INSERT INTO medicos_atributos (id_medico, especialidade, idioma)
VALUES
(1, 'Cardiologia', 'Português'),
(1, 'Cardiologia', 'Inglês'),
(1, 'Cardiologia', 'Espanhol'),
(1, 'Pediatria',   'Português'),
(1, 'Pediatria',   'Inglês'),
(1, 'Pediatria',   'Espanhol');

-- Consulta resultando em dados duplicados e redundantes
SELECT 
    m.nome_medico,
    ma.especialidade,
    ma.idioma
FROM medicos m
JOIN medicos_atributos ma 
    ON m.id_medico = ma.id_medico;


--Como fazer corretamente a 4FN


DROP TABLE IF EXISTS medico_idioma;
DROP TABLE IF EXISTS medico_especialidade;
DROP TABLE IF EXISTS medicos;

-- Tabela de médicos
CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome_medico VARCHAR(100) NOT NULL
);

-- Especialidades de cada médico
CREATE TABLE medico_especialidade (
    id_medico INT NOT NULL,
    especialidade VARCHAR(100) NOT NULL,

    PRIMARY KEY (id_medico, especialidade),

    FOREIGN KEY (id_medico)
        REFERENCES medicos(id_medico)
        ON DELETE CASCADE
);

-- Idiomas falados por cada médico
CREATE TABLE medico_idioma (
    id_medico INT NOT NULL,
    idioma VARCHAR(50) NOT NULL,

    PRIMARY KEY (id_medico, idioma),

    FOREIGN KEY (id_medico)
        REFERENCES medicos(id_medico)
        ON DELETE CASCADE
);

-- Inserindo o médico
INSERT INTO medicos (nome_medico)
VALUES ('Dr. Carlos');

-- Inserindo as especialidades
INSERT INTO medico_especialidade
(id_medico, especialidade)
VALUES
(1, 'Cardiologia'),
(1, 'Pediatria');

-- Inserindo os idiomas
INSERT INTO medico_idioma
(id_medico, idioma)
VALUES
(1, 'Português'),
(1, 'Inglês'),
(1, 'Espanhol');

-- Consultando as especialidades
SELECT
    m.nome_medico,
    me.especialidade
FROM medicos m
JOIN medico_especialidade me
    ON m.id_medico = me.id_medico;

-- Consultando os idiomas
SELECT
    m.nome_medico,
    mi.idioma
FROM medicos m
JOIN medico_idioma mi
    ON m.id_medico = mi.id_medico;
