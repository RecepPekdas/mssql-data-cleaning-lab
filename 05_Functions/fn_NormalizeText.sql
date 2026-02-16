USE mssql_data_cleaning_lab_test;
GO

IF OBJECT_ID('dbo.fn_NormalizeText', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_NormalizeText;
GO

CREATE FUNCTION dbo.fn_NormalizeText
(
    @input NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @result NVARCHAR(MAX);

    -- NULL kontrolü
    IF @input IS NULL
        RETURN NULL;

    -- Trim + Lower
    SET @result = LOWER(LTRIM(RTRIM(@input)));

    -- Türkçe karakter dönüşümü
    SET @result = REPLACE(@result, 'ç', 'c');
    SET @result = REPLACE(@result, 'ğ', 'g');
    SET @result = REPLACE(@result, 'ı', 'i');
    SET @result = REPLACE(@result, 'ö', 'o');
    SET @result = REPLACE(@result, 'ş', 's');
    SET @result = REPLACE(@result, 'ü', 'u');

    RETURN @result;
END;
GO
