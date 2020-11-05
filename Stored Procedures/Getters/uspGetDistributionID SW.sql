USE DOGPAWS_TEST
GO

CREATE PROC uspGetDistributionID
@D_Name varchar(100),
@D_ID INT OUTPUT
AS
	SET @D_ID = (SELECT DistributionID FROM tbLDISTRIBUTION WHERE DistributionName = @D_Name)
