USE mssql_data_cleaning_lab_test;
GO

SELECT
    CustomerID,
    FullName,
    LOWER(LTRIM(RTRIM(FullName))) AS Normalized_FullName_Preview,
    Email,
    LOWER(LTRIM(RTRIM(Email))) AS Normalized_Email_Preview,
    City,
    LOWER(LTRIM(RTRIM(City))) AS Normalized_City_Preview
FROM dbo.Customers;
GO

BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE dbo.Customers
    SET
        NormalizedFullName =
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            LOWER(LTRIM(RTRIM(FullName))),
            'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u'),

        NormalizedEmail =
            LOWER(LTRIM(RTRIM(Email))),

        NormalizedCity =
            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            LOWER(LTRIM(RTRIM(City))),
            'ç','c'),'ğ','g'),'ı','i'),'ö','o'),'ş','s'),'ü','u')

    WHERE
        NormalizedFullName IS NULL
        OR NormalizedEmail IS NULL
        OR NormalizedCity IS NULL;

    COMMIT TRANSACTION;
    PRINT 'Normalization completed successfully.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    PRINT 'Error during normalization:';
    PRINT ERROR_MESSAGE();
END CATCH;
GO

SELECT
    FullName,
    NormalizedFullName,
    City,
    NormalizedCity
FROM dbo.Customers;
