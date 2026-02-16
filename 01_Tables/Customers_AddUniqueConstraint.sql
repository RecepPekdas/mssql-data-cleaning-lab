USE mssql_data_cleaning_lab_test;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'UX_Customers_NormalizedEmail'
)
BEGIN
    CREATE UNIQUE INDEX UX_Customers_NormalizedEmail
    ON dbo.Customers (NormalizedEmail)
    WHERE NormalizedEmail IS NOT NULL;

    PRINT 'Unique filtered index created successfully.';
END
ELSE
BEGIN
    PRINT 'Unique index already exists.';
END
GO
