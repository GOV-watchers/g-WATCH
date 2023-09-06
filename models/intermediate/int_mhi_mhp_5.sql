<<<<<<< HEAD
-- How many hours would the average family have to work to afford a 5% down payment on a home in the USA between 1980 to 2020?


=======
>>>>>>> fac15e2b43a7b1cc6eaf3d29f5050b71138d0f45
WITH MHI AS (
    SELECT * FROM {{ ref('stg_mhi') }}
),
MHP AS (
    SELECT * FROM {{ ref('stg_mhp') }}
<<<<<<< HEAD
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
=======
)

SELECT 
    MHI.MHI_ID AS ID,
    MHI.MHI_BY_YEAR AS YEAR, 
    MHI.MHI,
    (MHP.MHP*.05) AS FIVE_DOWNPAYMENT,
    MHP.MHP,
    SUBSTRING(ROUND((FIVE_DOWNPAYMENT/MHI.MHI)*1920, 0),1,3) AS HOUR_FOR_PAYMENT
FROM MHI
JOIN MHP ON MHP.MHP_BY_YEAR = MHI.MHI_BY_YEAR
WHERE MHP.MHP_BY_YEAR >= '1980' AND MHP.MHP_BY_YEAR <= '2020'
ORDER BY MHP.MHP_BY_YEAR
>>>>>>> fac15e2b43a7b1cc6eaf3d29f5050b71138d0f45
