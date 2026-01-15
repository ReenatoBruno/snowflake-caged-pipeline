USE ROLE SYSADMIN;
USE WAREHOUSE WH_CAGED_XS;
USE DATABASE DB_CAGED; 
USE SCHEMA BRONZE;

CREATE OR REPLACE STAGE s3_caged_stage
    URL = 's3://amzn-caged-bucket-renato/caged/'
    STORAGE_INTEGRATION = s3_caged_integration
    DIRECTORY = (ENABLE = TRUE)  -- Enables automatic directory metadata refresh
    COMMENT = 'External stage pointing to S3 bucket for CAGED raw data ingestion';

SHOW STAGES;

LIST @s3_caged_stage;

DESCRIBE STAGE s3_caged_stage;
