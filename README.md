# 🏦Normalização SQL🎲

Projeto acadêmico sobre **normalização de bancos de dados relacionais**, com foco na organização das tabelas, redução de redundâncias e garantia da integridade dos dados.

O projeto apresenta conceitos e exemplos das formas normais, incluindo a Primeira Forma Normal (1FN), Segunda Forma Normal (2FN), Terceira Forma Normal (3FN), Forma Normal de Boyce-Codd (FNBC), etc.

O site foi desenvolvido com **HTML, CSS e JavaScript**, oferecendo conteúdo explicativo sobre normalização, exemplos práticos e referências para aprofundamento.

## Objetivo

Demonstrar como aplicar as técnicas de normalização para construir bancos de dados mais organizados, consistentes e fáceis de manter.

## 🤖Tecnologias utilizadas

- HTML5
- CSS3
- JavaScript
- SQL

## 📲Como executar

1. Baixe ou clone o repositório.
2. Extraia os arquivos, caso estejam compactados.
3. Abra o arquivo `index.html` no navegador.

# 📃Pesquisa: Segunda Forma Normal (2FN) e Forma Normal de Boyce-Codd (FNBC)
<small> Feito por: Yasmin Santos de Lima</small> 

## 1. Introdução

A normalização é um processo utilizado no projeto de bancos de dados relacionais para organizar as informações, reduzir redundâncias e evitar anomalias de inserção, atualização e exclusão. Entre as formas normais existentes, destacam-se a Segunda Forma Normal (2FN) e a Forma Normal de Boyce-Codd (FNBC), que estabelecem regras para melhorar a estrutura e a consistência das tabelas.

## 2. Segunda Forma Normal (2FN)

A Segunda Forma Normal (2FN) é uma etapa da normalização que tem como objetivo eliminar as dependências parciais. Uma tabela está na 2FN quando atende à Primeira Forma Normal (1FN) e todos os atributos não primos dependem funcionalmente de toda chave candidata, e não apenas de uma parte dela.

Esse problema ocorre principalmente em tabelas que utilizam chaves compostas, ou seja, chaves formadas por duas ou mais colunas.

### 2.1. Exemplo prático

Considere a tabela de matrículas abaixo:

| ID_Aluno | ID_Curso | Nome_Aluno | Nome_Curso |
|---|---|---|---|
| 1 | 101 | Ana | Banco de Dados |
| 1 | 102 | Ana | Programação |
| 2 | 101 | Pedro | Banco de Dados |

Nesse exemplo, a chave primária composta é formada por `ID_Aluno` e `ID_Curso`.

Entretanto, `Nome_Aluno` depende apenas de `ID_Aluno`, enquanto `Nome_Curso` depende apenas de `ID_Curso`. Essas dependências são parciais, pois os atributos não dependem da chave composta inteira.

### 2.2. Aplicação da 2FN

Para eliminar as dependências parciais, a tabela pode ser dividida em três tabelas:

**Tabela Alunos**

| ID_Aluno (PK) | Nome_Aluno |
|---|---|
| 1 | Ana |
| 2 | Pedro |

**Tabela Cursos**

| ID_Curso (PK) | Nome_Curso |
|---|---|
| 101 | Banco de Dados |
| 102 | Programação |

**Tabela Matriculas**

| ID_Aluno (PK, FK) | ID_Curso (PK, FK) |
|---|---|
| 1 | 101 |
| 1 | 102 |
| 2 | 101 |

A separação permite armazenar os dados dos alunos e dos cursos uma única vez. A tabela `Matriculas` relaciona os alunos aos cursos por meio de chaves estrangeiras, que também formam sua chave primária composta.

### 2.3. Vantagens da 2FN

- Reduz a redundância de informações.
- Evita inconsistências durante a atualização dos dados.
- Facilita a manutenção das tabelas.
- Melhora a organização e a integridade do banco de dados.

## 3. Forma Normal de Boyce-Codd (FNBC)

A Forma Normal de Boyce-Codd (FNBC), conhecida em inglês como *Boyce-Codd Normal Form* (BCNF), é uma forma mais rigorosa de normalização que a Terceira Forma Normal (3FN).

Uma tabela está na FNBC quando, para toda dependência funcional não trivial `X → Y`, o determinante `X` é uma superchave da relação.

Uma dependência funcional significa que o valor de um atributo ou conjunto de atributos determina o valor de outro atributo. Uma superchave é um conjunto de atributos capaz de identificar unicamente cada registro de uma tabela.

A FNBC busca eliminar determinadas redundâncias e anomalias que ainda podem existir mesmo após a aplicação da 3FN.

### 3.1. Exemplo prático

Considere uma tabela que relaciona professores, disciplinas e salas:

| Professor | Disciplina | Sala |
|---|---|---|
| Ana | Matemática | A101 |
| Bruno | História | B202 |
| Ana | Física | A101 |

Considere as seguintes regras de negócio:

- Cada professor é responsável por uma única sala.
- Um professor pode ministrar várias disciplinas.
- A combinação de professor e disciplina identifica cada registro.

Nesse cenário, existe a dependência funcional:

`Professor → Sala`

A chave candidata da tabela é formada por `Professor` e `Disciplina`. Como um professor pode ministrar várias disciplinas, `Professor` sozinho não identifica cada registro. Portanto, não é uma superchave.

Assim, a dependência `Professor → Sala` viola a FNBC, pois seu determinante não é uma superchave.

### 3.2. Aplicação da FNBC

Para corrigir o problema, a tabela pode ser decomposta em duas:

**Tabela Professores**

| Professor (PK) | Sala |
|---|---|
| Ana | A101 |
| Bruno | B202 |

**Tabela Aulas**

| Professor (PK, FK) | Disciplina (PK) |
|---|---|
| Ana | Matemática |
| Bruno | História |
| Ana | Física |

Na tabela `Professores`, cada professor é armazenado uma única vez, junto à sua sala. Na tabela `Aulas`, ficam registradas as disciplinas ministradas por cada professor.

Essa decomposição elimina a repetição desnecessária das salas e, sob as regras de negócio apresentadas, permite reconstruir os dados originais por meio de uma junção sem perda de informações.

### 3.3. Vantagens da FNBC

- Elimina determinadas redundâncias que podem permanecer após a 3FN.
- Reduz anomalias de inserção, atualização e exclusão.
- Melhora a consistência e a integridade dos dados.
- Contribui para uma estrutura de banco de dados mais organizada.

## 4. Diferenças entre 2FN e FNBC

| Critério | Segunda Forma Normal (2FN) | Forma Normal de Boyce-Codd (FNBC) |
|---|---|---|
| Objetivo | Eliminar dependências parciais. | Garantir que todo determinante de uma dependência funcional não trivial seja uma superchave. |
| Foco | Dependências de atributos em relação a partes de chaves candidatas. | Dependências funcionais em geral. |
| Abrangência | Trata especificamente das dependências parciais. | É mais rigorosa que a 3FN. |
| Benefício | Reduz repetições causadas por dependências parciais. | Elimina determinadas anomalias que podem permanecer na 3FN. |

A FNBC implica a 3FN, a 2FN e a 1FN. Entretanto, uma tabela na 3FN nem sempre atende à FNBC.

## 5. Conclusão

A Segunda Forma Normal e a Forma Normal de Boyce-Codd são importantes para a construção de bancos de dados relacionais consistentes e eficientes.

A 2FN elimina dependências parciais, garantindo que os atributos não primos dependam das chaves candidatas inteiras. Já a FNBC estabelece uma regra mais rigorosa para as dependências funcionais, exigindo que todo determinante de uma dependência não trivial seja uma superchave.

No contexto do projeto Normalização-SQL, a aplicação dessas formas normais contribui para reduzir redundâncias, evitar inconsistências e facilitar a manutenção das tabelas. Dessa forma, a normalização ajuda a construir bancos de dados mais confiáveis, organizados e adequados às regras de negócio.

## 6. Referências bibliográficas

1. BCcampus Open Education. **Database Design — Chapter 12: Normalization**. Disponível em: https://opentextbc.ca/dbdesign01/chapter/chapter-12-normalization/

3. LibreTexts. **Boyce-Codd Normal Form (BCNF)**. Disponível em: https://eng.libretexts.org/Bookshelves/Computer_Science/Databases_and_Data_Structures/Relational_Databases_and_Microsoft_Access_%28McFadyen%29/10%3A_Normalization/10.05%3A_Boyce-Codd_Normal_Form_%28BCNF%29


