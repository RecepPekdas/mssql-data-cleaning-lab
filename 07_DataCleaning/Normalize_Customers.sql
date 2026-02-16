BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE dbo.Customers
    SET
        NormalizedFullName = dbo.fn_NormalizeText(FullName),
        NormalizedEmail = dbo.fn_NormalizeText(Email),
        NormalizedCity = dbo.fn_NormalizeText(City)
    WHERE
        NormalizedFullName IS NULL
        OR NormalizedEmail IS NULL
        OR NormalizedCity IS NULL;

    COMMIT TRANSACTION;
    PRINT 'Normalization completed using function.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
END CATCH;
GO
