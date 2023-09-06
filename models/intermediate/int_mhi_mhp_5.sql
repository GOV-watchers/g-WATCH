-- How many hours would the average family have to work to afford a 5% down payment on a home in the USA between 1980 to 2020?
WITH MHI AS (
    SELECT * FROM {{ ref('stg_mhi') }}
),
MHP AS (
    SELECT * FROM {{ ref('stg_mhp') }}
),
Intermediate AS (
    SELECT 
        MHI.MHI_ID AS ID,
        MHI.MHI_BY_YEAR AS YEAR, 
        MHI.MHI,
        (MHP.MHP * 0.05) AS FIVE_DOWNPAYMENT,
        MHP.MHP
    FROM MHI
    JOIN MHP ON MHP.MHP_BY_YEAR = MHI.MHI_BY_YEAR
    WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR <= '2020'
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