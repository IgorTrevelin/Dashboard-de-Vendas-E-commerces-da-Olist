-- Análises com SQL

-- Valor Total de Receita
SELECT SUM(Payments.PAYMENT_VALUE) AS 'Receita Total'
FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments;

-- Valor total de receita pelo ano da realização da compra
WITH RevenueByPurchaseYear (Year, Revenue) AS (
    SELECT 
        YEAR(Orders.PURCHASE_TIMESTAMP),
        SUM(Payments.PAYMENT_VALUE)
    FROM [OLIST].dbo.[TB_ACT_ORDER] Orders JOIN [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments
        ON Orders.ID = Payments.ORDER_ID
    GROUP BY YEAR(Orders.PURCHASE_TIMESTAMP)
),
TotalRevenueValue (Val) AS (
    SELECT SUM(Payments.PAYMENT_VALUE) FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments
)
SELECT
Year as Ano,
Revenue as Receita,
CONVERT(
    DECIMAL(5,2),
    Revenue * 100 / (SELECT Val FROM TotalRevenueValue)
) AS ReceitaPct
FROM RevenueByPurchaseYear
ORDER BY Year;

-- Valor total de receita pelo ano/mês da realização da compra
WITH RevenueByPurchaseYearMonth (Year, Month, Revenue) AS (
    SELECT 
        YEAR(Orders.PURCHASE_TIMESTAMP),
        MONTH(Orders.PURCHASE_TIMESTAMP),
        SUM(Payments.PAYMENT_VALUE)
    FROM [OLIST].dbo.[TB_ACT_ORDER] Orders JOIN [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments
        ON Orders.ID = Payments.ORDER_ID
    GROUP BY YEAR(Orders.PURCHASE_TIMESTAMP), MONTH(Orders.PURCHASE_TIMESTAMP)
),
TotalRevenueValue (Val) AS (
    SELECT SUM(Payments.PAYMENT_VALUE) FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments
)
SELECT
Year as Ano,
Month as 'Mês',
Revenue as Receita,
CONVERT(
    DECIMAL(5,2),
    Revenue * 100 / (SELECT Val FROM TotalRevenueValue)
) AS ReceitaPct
FROM RevenueByPurchaseYearMonth
ORDER BY Year, Month;

-- Ticket Médio
WITH OrderTicket (Ticket) AS (
    SELECT SUM(Payments.PAYMENT_VALUE)
    FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments
    GROUP BY Payments.ORDER_ID
)
SELECT 
    CONVERT(
        DECIMAL(10,2),
        AVG(Ticket)
    ) AS 'Ticket Médio'
FROM OrderTicket;

-- Ticker Médio por Ano
WITH OderYearTicket (OrderYear, Ticket) AS (
    SELECT
        YEAR(Orders.PURCHASE_TIMESTAMP),
        SUM(Payments.PAYMENT_VALUE)
    FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments JOIN [OLIST].dbo.[TB_ACT_ORDER] Orders
        ON Payments.ORDER_ID = Orders.ID
    GROUP BY Payments.ORDER_ID, YEAR(Orders.PURCHASE_TIMESTAMP)
)
SELECT
    OrderYear as Ano,
    CONVERT(
        DECIMAL(10,2),
        AVG(Ticket)
    ) AS 'Ticket Médio'
FROM OderYearTicket
GROUP BY OrderYear
ORDER BY OrderYear;

-- Ticker Médio por Ano/Mês
WITH OderYearMonthTicket (OrderYear, OrderMonth, Ticket) AS (
    SELECT
        YEAR(Orders.PURCHASE_TIMESTAMP),
        MONTH(Orders.PURCHASE_TIMESTAMP),
        SUM(Payments.PAYMENT_VALUE)
    FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments JOIN [OLIST].dbo.[TB_ACT_ORDER] Orders
        ON Payments.ORDER_ID = Orders.ID
    GROUP BY Payments.ORDER_ID, YEAR(Orders.PURCHASE_TIMESTAMP), MONTH(Orders.PURCHASE_TIMESTAMP)
)
SELECT
    OrderYear as Ano,
    OrderMonth as 'Mês',
    CONVERT(
        DECIMAL(10,2),
        AVG(Ticket)
    ) AS 'Ticket Médio'
FROM OderYearMonthTicket
GROUP BY OrderYear, OrderMonth
ORDER BY OrderYear ASC, OrderMonth ASC;

-- Top 10 categorias de produtos mais vendidos

SELECT TOP 10
    Products.CATEGORY_NAME AS 'CategoriaProduto',
    COUNT(Products.CATEGORY_NAME) AS 'NumVendas'
FROM [OLIST].dbo.[TB_ACT_ORDER_ITEMS] OrderItems JOIN [OLIST].dbo.[TB_ACT_PRODUCT] Products
    ON OrderItems.PRODUCT_ID = Products.ID
GROUP BY Products.CATEGORY_NAME
ORDER BY COUNT(Products.CATEGORY_NAME) DESC;

-- Top 10 Vendedores por número de items vendidos

SELECT TOP 10
    Sellers.ID as Vendedor,
    COUNT(Sellers.ID) as 'NumItemsVendidos'
FROM [OLIST].dbo.[TB_ACT_ORDER_ITEMS] OrderItems JOIN [OLIST].dbo.[TB_ACT_SELLER] Sellers
    ON OrderItems.SELLER_ID = Sellers.ID
GROUP BY Sellers.ID
ORDER BY COUNT(Sellers.ID) DESC;

-- Top 10 Vendedores por receita

SELECT TOP 10
    Sellers.ID as Vendedor,
    SUM(OrderItems.PRICE) as 'Receita'
FROM [OLIST].dbo.[TB_ACT_ORDER_ITEMS] OrderItems JOIN [OLIST].dbo.[TB_ACT_SELLER] Sellers
    ON OrderItems.SELLER_ID = Sellers.ID
GROUP BY Sellers.ID
ORDER BY SUM(OrderItems.PRICE) DESC;