-- 7. Based on the Median Household Income, do people today need to work longer hours to afford a house compared to the 1980/90/2000s, and does this affect their ability to own a home within their working lifetime(43 years is working lifetime)? Based on 36% of their income

{{
    config(
        materalized = 'table',
    )
}}

WITH MHI_MHP AS(
    SELECT * FROM {{ ref('int_mhi_mhp') }}
)

SELECT
    MHI_ID AS ID,
    MHI_BY_YEAR,
    MHI,
    MHP,
    ((MHI*.36)) AS INCOME_THRIRTYSIX,
    FLOOR((MHP/INCOME_THRIRTYSIX)) AS YEARS,
    (YEARS+22) as HOUSE_BOUGHT_AT_AGE
FROM MHI_MHP