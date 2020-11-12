USE DOGPAWS_TEST;
GO



CREATE PROC uspGetRatingID
@RtNum varchar(50),
@RatingID int OUTPUT
AS
	
	SET @RatingID = (
		SELECT RatingID
		FROM tblRATING R
		WHERE R.RatingNumeric = @RtNum
	)

GO



