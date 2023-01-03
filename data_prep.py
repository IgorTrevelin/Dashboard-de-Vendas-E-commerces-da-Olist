from sqlalchemy import create_engine, text
import pandas as pd

db_user = "sa"
db_password = "MSSQL_Docker"
db_name = "OLIST"

engine = create_engine(
    f"mssql+pyodbc://{db_user}:{db_password}@127.0.0.1:1433/OLIST?driver=SQL+Server+Native+Client+11.0",
    fast_executemany=True,
)

data = {
    "TB_CG_GEOLOCATION": pd.read_csv("./csv/olist_geolocation_dataset.csv", header=0),
    "TB_CG_CUSTOMER": pd.read_csv("./csv/olist_customers_dataset.csv", header=0),
    "TB_CG_SELLER": pd.read_csv("./csv/olist_sellers_dataset.csv", header=0),
    "TB_CG_PRODUCT": pd.read_csv("./csv/olist_products_dataset.csv", header=0),
    "TB_CG_ORDER": pd.read_csv("./csv/olist_orders_dataset.csv", header=0),
    "TB_CG_ORDER_ITEMS": pd.read_csv("./csv/olist_order_items_dataset.csv", header=0),
    "TB_CG_ORDER_PAYMENTS": pd.read_csv(
        "./csv/olist_order_payments_dataset.csv", header=0
    ),
    "TB_CG_ORDER_REVIEWS": pd.read_csv(
        "./csv/olist_order_reviews_dataset.csv", header=0
    ),
}

for tb_name, df in data.items():
    try:
        print(f"Creating table {tb_name}")
        df.to_sql(tb_name, con=engine, schema="dbo", index=False, if_exists="replace")
        print(f"Table {tb_name} created succesfully!")
    except Exception as ex:
        print(f"Exception: {ex}")