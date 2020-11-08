USE DOGPAWS_TEST;
GO

--EXEC sp_help tblCOURSE
-- Couse name includes course prefix and level, it is unique.

CREATE PROC uspGetCourseID_RT
@CName VARCHAR(100),
@CourseID INT OUTPUT
AS
	SET @CourseID = (SELECT CourseID FROM tblCOURSE WHERE CourseName = @CName)
GO