--  Create a raw table to store all incoming CAGED data in its original, semi-structured format.
USE ROLE ACCOUNTADMIN;
USE DATABASE CAGED;
USE SCHEMA RAW;

CREATE OR REPLACE TABLE TB_CAGED_RAW (
    DATA_RAW VARIANT
);