USE ROLE SYSADMIN;
USE DATABASE DB_CAGED; 
USE SCHEMA BRONZE; 

-- AWS S3 Storage Integration creation for external stage access in the CAGED project
CREATE STORAGE INTEGRATION s3_caged_integration 
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'S3'
    ENABLED = TRUE 
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::398045402034:role/snowflake_s3_caged_role'
    STORAGE_ALLOWED_LOCATIONS = ('s3://amzn-caged-bucket-renato/caged/*')
    COMMENT = 'Storage integration for CAGED data ingestion from S3 bucket';

-- Verify integration creation
SHOW INTEGRATIONS LIKE 's3_caged_integration';

-- Get Snowflake IAM user ARN and External ID
DESCRIBE INTEGRATION s3_caged_integration; 

GRANT USAGE ON INTEGRATION s3_caged_integration TO ROLE SYSADMIN;

USE ROLE SYSADMIN;

