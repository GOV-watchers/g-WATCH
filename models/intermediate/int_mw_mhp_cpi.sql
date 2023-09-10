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