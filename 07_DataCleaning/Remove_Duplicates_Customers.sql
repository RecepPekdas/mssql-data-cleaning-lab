USE mssql_data_cleaning_lab_test;
GO

SET NOCOUNT ON;

-- Step 1: Duplicate kayıtları tespit et
WITH DuplicateCTE AS
(
    SELECT
        CustomerID,
        FullName,
        Email,
        City,
        ROW_NUMBER() OVER (
            PARTITION BY FullName, Email, City
            ORDER BY CreatedAt ASC
        ) AS RowNum
    FROM dbo.Customers
)
SELECT *
FROM DuplicateCTE
WHERE RowNum > 1;
GO


BEGIN TRY
    BEGIN TRANSACTION;

    WITH DuplicateCTE AS
    (
        SELECT
            CustomerID,
            ROW_NUMBER() OVER (
                PARTITION BY FullName, Email, City
                ORDER BY CreatedAt ASC
            ) AS RowNum
        FROM dbo.Customers
    )
    DELETE FROM DuplicateCTE
    WHERE RowNum > 1;

    COMMIT TRANSACTION;
    PRINT 'Duplicate records deleted successfully.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    PRINT 'Error occurred:';
    PRINT ERROR_MESSAGE();
END CATCH;
GO
