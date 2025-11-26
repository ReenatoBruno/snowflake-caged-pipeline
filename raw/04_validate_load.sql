-- Validate the raw data load into TB_CAGED_RAW

USE DATABASE CAGED;
USE SCHEMA RAW;

-- Total number of loaded rows
SELECT COUNT(*) AS total_rows FROM TB_CAGED_RAW;

-- Preview first 10 rows and split first column as example
SELECT 
    DATA_RAW,
    SPLIT_PART(DATA_RAW::VARCHAR, ';', 1) AS column_1_example
FROM TB_CAGED_RAW
LIMIT 10;