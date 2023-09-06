--Comparing different minimum wages in different years, can you determine whether it would have been possible to afford a home in 1990 or 2000 
--based on the hours needed to reach that affordability level?
--modify for downpayment and using 50% of income


WITH MW AS (
    SELECT * FROM {{ ref('stg_mw') }}
),
MHP AS (
    SELECT * FROM {{ ref('stg_mhp') }}
)

SELECT
    MW.ID_MW AS ID,
    MW.MW_BY_YEAR AS YEAR,
    MW.FEDERAL_MINIMUM_WAGE,
    MHP.MHP,
    SUBSTRING(ROUND((MHP.MHP/MW.FEDERAL_MINIMUM_WAGE),0),1,5) AS HOURS_TO_PURCHASE
FROM MW
JOIN MHP ON MHP.MHP_BY_YEAR = MW.MW_BY_YEAR
WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR <= '2020'
ORDER BY MHP.MHP_BY_YEAR 