# 📚 Guia Prático de Normalização de Banco de Dados: 1FN, 2FN e 3FN

> **Página do Projeto:** [https://normalizacao-sql.vercel.app/trabalho.html](https://normalizacao-sql.vercel.app/trabalho.html)

---

## 📌 Sobre o Projeto

Este projeto é um artigo técnico e interativo voltado para estudantes de TI e desenvolvedores iniciantes que já conhecem a sintaxe básica de SQL, mas desejam dominar a **modelagem relacional** e evitar armadilhas comuns em bancos de dados.

Através de uma abordagem intuitiva e prática ("exemplo antes da teoria"), explicamos como identificar **anomalias de inserção, atualização e exclusão** e como aplicar a **Primeira (1FN), Segunda (2FN) e Terceira Formas Normais (3FN)** para decompor tabelas redundantes.

---

## 👨‍💻 Autores e Equipe

| Nome | Bio / Área | Links |
| --- | --- | --- |
| **Isabella de Almeida Santos** | Estudante de Ciências da Computação, no 2° semestre, com foco em Front-End e Full-Stack. |  [![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/isabella-de-almeida-santos-86bb333b0/)](https://www.linkedin.com/in/isabella-de-almeida-santos-86bb333b0/) [![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github&link=https://github.com/meusinvestimentos42-ops/)](https://github.com/meusinvestimentos42-ops/) |
| **Sara dos Santos de Oliveira** | Estudante de Análise e Desenvolvimento de Sistemas, me encontro no 2° semestre do mesmo, área de interesse atualmente é seguir áreas que tenham contato com manipulação de dados. | [![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/sara-dos-santos-71913b42b/)](https://www.linkedin.com/in/sara-dos-santos-71913b42b/) [![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github&link=https://github.com/sarasoliv/)](https://github.com/sarasoliv/) |
| **Rodrygo Schadeck Gomes** | Estudante de Análise e Desenvolvimento de Sistemas, no 2° semestre, com foco na área Cyber Segurança. | [![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/rodrygo-schadeck-gomes-3b034b313/)](https://www.linkedin.com/in/rodrygo-schadeck-gomes-3b034b313/) [![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github&link=https://github.com/Rodrygo2766/)](https://github.com/Rodrygo2766/) |
| **Yasmin Santos de Lima** | Estudante de Análise e Desenvolvimento de Sistemas, no 2° semestre e com forte interesse em Cybersegurança e fullstack. |[![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/sara-dos-santos-71913b42b/)](https://www.linkedin.com/in/sara-dos-santos-71913b42b/) [![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github&link=https://github.com/sarasoliv/)](https://github.com/sarasoliv/) |


*Nota sobre privacidade: A publicação de fotos e perfis profissionais foi devidamente autorizada por cada integrante do grupo para fins acadêmicos (LGPD).*

---

## 📊 Quadro de Observação e Decisões de Projeto

### 1. Referências Analisadas
* **DataCamp (Tutorial de Normalização):** Destacou-se pela clareza das comparações "antes e depois" com tabelas.
* **DevMedia (Técnicas de Normalização):** Excelente uso de conceitos formais explicados em linguagem simples em português.

### 2. Três Decisões do Grupo
1. **Didática por Recorte Prático:** Optamos por usar como fio condutor um cenário real de **Planilha de Pedidos de uma Loja**, mostrando os problemas práticos antes de apresentar os termos formais como *dependência funcional*.
2. **PostgreSQL como SGBD Padrão:** Padronizamos todos os scripts de exemplo para PostgreSQL (v15+), garantindo idempotência com comandos `DROP TABLE IF EXISTS` e `CREATE TABLE`.
3. **Design Responsivo e Sem Frameworks:** Construímos a página utilizando HTML5 estático e CSS3 puro, garantindo leveza, acessibilidade mobile e renderização rápida sem depender de servidores adicionais.

### 3. O que decidimos NÃO fazer
* **Não cobrir Formas Normais Avançadas (BCNF, 4FN, 5FN):** Para manter a explicação profunda, focada e acessível ao público-alvo, decidimos restringir o escopo estritamente à 1FN, 2FN e 3FN.

---

## 🛠️ Como Executar os Scripts SQL Localmente

### Pré-requisitos
* **SGBD:** PostgreSQL (versão 15 ou superior) ou qualquer cliente SQL (DBeaver, pgAdmin, VS Code SQL Tools).

### Passo a Passo
1. Clone este repositório:
   ```bash
   git clone [https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git](https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git)
