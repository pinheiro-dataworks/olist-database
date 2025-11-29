README do Projeto Olist SQL
#Comunidade DS
Repositório com consultas SQL sobre o dataset Olist, usando SQLite e DBeaver

#Visão geral

Este repositório contém o arquivo de consultas SQL test-sql-olist.sql feito para explorar e responder perguntas de negócio sobre o banco de dados Olist. As consultas foram pensadas para rodar no SQLite (arquivo db_olist.sqlite) e podem ser executadas facilmente no DBeaver.

Arquivo principal: test-sql-olist.sql
Banco local: db_olist.sqlite (recomendado NÃO versionar)
Ferramentas: DBeaver + SQLite

Estrutura sugerida do repositório

Bdados/
├─ test-sql-olist.sql
├─ .gitignore
├─ .gitattributes
└─ README.md

test-sql-olist.sql: script com 153 consultas SQL.
.gitignore: evita enviar o banco db_olist.sqlite para o GitHub.
.gitattributes: garante que o GitHub reconheça arquivos .sql como SQL.
README.md: este documento.

Como executar as consultas

#1) Preparar o banco (SQLite)

Coloque o arquivo db_olist.sqlite na mesma pasta do test-sql-olist.sql.
Exemplo de pasta no Windows:C:\Users\rfppr\Downloads\COMUNIDADE DS\repos\Bdados\

#2) Abrir no DBeaver

Abra o DBeaver.
Crie uma conexão SQLite:New → SQLite → “SQLite (SQLite JDBC)”.
Em “Database file”, selecione db_olist.sqlite.
Finish.

Abra o arquivo test-sql-olist.sql (File → Open) ou cole o conteúdo no SQL Editor conectado ao SQLite.
Selecione um bloco de consulta e execute (Ctrl+Enter). Cada instrução termina com ;.

Dica: você pode executar consultas individuais selecionando o trecho desejado antes de pressionar Ctrl+Enter.

Ideal para análises exploratórias e validação de hipóteses de negócio.

#Forçar reconhecimento de SQL no GitHub (opcional)

Crie um .gitattributes na raiz do repositório com:

*.sql linguist-language=SQL
*.sql linguist-detectable=true

Isso ajuda o GitHub a:
Exibir “SQL” como linguagem do arquivo
Considerar .sql nas estatísticas de linguagem do repositório

#Boas práticas

Não versionar o arquivo db_olist.sqlite (use .gitignore).
Deixar consultas bem comentadas e com aliases consistentes.
Preferir datas no padrão ISO YYYY-MM-DD em filtros.
Usar COUNT(DISTINCT ...) para métricas de unicidade.
Evitar funções não suportadas pelo SQLite (ex.: MAX(DISTINCT col)).

#Requisitos

DBeaver (qualquer versão recente)
SQLite (driver nativo já incluso no DBeaver)
Git + VSCode (para versionar o projeto)

Créditos e dados

Dataset: Olist (marketplace brasileiro, disponibilizado publicamente).
Uso educacional/demonstração de SQL para análises de negócio.