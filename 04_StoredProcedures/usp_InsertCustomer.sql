USE mssql_data_cleaning_lab_test;
GO

IF OBJECT_ID('dbo.usp_InsertCustomer', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_InsertCustomer;
GO

CREATE PROCEDURE dbo.usp_InsertCustomer
(
    @FullName NVARCHAR(200),
    @Email NVARCHAR(200),
    @Phone NVARCHAR(50) = NULL,
    @City NVARCHAR(100) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.Customers
        (
            FullName,
            Email,
            Phone,
            City
        )
        VALUES
        (
            @FullName,
            @Email,
            @Phone,
            @City
        );

        DECLARE @NewCustomerID INT = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT 
            @NewCustomerID AS CustomerID,
            'Customer inserted successfully.' AS Message;

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        IF ERROR_NUMBER() IN (2601, 2627)
        BEGIN
            RAISERROR('A customer with this email already exists.',16,1);
            RETURN;
        END

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage,16,1);

    END CATCH
END;
GO
