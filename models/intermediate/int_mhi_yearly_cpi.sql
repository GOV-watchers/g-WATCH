--How has the trend of the Median Household Income been like from 1980-2020?
-- Reference the MHI and CPI models
WITH MHI AS (
    SELECT *
    FROM {{ ref('stg_mhi') }}
),
CPI AS (
    SELECT *
    FROM {{ ref('stg_yearly_cpi') }}
)
-- Get the CPI of 2020
, CPI_2020 AS (
    SELECT
        MAX(CPI_AVG) AS CPI_2020
    FROM CPI
    WHERE CPI_BY_YEAR = '2020'
)

-- Calculate the inflation-adjusted Median Household Income
SELECT
    M.MHI_ID,
    M.MHI,
    M.MHI_BY_YEAR,
    C.CPI_AVG,
    SUBSTRING((M.MHI * (CPI_2020.CPI_2020 / C.CPI_AVG)),1,5) AS AdjustedMHI
FROM MHI M
JOIN CPI C ON M.MHI_BY_YEAR = C.CPI_BY_YEAR
JOIN CPI_2020 ON 1=1 -- This is a placeholder join condition to ensure you use the CPI_2020 value
WHERE M.MHI_BY_YEAR >= '1980' AND M.MHI_BY_YEAR <= '2020'
ORDER BY M.MHI_BY_YEAR