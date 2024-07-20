{{
 config(materialized = 'table')
}}

WITH src_listings AS (
SELECT * FROM {{source('airbnb','teste_modelo')}}
)
SELECT
*
FROM src_listings