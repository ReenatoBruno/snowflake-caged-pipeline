
--- Warehouse creation and configuration for the CAGED project ---

USE ROLE ACCOUNTADMIN;

--Create the warehouse used for ELT/ETL processing
CREATE WAREHOUSE WH_CAGED_ETL_S
WITH
    WAREHOUSE_SIZE = 'XSMALL'           -- Small size to reduce cost
    AUTO_SUSPEND = 300                  -- Suspends after 5 minutes inactivity
    AUTO_RESUME = TRUE                  -- Automatically resumes when queried
    MAX_CLUSTER_COUNT = 1;              -- Single cluster for now

-- Select and validate warehouse configuration
USE WAREHOUSE WH_CAGED_ETL_S;
SHOW WAREHOUSES;

-- Suspend warehouse to avoid unnecessary credit consumption
ALTER WAREHOUSE WH_CAGED_ETL_S SUSPEND;
