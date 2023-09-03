with MHI AS (

SELECT
    _ROW AS MHI_ID,
    SUBSTRING(MEDIAN_HOUSEHOLD_INCOME_IN_THE_US, 1, 5) AS MHI,
    SUBSTRING(YEAR, 1, 4) AS MHI_BY_YEAR
FROM PC_FIVETRAN_DB.MEDIAN_HOUSEHOLD_INCOME_BY_YEAR.MEDIAN_HOUSEHOLD_INCOME
ORDER BY MHI_BY_YEAR
)

SELECT * FROM MHI