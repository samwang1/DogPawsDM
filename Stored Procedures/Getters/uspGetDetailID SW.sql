USE DOGPAWS_TEST
GO

CREATE PROC uspGetDetailID
@D_Name varchar(50),
@DT_Name varchar(50),
@D_ID INT OUTPUT
AS
BEGIN
	DECLARE @DT_ID INT = (SELECT DetailTypeID FROM tblDETAIL_TYPE WHERE DetailTypeName = @DT_Name)
	SET @D_ID = (SELECT DetailID FROM tblDETAIL WHERE DetailName = @D_Name AND DetailTypeID = @DT_ID)
END