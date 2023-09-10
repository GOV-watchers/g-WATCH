-- 2&4. Based on the Median Household Income, how many hours would it take to fully pay the house without a loan (36% of the budget over the years is being used)?
{{
    config(
        materialized = 'table',
    )
}}
WITH MHI_MHP AS(
    SELECT * FROM {{ ref('int_mhi_mhp') }}
)

SELECT 
    MHP_ID AS ID,
    MHP_BY_YEAR AS YEAR,
    MHP,
    CAST(MHI AS VARCHAR(10)) || '.00' AS MHI,
    CAST(ROUND((MHI*.36), 3) AS DECIMAL(10,2)) AS THIRTY_SIX_PERCENT,
    SUBSTRING((ROUND((MHP/THIRTY_SIX_PERCENT), 2)*1920),1 ,5)  AS HOURS_TO_PURCHASE,
    SUBSTRING(ROUND((MHP/THIRTY_SIX_PERCENT*1920/8), 0),1,4) AS WORKING_DAYS_TO_PURCHASE,
    SUBSTRING(ROUND(MHP/THIRTY_SIX_PERCENT*1920/40), 1,5) AS WEEKLY_TO_PURCHASE,
    SUBSTRING(ROUND(MHP/THIRTY_SIX_PERCENT*1920/160), 1,3) AS MONTHLY_TO_PURCHASE,
    SUBSTRING(ROUND(MHP/THIRTY_SIX_PERCENT*1920/1920), 1, 2) AS YEARLY_T0_PURCHASE
FROM MHI_MHP