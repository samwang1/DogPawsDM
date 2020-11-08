USE DOGPAWS_TEST
GO

CREATE PROC uspGetDetailID
@D_Name varchar(50),
@DetailTypeName varchar(50),
@D_ID INT OUTPUT
AS
BEGIN
	DECLARE @DetailType_ID INT

	EXEC uspGetDetailTypeID
		@DT_Name = @DetailTypeName
		@DT_ID = @DetailType_ID OUTPUT

	SET @D_ID = (SELECT DetailID FROM tblDETAIL WHERE DetailName = @D_Name AND DetailTypeID = @DetailType_ID)
END