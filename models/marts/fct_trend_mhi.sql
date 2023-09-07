{{
    config(
        materialized = 'table',
    )
}}

SELECT * FROM {{ ref('int_mhi_yearly_cpi') }}