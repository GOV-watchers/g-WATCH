-- 3. How many hours would the average family have to work to afford a 5% down payment on a home in the USA between 1980 to 2020?

{{
    config(
        materalized = 'table',
    )
}}

WITH MHI_MHP AS(
    SELECT * FROM {{ ref('int_mhi_mhp') }}
),
Intermediate AS (
    SELECT 
        MHI_ID AS ID,
        MHI_BY_YEAR AS YEAR, 
        MHI,
        (MHP * 0.05) AS FIVE_DOWNPAYMENT,
        MHP
    FROM MHI_MHP
)
SELECT
    ID,
    YEAR,
    MHI,
    FIVE_DOWNPAYMENT,
    MHP,
    SUBSTRING(ROUND((FIVE_DOWNPAYMENT / MHI) * 1920, 0), 1, 3) AS HOUR_FOR_PAYMENT
FROM Intermediate
ORDER BY YEAR