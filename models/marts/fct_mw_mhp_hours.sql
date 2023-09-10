-- 10. Comparing different minimum wages in different years, can you determine whether it would have been possible to afford a home in 1990 or 2000 based on the hours needed to reach that affordability level?

{{
    config(
        materalized = 'table',
    )
}}

WITH MW_MHP AS(
    SELECT * FROM {{ ref('int_mw_mhp') }}
)

SELECT
    ID_MW AS ID,
    MW_BY_YEAR AS YEAR,
    FEDERAL_MINIMUM_WAGE,
    MHP,
    SUBSTRING(ROUND((MHP/FEDERAL_MINIMUM_WAGE),0),1,5) AS HOURS_TO_PURCHASE
FROM MW_MHP