USE OLIST;

INSERT INTO dbo.TB_ACT_GEOLOCATION
SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM dbo.TB_CG_GEOLOCATION;

INSERT INTO dbo.TB_ACT_CUSTOMER
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM dbo.TB_CG_CUSTOMER;

INSERT INTO dbo.TB_ACT_SELLER
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM dbo.TB_CG_SELLER;

INSERT INTO dbo.TB_ACT_PRODUCT
SELECT
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM dbo.TB_CG_PRODUCT;

INSERT INTO dbo.TB_ACT_ORDER
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

INSERT INTO dbo.TB_ACT_ORDER_ITEMS
SELECT
    order_id,
    product_id,
    seller_id,
    order_item_id,
    shipping_limit_date,
    price,
    freight_value
FROM dbo.TB_CG_ORDER_ITEMS;

INSERT INTO dbo.TB_ACT_ORDER_PAYMENT
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value / 100 AS payment_value
FROM dbo.TB_CG_ORDER_PAYMENTS;

INSERT INTO dbo.TB_ACT_ORDER_REVIEW
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM dbo.TB_CG_ORDER_REVIEWS;