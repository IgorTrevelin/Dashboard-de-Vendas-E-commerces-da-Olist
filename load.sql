USE OLIST;

INSERT INTO dbo.TB_ACT_GEOLOCATION (
    ZIP_CODE_PREFIX,
    GEO_LAT,
    GEO_LNG,
    GEO_CITY,
    GEO_STATE
)
SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM dbo.TB_CG_GEOLOCATION;

INSERT INTO dbo.TB_ACT_CUSTOMER (
    ID,
    UNIQUE_ID,
    ZIP_CODE_PREFIX,
    CITY,
    STATE
)
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM dbo.TB_CG_CUSTOMER;

INSERT INTO dbo.TB_ACT_SELLER (
    ID,
    ZIP_CODE_PREFIX,
    CITY,
    STATE
)
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM dbo.TB_CG_SELLER;

INSERT INTO dbo.TB_ACT_PRODUCT (
    ID,
    CATEGORY_NAME,
    WEIGHT_G,
    LENGTH_CM,
    HEIGHT_CM,
    WIDTH_CM
)
SELECT
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM dbo.TB_CG_PRODUCT;

INSERT INTO dbo.TB_ACT_ORDER (
    ID,
    CUSTOMER,
    STATUS,
    PURCHASE_TIMESTAMP,
    APPROVED_AT,
    DELIVERED_CARRIER_DATE,
    DELIVERED_CUSTOMER_DATE,
    ESTIMATED_DELIVERY_DATE
)
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM dbo.TB_CG_ORDER;

INSERT INTO dbo.TB_ACT_ORDER_ITEMS (
    ORDER_ID,
    PRODUCT_ID,
    SELLER_ID,
    ORDER_ITEM_ID,
    SHIPPING_LIMIT_DATE,
    PRICE,
    FREIGHT_VALUE
)
SELECT
    order_id,
    product_id,
    seller_id,
    order_item_id,
    shipping_limit_date,
    price / 100,
    freight_value / 100
FROM dbo.TB_CG_ORDER_ITEMS;

INSERT INTO dbo.TB_ACT_ORDER_PAYMENT (
    ORDER_ID,
    PAYMENT_SEQUENTIAL,
    PAYMENT_TYPE,
    INSTALLMENTS,
    PAYMENT_VALUE
)
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value / 100
FROM dbo.TB_CG_ORDER_PAYMENTS;

INSERT INTO dbo.TB_ACT_ORDER_REVIEW (
    ID,
    ORDER_ID,
    SCORE,
    COMMENT_TITLE,
    COMMENT_MESSAGE,
    CREATION_DATE,
    ANSWER_TIMESTAMP
)
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM dbo.TB_CG_ORDER_REVIEWS;