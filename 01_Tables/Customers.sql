-- 01_Tables\Customers.sql
USE mssql_data_cleaning_lab_test;
GO

IF OBJECT_ID('dbo.Customers','U') IS NOT NULL
    DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers (
    CustomerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    Email NVARCHAR(200) NULL,
    Phone NVARCHAR(50) NULL,
    City NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT (SYSUTCDATETIME()),
    NormalizedFullName NVARCHAR(200) NULL,
    NormalizedEmail NVARCHAR(200) NULL,
    NormalizedCity NVARCHAR(100) NULL
);
GO
