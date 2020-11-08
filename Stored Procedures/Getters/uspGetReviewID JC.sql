CREATE PROC uspGetReviewID
@RevName varchar(100),
@RevContent varchar(100),
@RtName varchar(50),
@ACTName varchar(50),
@RevDate datetime,
@ReviewID int OUTPUT
AS
	
	SET @ReviewID = (
		SELECT ReviewID 
		FROM tblREVIEW RV
		JOIN tblRating RT ON RT.RatingID = RV.RatingID
		join tblACTIVITY A on A.ActivityID = RV.ActivityID
		WHERE A.ActivityName = @ACTName
		AND RT.RatingName = @RtName
		and ReviewContent = @RevContent
		and ReviewDate = @RevDate
	)

GO