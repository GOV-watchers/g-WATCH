{{
    config(
        materalized = 'table',
    )
}}

SELECT * FROM {{ ref('int_mw_mhi_cpi') }}