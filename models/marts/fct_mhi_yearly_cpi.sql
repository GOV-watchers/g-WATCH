-- 1. How has the trend of the Median Household Income been like from 1980-2020?

{{
    config(
        materalized = 'table',
    )
}}
WITH MHI_CPI AS(
    SELECT * FROM {{ ref('int_mhi_cpi') }}
),
-- Get the CPI of 2020
CPI_2020 AS (
    SELECT
        MAX(CPI_AVG) AS CPI_2020
    FROM MHI_CPI
    WHERE CPI_BY_YEAR = '2020'
)

-- Calculate the inflation-adjusted Median Household Income
SELECT 
    MHI_ID,
    MHI,
    MHI_BY_YEAR,
    CPI_AVG,
    SUBSTRING((MHI * (CPI_2020.CPI_2020 / CPI_AVG)),1,5) AS AdjustedMHI
FROM MHI_CPI
JOIN CPI_2020 ON 1=1 -- This is a placeholder join condition to ensure you use the CPI_2020 value