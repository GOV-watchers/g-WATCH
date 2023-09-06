-- How many hours of work is needed for an average family to fully purchase a house every year?

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