-- 6. Comparing minimum wage trends in the 80s, 90s and 2000s, would it have been possible to afford a 5% down-payment 
-- and what are the difference in the hours needed to reach that affordability level?

-- The goal here is to see if someone earning minimum wage in 1980/90s would be more likely to afford a downpayment for the house 
-- and what was the cut off point for that ability/ affordability level

-- WITH MW AS (
--     SELECT * FROM {{ref('stg_mw')}}
-- ),

-- MHP AS (
--     SELECT * FROM {{ref('stg_mhp')}}
-- ),

-- CPI AS (
--      SELECT * FROM {{ref('stg_yearly_cpi')}}
-- ),

-- DecadeData AS (
--     SELECT
--         MHP.MHP_ID,
--         MHP.MHP_BY_YEAR,
--         MHP.MHP / 20 AS DownPayment,
--         MW.FEDERAL_MINIMUM_WAGE AS MW,
--         CPI.CPI_AVG,
--         (MHP.MHP / 20) / (MW * (CPI.CPI_AVG / 100)) AS HoursNeeded
--     FROM
--         MHP
--     JOIN
--         MW
--     ON
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 4) = SUBSTRING(MW.MW_BY_YEAR, 1, 4)
--     JOIN
--         CPI
--     ON
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 4) = SUBSTRING(CPI.CPI_BY_YEAR, 1, 4)
-- )

-- SELECT
--     DecadeData.*,
--     (DecadeData.DownPayment * DecadeData.MW) AS IncomeNeeded,
--     (DecadeData.MW - (DecadeData.DownPayment * DecadeData.MW)) AS IncomeDifference
-- FROM
--     DecadeData;


-- WITH MW AS (
--     SELECT * FROM {{ref('stg_mw')}}
-- ),

-- MHP AS (
--     SELECT * FROM {{ref('stg_mhp')}}
-- ),

-- CPI AS (
--      SELECT * FROM {{ref('stg_yearly_cpi')}}
-- ),

-- DecadeData AS (
--     SELECT
--         MHP.MHP_ID,
--         MHP.MHP_BY_YEAR,
--         MHP.MHP / 20 AS DownPayment,
--         MW.FEDERAL_MINIMUM_WAGE AS MW,
--         CPI.CPI_AVG,
--         SUBSTRING(((MHP.MHP / 20) / (0.5 * MW * (CPI.CPI_AVG / 100) * 1920)*1920),1,4) AS HoursNeeded
--     FROM
--         MHP
--     JOIN
--         MW
--     ON
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 4) = SUBSTRING(MW.MW_BY_YEAR, 1, 4)
--     JOIN
--         CPI
--     ON
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 4) = SUBSTRING(CPI.CPI_BY_YEAR, 1, 4)
-- )

-- SELECT
--     DecadeData.*,
--     (DecadeData.DownPayment * 0.5 * DecadeData.MW * 1920) AS IncomeNeeded,
--     (0.5 * DecadeData.MW * 1920 - (DecadeData.DownPayment * 0.5 * DecadeData.MW * 1920)) AS IncomeDifference
-- FROM
--     DecadeData;

WITH MW AS (
    SELECT * FROM {{ref('stg_mw')}}
),

MHP AS (
    SELECT * FROM {{ref('stg_mhp')}}
),

CPI AS (
    SELECT * FROM {{ref('stg_yearly_cpi')}}
)

SELECT * FROM MW
JOIN MHP ON MHP.MHP_BY_YEAR = MW.MW_BY_YEAR
JOIN CPI ON CPI.CPI_BY_YEAR = MHP.MHP_BY_YEAR
WHERE CPI.CPI_BY_YEAR >= '1980' AND CPI.CPI_BY_YEAR <= '2020'
ORDER BY CPI.CPI_BY_YEAR

-- DecadeData AS (
--     SELECT
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 3) || '0s' AS Decade,
--         AVG(MHP.MHP / 20) AS AvgDownPayment,
--         MW.FEDERAL_MINIMUM_WAGE AS MW,
--         AVG(CPI.CPI_AVG) AS AvgCPI,
--         SUBSTRING(((AVG(MHP.MHP / 20) / (0.5 * MW * (AVG(CPI.CPI_AVG) / 100) * 1920)) * 1920), 1, 4) AS AvgHoursNeeded
--     FROM
--         MHP
--     JOIN
--         MW
--     ON
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 4) = SUBSTRING(MW.MW_BY_YEAR, 1, 4)
--     JOIN
--         CPI
--     ON
--         SUBSTRING(MHP.MHP_BY_YEAR, 1, 4) = SUBSTRING(CPI.CPI_BY_YEAR, 1, 4)
--     GROUP BY
--         Decade, MW.FEDERAL_MINIMUM_WAGE
-- )

-- SELECT
--    DecadeData.Decade,
--     ROUND(AVG(DecadeData.AvgDownPayment), 0) AS AvgDownPayment,
--     ROUND(AVG(DecadeData.MW), 0) AS AvgMW,
--     ROUND(AVG(DecadeData.AvgCPI), 0) AS AvgCPI, 
--     ROUND(AVG(DecadeData.AvgHoursNeeded), 0) AS AvgHoursNeeded, 
--     ROUND((AVG(DecadeData.AvgDownPayment) * 0.5 * AVG(DecadeData.MW) * 1920), 0) AS AvgIncomeNeeded, 
--     ROUND((0.5 * AVG(DecadeData.MW) * 1920 - (AVG(DecadeData.AvgDownPayment) * 0.5 * AVG(DecadeData.MW) * 1920)), 0) AS AvgIncomeDifference
-- FROM
--     DecadeData
-- GROUP BY
--     Decade





