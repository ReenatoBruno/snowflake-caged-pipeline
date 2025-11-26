-- Create an external stage to access raw CAGED files stored in S3

USE ROLE ACCOUNTADMIN;
USE DATABASE CAGED;
USE SCHEMA RAW;

CREATE OR REPLACE STAGE s3_stage_caged_raw
    URL = '<S3_BUCKET_PATH>'                
    STORAGE_INTEGRATION = s3_caged_integration
    FILE_FORMAT = FF_CAGED_TXT;
