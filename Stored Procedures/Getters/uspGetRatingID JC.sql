USE DOGPAWS_TEST;
GO



CREATE PROC uspGetRatingID
@Rtname varchar(50),
@Rtabrev varchar(50),
@RtNum varchar(50),
@RatingID int OUTPUT
AS
	
	SET @RatingID = (
		SELECT RatingID
		FROM tblRATING R
		WHERE R.RatingName = @Rtname
		AND R.RatingAbbrev = @Rtabrev
		and R.RatingNumeric = @RtNum
	)

GO



