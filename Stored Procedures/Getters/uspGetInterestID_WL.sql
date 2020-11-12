USE DOGPAWS_TEST;
GO

--EXEC sp_help tblInterest
--EXEC sp_help tblInterest_Type

CREATE PROC uspGetInterestID_WL
@IName varchar(100),
@ITypeName varchar(100),
@InterestID int OUTPUT
AS
	
	SET @InterestID = (
		SELECT InterestID 
		FROM tblINTEREST I
		JOIN tblINTEREST_TYPE IT ON I.InterestTypeID = IT.InterestTypeID
		WHERE I.InterestName = @IName
		AND IT.InterestTypeName = @ITypeName
	)

GO


DECLARE @I_ID int

EXEC uspGetInterestID_WL
@IName = 'Gaming',
@ITypeName = 'Recreational',
@InterestID = @I_ID OUTPUT

PRINT @I_ID
GO

SELECT * FROM tblINTEREST I
	JOIN tblINTEREST_TYPE IT ON I.InterestTypeID = it.InterestTypeID

DECLARE @IT_ID int

EXEC uspGetInterestTypeID_WL
@ITypeName = 'Competitive',
@InterestTypeID = @IT_ID OUTPUT

PRINT @IT_ID
GO