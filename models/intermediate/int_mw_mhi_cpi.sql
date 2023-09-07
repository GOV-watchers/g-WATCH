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
),

-- CALCULATE THE INFLATION-ADJUSTED
YearlyData AS (
    SELECT
        MW.ID_MW AS ID,
        MW.FEDERAL_MINIMUM_WAGE,
        MW.MW_BY_YEAR AS YEAR,
        CPI.CPI_AVG,
        CAST(ROUND(MW.FEDERAL_MINIMUM_WAGE * 1920, 0) AS VARCHAR(10)) || '.00' AS MW_YEARLY_SALARY,
        CAST((MHI.MHI - ROUND(MW.FEDERAL_MINIMUM_WAGE * 1920, 0))AS VARCHAR(10)) || '.00' AS SALARY_DIFFERENCE,
        CAST(MHI.MHI AS VARCHAR(10)) || '.00' AS MHI_YEARLY_SALARY
    FROM MW
    JOIN MHI ON MHI.MHI_BY_YEAR = MW.MW_BY_YEAR
    JOIN CPI ON MW.MW_BY_YEAR = CPI.CPI_BY_YEAR
    JOIN CPI_2020 ON 1=1
    WHERE MW.MW_BY_YEAR >= '1980' AND MW.MW_BY_YEAR <= '2020'
)

SELECT 
    FIVE_YEAR_INTERVAL,
    AVG(ROUND(CPI_AVG, 0)) AS CPI_AVG,
    AVG(CAST(MW_YEARLY_SALARY AS DECIMAL(10,2))) AS AVG_MW_YEARLY_SALARY,
    AVG(CAST(SALARY_DIFFERENCE AS DECIMAL(10,2))) AS AVG_DIFFERENCE_SALARY,
    AVG(CAST(MHI_YEARLY_SALARY AS DECIMAL(10,2))) AS AVG_MHI_YEARLY_SALARY
FROM(
    SELECT 
        ID,
        FEDERAL_MINIMUM_WAGE,
        YEAR,
        CPI_AVG,
        MW_YEARLY_SALARY,
        SALARY_DIFFERENCE,
        MHI_YEARLY_SALARY,
        CONCAT(
            FLOOR(YEAR/5) * 5,
            '-',
            FLOOR(YEAR/5) * 5 + 5
        ) AS FIVE_YEAR_INTERVAL
    FROM YearlyData
)AS IntervalData
GROUP BY FIVE_YEAR_INTERVAL
ORDER BY FIVE_YEAR_INTERVAL