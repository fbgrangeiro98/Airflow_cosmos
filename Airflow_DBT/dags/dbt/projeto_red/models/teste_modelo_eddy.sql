{{
 config(materialized = 'table')
}}

WITH src_listings AS (
SELECT * FROM {{source('cidades','meu_teste')}}
)
SELECT
*
FROM src_listings