USE DOGPAWS_TEST;
GO


CREATE PROC uspGetQuestionTypeID
@QTName VARCHAR(50),
@QuestionTypeID INT OUTPUT
AS
	SET @QuestionTypeID = (SELECT @QuestionTypeID FROM tblQUESTION WHERE QuestionTypeName = @QTName)
GO
