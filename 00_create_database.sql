-- 00_create_database.sql 
IF DB_ID('mssql_data_cleaning_lab_test') IS NULL
BEGIN
    CREATE DATABASE mssql_data_cleaning_lab_test;
END
GO

USE mssql_data_cleaning_lab_test;
GO
