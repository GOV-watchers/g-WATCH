{{
    config(
        materalized = 'table',
    )
}}

SELECT * FROM {{ ref('int_cpi_hours_to_hours_1980_to_2020') }}