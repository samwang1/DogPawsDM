USE DOGPAWS_TEST;
GO


CREATE PROC uspGetQuestionTypeID
@QTName VARCHAR(100),
@QuestionTypeID INT OUTPUT
AS
	SET @QuestionTypeID = (SELECT @QuestionTypeID FROM tblQUESTION WHERE QuestionTypeName = @QTName)
GO
