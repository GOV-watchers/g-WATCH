-- 7. Based on the Median Household Income, do people today need to work longer hours to afford a house compared to the 1980/90/2000s, and does this affect their ability to own a home within their working lifetime(43 years is working lifetime)? Based on 36% of their income

WITH MHI AS(
    SELECT * FROM {{ ref('stg_mhi') }}
),
MHP AS(
    SELECT * FROM {{ ref('stg_mhp') }}
)
SELECT
    MHI_ID AS ID,
    MHI_BY_YEAR,
    MHI,
    MHP.MHP,
    ((MHI*.36)) AS INCOME_THRIRTYSIX,
    FLOOR((MHP/INCOME_THRIRTYSIX)) AS YEARS,
    (YEARS+22) as HOUSE_BOUGHT_AT_AGE
FROM MHI
JOIN MHP ON MHP.MHP_BY_YEAR = MHI.MHI_BY_YEAR
WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR <= '2020'
ORDER BY MHP.MHP_BY_YEAR