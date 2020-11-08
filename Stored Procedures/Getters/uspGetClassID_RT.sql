USE DOGPAWS_TEST;
GO

--EXEC sp_help tblQUARTER
--EXEC sp_help tblCOURSE
--EXEC sp_help tblCLASS

CREATE PROC uspGetClassID_RT
@CourseName varchar(100),
@QuarterName VARCHAR(100),
@Year INT(4), -- Review
@Section VARCHAR(2), -- Review
@ClassID INT OUTPUT
AS
    DECLARE @Q_ID INT, @C_ID INT

	EXEC uspGetQuarterID
    @QName = @QuarterName
    @QuarterID = @Q_ID OUTPUT

    EXEC uspGetCourseID
    @CName = @CourseName
    @CourseID = @C_ID OUTPUT

	SET @ClassID = (
		SELECT ClassID 
		FROM tblCLASS C
		JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
        JOIN tblCOURSE CR ON C.CourseID = CR.CourseID
		WHERE C.QuarterID = @Q_ID
		    AND C.CourseID = @C_ID
            AND C.Year = @Year
            AND C.Section = @Section
	)
GO