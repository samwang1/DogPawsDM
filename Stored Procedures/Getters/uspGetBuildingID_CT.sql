USE DOGPAWS_TEST
GO

CREATE PROC uspGetBuildingID
@B_Name varchar(100),
@L_Name varchar(100),
@B_ID INT OUTPUT
AS
DECLARE @L_ID INT

EXEC uspGetLocationID
@L_Name = @L_Name,
@L_ID = @L_ID OUTPUT

SET @B_ID = (
	SELECT BuildingID
	FROM tblBUILDING
	WHERE BuildingName = @B_Name
		AND LocationID = @L_ID
)
GO