# Dashboard de Vendas E-commerces da Olist

Este projeto faz parte do meu portfolio de projetos de visualização e análise de dados.

## Pré-Requisitos

Para executar o projeto completo são necessárias as seguintes ferramentas:

- Python 3.9
- Docker e docker-compose
- [sqlcmd](https://learn.microsoft.com/en-us/sql/tools/sqlcmd-utility)

## Ambiente de execução local

Obtenha uma cópia local do projeto:

```bash
  git clone https://github.com/IgorTrevelin/Dashboard-de-Vendas-E-commerces-da-Olist.git
```

Acesse o diretório raiz do projeto:

```bash
  cd Dashboard-de-Vendas-E-commerces-da-Olist
```

Instale as dependências de pacotes Python com pip:

```bash
  pip install -r requirements.txt
```

Crie as pastas **data/** e **logs/** dentro da raiz do projeto para persistência do banco de dados:

```bash
  mkdir data
  mkdir logs
```

Inicie o contêiner do Microsoft SQL Server com Docker:

```bash
  docker compose up -d
```

Execute o script schema.sql (isso pode levar alguns minutos):

```bash
  sqlcmd -S 127.0.0.1 -U sa -P MSSQL_Docker -i schema.sql
```

Pronto! Agora todos os dados utilizados nos dashboards já estão no banco de dados (tabelas TB_ACT\_\*).
