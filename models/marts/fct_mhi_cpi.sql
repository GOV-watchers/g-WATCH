{{
    config(
        materalized = 'table',
    )
}}

SELECT * FROM {{ ref('int_mhi_cpi') }}