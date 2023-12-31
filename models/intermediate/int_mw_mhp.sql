WITH MW AS (
    SELECT * FROM {{ ref('stg_mw') }}
),
MHP AS(
    SELECT * FROM {{ ref('stg_mhp') }}
)

SELECT * 
FROM MW
JOIN MHP ON MHP.MHP_BY_YEAR = MW.MW_BY_YEAR
WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR<= '2020'
ORDER BY MHP.MHP_BY_YEAR