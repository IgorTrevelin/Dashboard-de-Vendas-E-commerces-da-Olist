# Dashboard de Vendas E-commerces da Olist

Este projeto faz parte do meu portfolio de projetos de visualização e análise de dados.

## Pré-Requisitos

Para executar o projeto completo são necessárias as seguintes ferramentas:

- Docker (plugin compose)
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

Inicie o contêiner do Microsoft SQL Server com Docker:

```bash
docker compose up -d
```

Execute o script schema.sql para inicializar a estrutura do banco de dados:

```bash
sqlcmd -S 127.0.0.1 -U sa -P MSSQL_Docker -i schema.sql
```

Abra o **Microsoft SQL Server Management Studio** e realize a conexão com o banco de dados como na imagem abaixo:

<img src="https://i.imgur.com/D0O3k7F.png">

**OBS: utilize a senha "MSSQL_Docker" como especificado no arquivo docker-compose.yml**

No menu lateral da esquerda, procure o database **OLIST** e clique com o botão direito (**Tasks -> Import Flat File**). Realize a importação dos arquivos .csv do diretório _csv_ utilizando os seguintes nomes para as tabelas de carga:

- **olist_customers_dataset.csv:** TB_CG_CUSTOMER
- **olist_geolocation_dataset.csv:** TB_CG_GEOLOCATION
- **olist_order_items_dataset.csv:** TB_CG_ORDER_ITEMS
- **olist_order_payments_dataset.csv:** TB_CG_ORDER_PAYMENTS
- **olist_order_reviews_dataset.csv:** TB_CG_ORDER_REVIEWS
- **olist_orders_dataset.csv:** TB_CG_ORDER
- **olist_products_dataset.csv:** TB_CG_PRODUCT
- **olist_sellers_dataset.csv:** TB_CG_SELLER


Após relizada a importação de todos os arquivos csv, feche o _Microsoft SQL Server Management Studio_ e execute o script **load.sql**:

```bash
sqlcmd -S 127.0.0.1 -U sa -P MSSQL_Docker -i load.sql
```

Pronto! Agora todos os dados utilizados nos dashboards já estão no banco de dados (tabelas TB_ACT\_\*).
