
-- Database and schema creation for the CAGED project

USE ROLE ACCOUNTADMIN;

-- Create the main project database
CREATE OR REPLACE DATABASE CAGED;

-- Create the RAW schema that will store the landing/raw zone
CREATE OR REPLACE SCHEMA CAGED.RAW;

-- Set active context for subsequent commands
USE DATABASE CAGED;
USE SCHEMA RAW;
