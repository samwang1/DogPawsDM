USE DOGPAWS_TEST;
GO

--EXEC sp_help tblInterest
--EXEC sp_help tblInterest_Type

CREATE PROC uspGetInterestTypeID_WL
@ITypeName varchar(100),
@InterestTypeID int OUTPUT
AS
	
	SET @InterestTypeID = (SELECT InterestTypeID FROM tblINTEREST_TYPE WHERE InterestTypeName = @ITypeName)

GO