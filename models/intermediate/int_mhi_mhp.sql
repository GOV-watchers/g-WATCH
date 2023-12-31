WITH MHI AS(
    SELECT * FROM {{ ref('stg_mhi') }}
),
MHP AS(
    SELECT * FROM {{ ref('stg_mhp') }}
)

SELECT * FROM MHI
JOIN MHP ON MHP.MHP_BY_YEAR = MHI.MHI_BY_YEAR
WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR <= '2020'
ORDER BY MHP.MHP_BY_YEAR