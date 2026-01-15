USE ROLE SYSADMIN;
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED;
USE SCHEMA SILVER;

-- 1. Overall statistics
SELECT 
    COUNT(*) AS total_rows_silver,
    COUNT(CASE WHEN _is_valid = TRUE THEN 1 END) AS valid_rows,
    COUNT(CASE WHEN _is_valid = FALSE THEN 1 END) AS invalid_rows,
    ROUND(COUNT(CASE WHEN _is_valid = TRUE THEN 1 END) * 100.0 / COUNT(*), 2) AS valid_percentage
FROM TBL_CAGED_MOVEMENTS;

-- 2. View sample transformed data
SELECT 
    _silver_row_id,
    _bronze_row_id,
    _source_file,
    _is_valid,
    _validation_errors,
    competencia_mov,
    regiao,
    uf,
    municipio,
    idade,
    salario,
    ind_trab_intermitente,
    ind_trab_parcial
FROM TBL_CAGED_MOVEMENTS
LIMIT 10;

-- 3. Check invalid records (if any)
SELECT 
    _bronze_row_id,
    _source_file,
    _validation_errors,
    competencia_mov,
    uf,
    regiao
FROM TBL_CAGED_MOVEMENTS
WHERE _is_valid = FALSE
LIMIT 20;

-- 4. Compare counts Bronze vs Silver (should match)
SELECT 
    'BRONZE' AS layer,
    COUNT(*) AS row_count
FROM BRONZE.TBL_CAGED_MOVEMENTS

UNION ALL

SELECT 
    'SILVER' AS layer,
    COUNT(*) AS row_count
FROM SILVER.TBL_CAGED_MOVEMENTS;

-- 5. Data type validation - check for conversion issues
SELECT 
    'idade' AS field,
    COUNT(*) AS total_rows,
    COUNT(idade) AS non_null_rows,
    COUNT(*) - COUNT(idade) AS null_rows
FROM TBL_CAGED_MOVEMENTS

UNION ALL

SELECT 
    'salario' AS field,
    COUNT(*) AS total_rows,
    COUNT(salario) AS non_null_rows,
    COUNT(*) - COUNT(salario) AS null_rows
FROM TBL_CAGED_MOVEMENTS

UNION ALL

SELECT 
    'horas_contratuais' AS field,
    COUNT(*) AS total_rows,
    COUNT(horas_contratuais) AS non_null_rows,
    COUNT(*) - COUNT(horas_contratuais) AS null_rows
FROM TBL_CAGED_MOVEMENTS;

-- 6. Boolean conversion verification
SELECT 
    ind_trab_intermitente,
    COUNT(*) AS count
FROM TBL_CAGED_MOVEMENTS
GROUP BY ind_trab_intermitente
ORDER BY ind_trab_intermitente;

-- 7. UF distribution (check data quality)
SELECT 
    uf,
    COUNT(*) AS count
FROM TBL_CAGED_MOVEMENTS
WHERE _is_valid = TRUE
GROUP BY uf
ORDER BY count DESC
LIMIT 10;

-- 8. Check for duplicate bronze_row_ids (should be none)
SELECT 
    _bronze_row_id,
    COUNT(*) AS duplicate_count
FROM TBL_CAGED_MOVEMENTS
GROUP BY _bronze_row_id
HAVING COUNT(*) > 1
LIMIT 10;

-- 9. Metadata audit trail
SELECT 
    _source_file,
    MIN(_bronze_load_timestamp) AS first_load,
    MAX(_bronze_load_timestamp) AS last_load,
    COUNT(*) AS records_from_file
FROM TBL_CAGED_MOVEMENTS
GROUP BY _source_file
ORDER BY _source_file;
```

---

## **📂 Estrutura completa do projeto agora:**
```
snowflake-caged-project/
├── 01_create_warehouse.sql
├── 02_create_database_schemas.sql
├── 03_create_storage_integration.sql
├── 04_create_stage.sql
├── 05_create_file_format.sql
├── 06_create_bronze_tables.sql
├── 07_load_bronze_data.sql
├── 08_create_silver_tables.sql
├── 09_transform_silver_data.sql    ← Transformação
├── 10_validate_silver_data.sql     ← Validações
└── README.md