-- AWS S3 Storage Integration creation for external stage access in the CAGED project

USE ROLE ACCOUNTADMIN;

-- Create integration to allow Snowflake to read files from S3
CREATE OR REPLACE STORAGE INTEGRATION s3_caged_integration
    TYPE = EXTERNAL_STAGE                      -- Integration used for stages outside Snowflake
    STORAGE_PROVIDER = S3                      -- Provider is AWS S3
    ENABLED = TRUE                             -- Enable integration
    STORAGE_AWS_ROLE_ARN = '<AWS_ROLE_ARN>'    -- IAM role allowing Snowflake to access the bucket                                         
    STORAGE_ALLOWED_LOCATIONS = ('<S3_BUCKET_PATH>'); -- Limit access to only this bucket/path
                                               
-- Validate integration configuration
DESCRIBE INTEGRATION s3_caged_integration;
