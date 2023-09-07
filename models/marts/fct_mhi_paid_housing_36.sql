{{
    config(
        materialized = 'table',
    )
}}

SELECT * FROM {{ ref('int_mhi_mhp_36') }}