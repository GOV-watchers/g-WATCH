{{
    config(
        materalized = 'table',
    )
}}

SELECT * FROM {{ ref('int_mw_mhp_hours') }}