--mhi, yearly_cpi
-- 8. Does the change in median household income align with changes in the cost of living as indicated by the Consumer Price Index (CPI)?

-- Create an intermediate table with both MHI and CPI data
WITH MHI AS (
    SELECT * FROM {{ref('stg_mhi')}}
),
CPI AS (
    SELECT * FROM {{ref('stg_yearly_cpi')}}
),

-- Calculate percentage change in MHI and CPI
PercentageChange AS (
    SELECT
        MHI.MHI_BY_YEAR AS Year,
        MHI.MHI AS Median_Household_Income,
        CPI.CPI_AVG AS Consumer_Price_Index,
        ((MHI.MHI - LAG(MHI.MHI) OVER (ORDER BY MHI.MHI_BY_YEAR)) / LAG(MHI.MHI) OVER (ORDER BY MHI.MHI_BY_YEAR)) * 100 AS MHI_Percentage_Change,
        ((CPI.CPI_AVG - LAG(CPI.CPI_AVG) OVER (ORDER BY CPI.CPI_BY_YEAR)) / LAG(CPI.CPI_AVG) OVER (ORDER BY CPI.CPI_BY_YEAR)) * 100 AS CPI_Percentage_Change
    FROM MHI
    JOIN CPI ON MHI.MHI_BY_YEAR = CPI.CPI_BY_YEAR
)

-- Compare the percentage changes and determine if income outpaced cost of living
SELECT
    ROW_NUMBER() OVER (ORDER BY Year) AS Primary_Key,
    Year,
    Median_Household_Income,
    Consumer_Price_Index,
    CASE
        WHEN MHI_Percentage_Change > CPI_Percentage_Change THEN 'Income Outpaced Cost of Living'
        WHEN MHI_Percentage_Change < CPI_Percentage_Change THEN 'Cost of Living Outpaced Income'
        ELSE 'Income and Cost of Living Aligned'
    END AS Comparison_Result
FROM PercentageChange
 