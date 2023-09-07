--5. How have average working hours changed year to year, 
--and what are the implications of these changes on housing affordability for the average household, given recent trends
WITH CPI AS (
    SELECT * FROM {{ ref('stg_yearly_cpi') }}
),

CPI_2020 AS (
    SELECT
        MAX(CASE WHEN CPI_BY_YEAR = '2020' THEN CPI_AVG END) AS CPI_2020
    FROM CPI
)

SELECT 
    CPI_BY_YEAR, 
    CPI_AVG,
    ROUND(((SELECT CPI_2020 FROM CPI_2020) / CPI_AVG), 2) AS CPI_RATIO,
    (40) AS AVG_HOURS_WORKED,
    ROUND((40 * CPI_RATIO), 1) AS HOURS_WORKED_COMPARED_TO_2020
FROM CPI

