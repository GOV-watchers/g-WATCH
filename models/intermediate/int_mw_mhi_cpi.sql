-- 9. Compare the changes in the minimum wage on people's ability to buy things compared to inflation (CPI) and the average household income over time?
WITH CPI AS (
    SELECT * FROM {{ ref ('stg_yearly_cpi') }}
),

MW AS (
    SELECT * FROM {{ ref ('stg_mw') }}
),
MHI AS (
    SELECT * FROM {{ ref ('stg_mhi')}}
),
-- GET THE CPI OF 2020
CPI_2020 AS (
    SELECT
        MAX(CPI_AVG) AS CPI_2020
    FROM CPI
    WHERE CPI_BY_YEAR = '2020'
)

SELECT * FROM MW
JOIN MHI ON MHI.MHI_BY_YEAR = MW.MW_BY_YEAR
JOIN CPI ON MW.MW_BY_YEAR = CPI.CPI_BY_YEAR
JOIN CPI_2020 ON 1=1
WHERE MW.MW_BY_YEAR >= '1980' AND MW.MW_BY_YEAR <= '2020'