USE DOGPAWS_Surveys_Temp

SELECT * FROM WK_1

INSERT INTO tblSURVEY(SurveyName, SurveyBeginDate)
VALUES('DogPaws Interest Survey', 'May 22, 2020')

/* inserts into tblQUESTION */


--Insert Questions 22-23, 25-27 into tblQUESTION
INSERT INTO tblQUESTION (QuestionTypeID, QuestionName)	--Insert into tblQUESTION
	VALUES
		(4, 'Timestamp'), -- q1
		(4, 'Email'), -- q2
		(1, 'What is your class standing for the 2020-2021 school year?'), -- q3
		(1, 'I am an... (resident status)'), -- q4
		(1, 'I am... (housing status)'), -- q5
		(1, 'Which statements below best describe you? (Select all that apply)'), -- q6
		(1, 'What experiences or goals did you have for yourself when you came to UW?'), -- q7
		(4, 'I am... (major status)'),	--Question 22
		(4, 'My major is...'),	--Question 23
		(3, 'Rate your level of agreement with the following statements: [I have a hard time finding my passion and my desired major.]'), --Question 25
		(3, 'Rate your level of agreement with the following statements: [I have a hard time getting an internship.]'), --Question 26
		(3, 'Rate your level of agreement with the following statements: [I have a hard time connecting with people within the industry.]'),	--Question 27

		(4, 'Additionally, please leave your preferred first and last name here if you answered yes to either of the first two questions asked on this page (format: Harry Husky):'); -- q33

DECLARE @Question_1 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Timestamp')
DECLARE @Question_2 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
DECLARE @Question_22 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'I Am...');
DECLARE @Question_23 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My major is...');
DECLARE @Question_25 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time finding my passion and my desired major.]');
DECLARE @Question_26 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time getting an internship.]');
DECLARE @Question_27 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time connecting with people within the industry.]');
DECLARE @Question_33 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName LIKE '%Harry Husky%')

/* inserts into tblSURVEY_QUESTION*/

--Insert question 22-23, 25-2 into tblSURVEY_QUESTION
INSERT INTO tblSURVEY_QUESTION (SurveyID, QuestionID)
	Values(1, @Question_22),
		  (1, @Question_23),
		  (1, @Question_25),
		  (1, @Question_26),
		  (1, @Question_27);



/* ***************************************************************** */



GO
CREATE PROC uspInsertFromCSV
@SurveyName varchar(100),
@LastPull DateTime -- time of most recent .csv download
AS
BEGIN
	DECLARE @RowNum INT = 1
	DECLARE @TotalRows INT = (SELECT COUNT(*) FROM WK_1)
	DECLARE @F varchar(50), @L varchar(50), @Email varchar(100), @Temp varchar(100)

	DECLARE @ResponseDateTime DateTime = (Select Question_1 From WK_1 Where ResponseID = @RowNum),
		@PersonPK INT

	DECLARE @SurveyID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Interest Survey')

	WHILE @RowNum <= @TotalRows
	BEGIN

		SET @Temp = (SELECT Question_33 FROM WK_1 WHERE ResponseID = @RowNum)

		IF @Temp IS NULL OR @Temp = 'N/A'
			BEGIN
				SET @F = NULL -- anonymous
				SET @L = NULL -- anonymous
			END
		ELSE
			BEGIN
				SET @F = SUBSTRING(@Temp, 1, CHARINDEX(' ', @Temp) - 1)
				SET @L = SUBSTRING(@Temp, CHARINDEX(' ', @Temp) + 1, LEN(@Temp))
			END
		SET @Email = (SELECT Question_2 FROM WK_1 WHERE ResponseID = @RowNum)

		IF NOT EXISTS (SELECT PersonID FROM tblPERSON WHERE Email = @Email)
			BEGIN
				INSERT INTO tblPERSON(Fname, Lname, Email)
				VALUES(@F, @L, @Email)
			END

		SET @PersonPK = SCOPE_IDENTITY()

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Email)

		/* 
		
	
		other inserts 


		*/

		/* Q 3-5 */

		DECLARE @Yr varchar(50), @StudType varchar(50), @Housing varchar(50), 
			@DT_ID1 INT, @DT_ID2 INT, @DT_ID3 INT, @D_ID INT, @Q_ID INT, @R_ID INT, @S_ID INT, @SQ_ID INT

		SET @Yr = (SELECT Question_3 FROM WK_1)
		SET @StudType = (SELECT Question_4 FROM WK_1)
		SET @Housing = (SELECT Question_5 FROM WK_1)

		-- ****** getting detail_typeID -> will have to populate detail_type table / figure out how detail types are categorized
		SET @DT_ID1 = (
			SELECT DetailTypeID
			FROM tblDETAIL_TYPE
			WHERE DetailTypeName = 'student year'
		)

		SET @DT_ID2 = (
			SELECT DetailTypeID
			FROM tblDETAIL_TYPE
			WHERE DetailTypeName = 'resident status'
		)

		SET @DT_ID3 = (
			SELECT DetailTypeID
			FROM tblDETAIL_TYPE
			WHERE DetailTypeName = 'housing status'
		)

		-- insert response for q3 into detail table
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@Yr, @DT_ID1)

		SET @D_ID = (SELECT SCOPE_IDENTITY())

		-- insert into person_detail
		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		-- repeat for q4
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@StudType, @DT_ID2)

		SET @D_ID = (SELECT SCOPE_IDENTITY())

		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		-- repeat for q5
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@Housing, @DT_ID3)

		SET @D_ID = (SELECT SCOPE_IDENTITY())

		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		/* Q6 */

		DECLARE @Q6 varchar(max) = (SELECT Question_6 FROM WK_1 WHERE ResponseID = @RowNum)


		IF @Q6 = 'None of the above'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'None of the above')
			END
		ELSE
			BEGIN
				IF @Q6 LIKE '%participate in one or more Registered Student Organization%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I participate in one or more Registered Student Organization(s) on campus')
					END
				IF @Q6 LIKE '%officer%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I am an officer in one or more Registered Student Organization(s) on campus')
					END
				IF @Q6 LIKE '%sports%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I participate in one or more sports teams (varsity or club)')
					END
				IF @Q6 LIKE '%Greek%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I am in the Greek System')
					END
				IF @Q6 LIKE '%Fraternity%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I am in a major-related Fraternity (i.e. Professional, Academic, etc.)')
					END

				/* IF [user typed response] */
			END
		
		
		/* Q7 */
		DECLARE @Q7 varchar(max) = (SELECT Question_7 FROM WK_1 WHERE ResponseID = @RowNum)

		IF @Q7 = 'Meet new people'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Meet new people')
			END
		IF @Q7 LIKE '%my major%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Get into my major')
			END
		IF @Q7 LIKE 'Join a club%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Join a club or RSO')
			END
		IF @Q7 LIKE 'Join a fraternity%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Join a fraternity or sorority')
			END
		IF @Q7 LIKE '%adult%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Learn how to be an adult (i.e. budgeting, time-management, cooking, responsibility)')
			END
		IF @Q7 LIKE '%connections%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Make connections with professors')
			END
		IF @Q7 LIKE '%Ph.D.%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Get into a Master''s or Ph.D. program')
			END
		IF @Q7 LIKE '%research%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Doing research as an undergrad')
			END
		IF @Q7 LIKE '%figure out%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Figure out what you want to do with your life')
			END
		IF @Q7 LIKE '%partner%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Find a partner')
			END
		IF @Q7 LIKE '%party%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Go to a party')
			END
		/* IF [user typed response] */

		-- Question 13-17
		DECLARE @Q13 VARCHAR(30), @Q14 VARCHAR(30), @Q15 VARCHAR(30), @Q16 VARCHAR(30), @Q17 VARCHAR(30)
		SET @Q13 = (SELECT Question_13 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q14 = (SELECT Question_14 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q15 = (SELECT Question_15 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q16 = (SELECT Question_16 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q17 = (SELECT Question_17 FROM WK_1 WHERE ResponseID = @RowNum)
		INSERT INTO tblResponse(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Q13),
			(@PersonPK, @ResponseDateTime, @Q14),
			(@PersonPK, @ResponseDateTime, @Q15),
			(@PersonPK, @ResponseDateTime, @Q16),
			(@PersonPK, @ResponseDateTime, @Q17)


		-- Question 21
		DECLARE @Q21 VARCHAR(MAX) = (SELECT Question_21 FROM WK_1 WHERE ResponseID = @RowNum)
		BEGIN
			IF @Q21 LIKE '%Advising & Orientation%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Advising & Orientation')
				END
			IF @Q21 LIKE '%Dawg Daze%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Dawg Daze')
				END
			IF @Q21 LIKE '%Facebook Groups%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Facebook Groups')
				END
			IF @Q21 LIKE '%Posters around campus%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Posters around campus')
				END
			-- Common User Typed Responses (Other: '')
			IF @Q21 LIKE '%Class%' OR @Q21 LIKE '%class%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Classes')
				END
			IF @Q21 LIKE '%Work%' OR @Q21 LIKE '%work%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Working on or off campus')
				END
			IF @Q21 LIKE '%Dorm%' OR @Q21 LIKE '%dorm%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Dorm Life')
				END
			IF @Q21 LIKE '%Common spaces%' OR @Q21 LIKE '%common spaces%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Common gathering areas')
				END
			IF @Q21 LIKE '%Club%' OR @Q21 LIKE '%club%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Joining clubs')
				END
			IF @Q21 LIKE '%None%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'None of the above')
				END
			IF @Q21 LIKE '%Roommate%' OR @Q21 LIKE '%roommate%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Roommate search and activities')
				END
			 IF @Q21 LIKE '%RSO%' OR @Q21 LIKE '%Rso%' OR @Q21 LIKE '%rso%'
				 BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Joining RSOs')
				END
			IF @Q21 LIKE '%Website%' OR @Q21 LIKE '%website%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Utilizing school websites and resources')
				END
			IF @Q21 LIKE '%Fair%' OR @Q21 LIKE '%fair%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Attending RSO fairs or other school fairs')
				END
			-- Extra IF [User Typed Response(s)]
			-- Didn't create an IF/Else case based on "None of the above" answers since there may be other responses.



		/* Q24 */

		-- Create a temporary table to store string_split values with PRIMARY KEY for lookup
		CREATE TABLE #TempQ24Placeholder (
			ItemID int PRIMARY KEY IDENTITY(1,1),
			Item varchar(500)
		)

		-- Get the Q24 reponse
		DECLARE @Q24 varchar(max) = (SELECT Question_24 FROM WK_1 WHERE ResponseID = @RowNum)

		-- Insert into temporary table, exclude empty values
		INSERT INTO #TempQ24Placeholder(Item)
		SELECT * FROM STRING_SPLIT(@Q24, ',') WHERE value <> ''

		-- Declare variables needed for the while loop
		DECLARE @Q24TotalRows int = (SELECT COUNT(*) FROM #TempQ24Placeholder)
		DECLARE @Q24CurRowNum int = 1

		WHILE @Q24CurRowNum <= @Q24TotalRows
		BEGIN
	
			-- Insert into tblRESPONSE and tblSURVEY_QUESTION_RESPONSE, 
			-- string_split items will be trimmed first to eliminate starting and trailing spaces like (,)' Undergrad research  ' to facilitate future reports
			INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, (SELECT TRIM(Item) FROM #TempQ24Placeholder WHERE ItemID = @Q24CurRowNum))
			INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
			((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = 24), SCOPE_IDENTITY())

			SET @Q24CurRowNum = @Q24CurRowNum + 1
		END

		-- Drop the temp table as always
		DROP TABLE #TempQ24Placeholder

		--Insert questions 22,23, and 25-27 into tblRESPONSE and tblSURVEY_RESPONSE
		--Store user responses into variables
		DECLARE @Response_22 varchar(30) = (SELECT Question_22 FROM WK_1 WHERE ResponseID = @RowNum);
		DECLARE @Response_23 varchar(30) = (SELECT Question_23 FROM WK_1 WHERE ResponseID = @RowNum);
		DECLARE @Response_25 varchar(30) = (SELECT Question_25 FROM WK_1 WHERE ResponseID = @RowNum);
		DECLARE @Response_26 varchar(30) = (SELECT Question_26 FROM WK_1 WHERE ResponseID = @RowNum);
		DECLARE @Response_27 varchar(30) = (SELECT Question_27 FROM WK_1 WHERE ResponseID = @RowNum);
		--store QuestionID's into variables
		DECLARE @Question_22 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'I Am...');
		DECLARE @Question_23 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My major is...');
		DECLARE @Question_25 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time finding my passion and my desired major.]');
		DECLARE @Question_26 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time getting an internship.]');
		DECLARE @Question_27 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time connecting with people within the industry.]');
		--store SurveyQuestionID's into variables
		DECLARE @SurveyQuestionID_22 INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_22);
		DECLARE @SurveyQuestionID_23 INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_23);
		DECLARE @SurveyQuestionID_25 INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_25);
		DECLARE @SurveyQuestionID_26 INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_26);
		DECLARE @SurveyQuestionID_27 INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_27);

		--insert user responses into tblRESPONSE	
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)	--Insert into tblRESPONSE
			VALUES (@PersonPK, @ResponseDateTime, @Response_22);
		DECLARE @ResponseID INT = IDENT_CURRENT('tblRESPONSE');		--Store new responseID
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)	--Insert into  tblSURVEY_QUESTION_RESPONSE
			VALUES(@SurveyQuestionID_22, @ResponseID);

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_23);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_23, @ResponseID);

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_25);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_25, @ResponseID);

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_26);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_26, @ResponseID);

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_27);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_27, @ResponseID);
		


		/* Q 28-32 */
		Declare @Response_28 varchar(100), 
		@Response_29 varchar(100), @Response_30 varchar(100), @Response_31  varchar(100), 
		@Response_32 varchar(100) -- declare variables

		Set @Response_28 = (Select Question_28 From WK_1 Where ResponseID = @RowNum)
		Set @Response_29 = (Select Question_29 From WK_1 Where ResponseID = @RowNum)
		Set @Response_30 = (Select Question_30 From WK_1 Where ResponseID = @RowNum)
		Set @Response_31 = (Select Question_31 From WK_1 Where ResponseID = @RowNum)
		Set @Response_32 = (Select Question_32 From WK_1 Where ResponseID = @RowNum)
	
		Insert Into tblResponse(PersonID, ResponseDateTime, ResponseName)
		Values(@PersonPK, @ResponseDateTime, @Response_28)
		Insert Into tblResponse(PersonID, ResponseDateTime, ResponseName)
		Values(@PersonPK, @ResponseDateTime, @Response_29)
		Insert Into tblResponse(PersonID, ResponseDateTime, ResponseName)
		Values(@PersonPK, @ResponseDateTime, @Response_30)
		Insert Into tblResponse(PersonID, ResponseDateTime, ResponseName)
		Values(@PersonPK, @ResponseDateTime, @Response_31)
		Insert Into tblResponse(PersonID, ResponseDateTime, ResponseName)
		Values(@PersonPK, @ResponseDateTime, @Response_32)


		/* Q33 */
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES (@PersonPK, @ResponseDateTime, @Temp)

		SET @RowNum = @RowNum + 1

	END
END



-- sample exec
EXEC uspInsertFromCSV @SurveyName = 'DogPaws Interest Survey', @LastPull = '2020-05-22 12:00:00'
