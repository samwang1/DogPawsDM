USE DOGPAWS_Surveys_Temp

SELECT * FROM WK_1

--

GO
CREATE PROC uspInsertFromCSV
@SurveyName varchar(50),
@LastPull DateTime -- time of most recent .csv download
AS
BEGIN
	DECLARE @RowNum INT = 1
	DECLARE @TotalRows INT = 0

	SELECT @TotalRows = COUNT(0) FROM WK_1
	WHILE @RowNum <= @TotalRows
	BEGIN
		-- select current row
		DECLARE @F varchar(20), @L varchar(20), @Email varchar(50), @temp varchar(500)
		SET @temp = (SELECT Question_33 FROM WK_1 WHERE ResponseID = @RowNum)-- split by space. sample output: 'Harry Husky'
		--SET @temp = REPLACE(@temp, ' ', '.') -- Harry.Husky
		IF (SELECT PARSENAME(@temp, 2)) IS NULL
			BEGIN
				SET @F = NULL -- or anonymous
			END
		ELSE
			BEGIN
				SET @F = (SELECT PARSENAME(@temp, 2))
			END
		IF (SELECT PARSENAME(@temp, 1)) IS NULL
			BEGIN
				SET @L = NULL -- or anonymous
			END
		ELSE
			BEGIN
				SET @L = (SELECT PARSENAME(@temp, 1))
			END
		SET @Email = (SELECT Question_2 /*from current row*/)


		-- add person info to tblPERSON if new entry
		IF NOT EXISTS (
			SELECT PersonID FROM tblPERSON
				WHERE email = @Email
		)
		BEGIN
			INSERT INTO tblPERSON(Fname, Lname, Email)
			VALUES(@F, @L, @Email)
		END

		/* 
		
	
		other inserts 


		*/

		SET @RowNum = @RowNum + 1

	END
END



-- sample exec
EXEC uspInsertFromCSV @LastPull = '2020-05-22 12:00:00'