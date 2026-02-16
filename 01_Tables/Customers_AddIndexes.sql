USE mssql_data_cleaning_lab_test;
GO

CREATE INDEX IX_Customers_NormalizedEmail
ON dbo.Customers (NormalizedEmail);

CREATE INDEX IX_Customers_NormalizedFullName_City
ON dbo.Customers (NormalizedFullName, NormalizedCity);
GO
