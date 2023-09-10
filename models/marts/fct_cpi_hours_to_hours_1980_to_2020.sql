{{
    config(
        materalized = 'table',
    )
}}

SELECT * FROM {{ ref('int_cpi') }}