USE mssql_data_cleaning_lab_test;
GO

-- Önce eski kolonları drop edelim (varsa)
IF COL_LENGTH('dbo.Customers','NormalizedFullName') IS NOT NULL
    ALTER TABLE dbo.Customers DROP COLUMN NormalizedFullName;

IF COL_LENGTH('dbo.Customers','NormalizedEmail') IS NOT NULL
    ALTER TABLE dbo.Customers DROP COLUMN NormalizedEmail;

IF COL_LENGTH('dbo.Customers','NormalizedCity') IS NOT NULL
    ALTER TABLE dbo.Customers DROP COLUMN NormalizedCity;
GO

-- Computed + Persisted kolonları ekle
ALTER TABLE dbo.Customers
ADD
    NormalizedFullName AS dbo.fn_NormalizeText(FullName) PERSISTED,
    NormalizedEmail AS dbo.fn_NormalizeText(Email) PERSISTED,
    NormalizedCity AS dbo.fn_NormalizeText(City) PERSISTED;
GO
