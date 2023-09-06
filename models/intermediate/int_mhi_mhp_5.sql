-- How many hours would the average family have to work to afford a 5% down payment on a home in the USA between 1980 to 2020?


WITH MHI AS (
    SELECT * FROM {{ ref('stg_mhi') }}
),
MHP AS (
    SELECT * FROM {{ ref('stg_mhp') }}
),
IntermediateModel AS (
    SELECT
        MHI.MHI_BY_YEAR,
        MHI.MHI,
        MHP.MHP,
        (MHP.MHP * 0.05) AS DownPayment,
        (MHP.MHP * 0.05) / 25 AS HoursToWorkForDownPayment
    FROM MHI
    JOIN MHP ON MHI.MHI_BY_YEAR = MHP.MHP_BY_YEAR
    WHERE MHI.MHI_BY_YEAR BETWEEN '1980' AND '2020'
)
SELECT * FROM IntermediateModel;
