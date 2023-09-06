WITH MHI AS(
    SELECT * FROM {{ ref('stg_mhi') }}
),
MHP AS(
    SELECT * FROM {{ ref('stg_mhp') }}
)
SELECT
    MHI.MHI_ID AS ID,
    MHI.MHI_BY_YEAR,
    MHI.MHI,
    MHP.MHP,
    ((MHI*.36)) AS INCOME_THRIRTYSIX,
    FLOOR((MHP/INCOME_THRIRTYSIX)) AS YEARS,
    (YEARS+22) as HOUSE_BOUGHT_AT_AGE
FROM MHI
JOIN MHP ON MHP.MHP_BY_YEAR = MHI.MHI_BY_YEAR
WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR <= '2020'
ORDER BY MHP.MHP_BY_YEAR