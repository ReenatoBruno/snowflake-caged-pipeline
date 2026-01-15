-- Create file format for reading CAGED TXT files
USE ROLE SYSADMIN; 
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED; 
USE SCHEMA BRONZE;

-- Create file format for CAGED TXT files 
CREATE OR REPLACE FILE FORMAT FF_CAGED_TXT
    TYPE = 'CSV'
    FIELD_DELIMITER = ';'  
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE
    ENCODING = 'UTF8'
    ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE
    COMMENT = 'File format for CAGED semicolon-delimited TXT files from S3';

-- Verify file format creation
SHOW FILE FORMATS;
DESC FILE FORMAT FF_CAGED_TXT;