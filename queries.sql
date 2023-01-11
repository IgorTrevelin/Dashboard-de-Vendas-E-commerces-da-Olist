-- Análises com SQL

-- Valor Total de Receita
SELECT SUM(Payments.PAYMENT_VALUE) AS 'Receita Total'
FROM [OLIST].dbo.[TB_ACT_ORDER_PAYMENT] Payments;

-- Valor total de receita pelo ano da realização da compra
WITH RevenueByPurchaseYear (Year, Revenue) AS (
    SELECT 
        YEAR(Orders.PURCHASE_TIMESTAMP) AS Year,
        SUM(Payments.PAYMENT_VALUE) as Revenue
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
FROM RevenueByPurchaseYear;

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