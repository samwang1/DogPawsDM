USE DOGPAWS_TEST
GO

CREATE PROC uspGetLocationID
@L_Name varchar(100),
@L_ID INT OUTPUT
AS
SET @L_ID = (
	SELECT LocationID
	FROM tblLOCATION
	WHERE LocationName = @L_Name
)
GO
