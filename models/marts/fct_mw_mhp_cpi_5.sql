-- 6. Comparing minimum wage trends in the 80s, 90s and 2000s, would it have been possible to afford a 5% down-payment 
-- and what are the difference in the hours needed to reach that affordability level?

-- The goal here is to see if someone earning minimum wage in 1980/90s would be more likely to afford a downpayment for the house 
-- and what was the cut off point for that ability/ affordability level

{{
    config(
        materalized = 'table',
    )
}}

WITH MW_MHI_CPI AS(
    SELECT * FROM {{ ref('int_mw_mhp_cpi') }}
),

DecadeData AS (
    SELECT
        SUBSTRING(MHP_BY_YEAR, 1, 3) || '0s' AS Decade,
        AVG(MHP / 20) AS AvgDownPayment,
        FEDERAL_MINIMUM_WAGE AS MW,
        AVG(CPI_AVG) AS AvgCPI,
        SUBSTRING(((AVG(MHP / 20) / (0.5 * MW * (AVG(CPI_AVG) / 100) * 1920)) * 1920), 1, 4) AS AvgHoursNeeded
    FROM MW_MHI_CPI
    WHERE SUBSTRING(MHP_BY_YEAR, 1, 4) = SUBSTRING(MW_BY_YEAR, 1, 4) AND SUBSTRING(MHP_BY_YEAR, 1, 4) = SUBSTRING(CPI_BY_YEAR, 1, 4)
    GROUP BY
        Decade, FEDERAL_MINIMUM_WAGE
)

SELECT
   DecadeData.Decade,
    ROUND(AVG(DecadeData.AvgDownPayment), 0) AS AvgDownPayment,
    ROUND(AVG(DecadeData.MW), 0) AS AvgMW,
    ROUND(AVG(DecadeData.AvgCPI), 0) AS AvgCPI, 
    ROUND(AVG(DecadeData.AvgHoursNeeded), 0) AS AvgHoursNeeded, 
    ROUND((AVG(DecadeData.AvgDownPayment) * 0.5 * AVG(DecadeData.MW) * 1920), 0) AS AvgIncomeNeeded, 
    ROUND((0.5 * AVG(DecadeData.MW) * 1920 - (AVG(DecadeData.AvgDownPayment) * 0.5 * AVG(DecadeData.MW) * 1920)), 0) AS AvgIncomeDifference
FROM
    DecadeData
GROUP BY
    Decade