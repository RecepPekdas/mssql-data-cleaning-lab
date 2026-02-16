-- 01_Tables\SeedData_Customers.sql
USE mssql_data_cleaning_lab_test;
GO

SET NOCOUNT ON;

INSERT INTO dbo.Customers (FullName, Email, Phone, City)
VALUES
('Ahmet YILMAZ','ahmet.yilmaz@example.com','+90 532 111 11 11','İstanbul'),
('Ahmet Yılmaz','ahmet.yilmaz@example.com','0532 1111111','Istanbul'),
('ahmet yılmaz','AHMET.YILMAZ@example.com','+905321111111','istanbul'),
('Ayşe ÖZTÜRK','ayse.ozturk@example.com','0212-222-22-22','Ankara'),
('Ayse Ozturk','ayse.ozturk@example.com',NULL,'ankara'),
('Test User','test@example.com','+90 533 333 33 33','Izmir'),
('Test  User','test@example.com','0533 3333333','İzmir'),
('Unique Person','unique@example.com','+90 544 444 44 44','Bursa');
GO
