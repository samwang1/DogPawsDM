USE DOGPAWS_Surveys_Temp /* USE KEEPER_DogPawsDM_Testing */

USE DOGPAWS_TEST
SELECT * FROM WK_1

INSERT INTO tblSURVEY(SurveyName, SurveyBeginDate, SurveyEndDate, SurveyTypeID)
VALUES('DogPaws Interest Survey', 'May 22, 2020', 'September 22, 2020', (SELECT SurveyTypeID FROM tblSURVEY_TYPE WHERE SurveyTypeName = 'Interest')) -- sample end date and surveytypeid

/* inserts into tblQUESTION */
DECLARE @MC INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Multiple choice')
DECLARE @RateScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Rating scale')
DECLARE @LikertScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Likert Scale')
DECLARE @ShortAns INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Short answer')
DECLARE @Ranking INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Ranking')


INSERT INTO tblQUESTION (QuestionTypeID, QuestionName)	--Insert into tblQUESTION
	VALUES
		(@ShortAns, 'Timestamp'), -- q1
		(@ShortAns, 'Email'), -- q2
		(@MC, 'What is your class standing for the 2020-2021 school year?'), -- q3
		(@MC, 'I am an... (resident status)'), -- q4
		(@MC, 'I am... (housing status)'), -- q5
		(@MC, 'Which statements below best describe you? (Select all that apply)'), -- q6
		(@MC, 'What experiences or goals did you have for yourself when you came to UW?'), -- q7
		(@MC, 'What struggles did you anticipate you would have during your first year?'), -- q8
		(@MC, 'In what ways do you wish you had more support during your first year?'), -- q9
		(@MC, 'Rate your level of agreement with the following statements: [I had a hard time finding a group that I feel I belong to.]'), -- Q10
		(@MC, 'Rate your level of agreement with the following statements: [Joining an RSO helps me to make friends.]'), -- Q11
		(@MC, 'Rate your level of agreement with the following statements: [I joined something I never thought I would join before coming to college.]'), -- Q12
		(@LikertScale, 'Rate your level of agreement with the following statements: [I find it easier to make friends when we have shared common interests.]'), -- Q13
		(@LikertScale, 'Rate your level of agreement with the following statements: [I find it hard to make friends at UW.]'), -- Q14
		(@LikertScale, 'Rate your level of agreement with the following statements: [I initially felt lost coming when I came to UW.]'), -- Q15
		(@LikertScale, 'Rate your level of agreement with the following statements: [I find it easy to form study groups.]'), -- Q16
		(@LikertScale, 'Rate your level of agreement with the following statements: [I have a lot of friends from class or study groups.]'), -- Q17
		(@ShortAns, 'What are some factors that made you join the RSO(s) you are a part of on campus? (If you are not in an RSO, please indicate N/A)'), -- q18
		(@ShortAns, 'What are some factors that have prevented you or discouraged you from joining an RSO on campus? (If you are in an RSO, please indicate N/A)'), -- q19
		(@MC, 'What platform(s) do you use to keep track of events and RSO? (Select all that apply)'), --Question 20 (multi-valued)
		(@MC, 'What are some of the programs that you have found helpful in assisting you to find a community at UW? (Select all that apply)'), -- Q21 (multi-valued)
		(@MC, 'I am... (major status)'),	--Question 22
		(@MC, 'My major is...'),	--Question 23
		(@MC, 'Which of the following platforms have you interacted with to network or search for a job or internship? (Select all that apply)'), -- Q24
		(@LikertScale, 'Rate your level of agreement with the following statements: [I have a hard time finding my passion and my desired major.]'), --Question 25
		(@LikertScale, 'Rate your level of agreement with the following statements: [I have a hard time getting an internship.]'), --Question 26
		(@LikertScale, 'Rate your level of agreement with the following statements: [I have a hard time connecting with people within the industry.]'),	--Question 27
		(@LikertScale, 'Rate your level of agreement with the following statements: [Career Service provides adequate resources for me to succeed.]'),	--Question 28
		(@LikertScale, 'Rate your level of agreement with the following statements: [I feel prepared to find internships.]'),	--Question 29
		(@LikertScale, 'Rate your level of agreement with the following statements: [I have resources to get trustworthy feedback on my resumes/cover letters.]'),	--Question 30
		(@MC, 'Can we contact you for more information?'),	--Question 31
		(@MC, 'Are you interested in joining the DOGPAWS team?'),	--Question 32
		(@ShortAns, 'Additionally, please leave your preferred first and last name here if you answered yes to either of the first two questions asked on this page (format: Harry Husky):'); -- q33

DECLARE @Question_1 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Timestamp')
DECLARE @Question_2 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
DECLARE @Question_3 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What is your class standing for the 2020-2021 school year?')
DECLARE @Question_4 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'I am an... (resident status)')
DECLARE @Question_5 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'I am... (housing status)')
DECLARE @Question_6 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Which statements below best describe you? (Select all that apply)')
DECLARE @Question_7 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What experiences or goals did you have for yourself when you came to UW?')
DECLARE @Question_8 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What struggles did you anticipate you would have during your first year?')
DECLARE @Question_9 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'In what ways do you wish you had more support during your first year?')
DECLARE @Question_10 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I had a hard time finding a group that I feel I belong to.]');
DECLARE @Question_11 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [Joining an RSO helps me to make friends.]');
DECLARE @Question_12 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I joined something I never thought I would join before coming to college.]');
DECLARE @Question_13 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I find it easier to make friends when we have shared common interests.]')
DECLARE @Question_14 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I find it hard to make friends at UW.]')
DECLARE @Question_15 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I initially felt lost coming when I came to UW.]')
DECLARE @Question_16 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I find it easy to form study groups.]')
DECLARE @Question_17 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a lot of friends from class or study groups.]')
DECLARE @Question_18 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What are some factors that made you join the RSO(s) you are a part of on campus? (If you are not in an RSO, please indicate N/A)')
DECLARE @Question_19 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What are some factors that have prevented you or discouraged you from joining an RSO on campus? (If you are in an RSO, please indicate N/A)')
DECLARE @Question_20 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What platform(s) do you use to keep track of events and RSO? (Select all that apply)')
DECLARE @Question_21 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What are some of the programs that you have found helpful in assisting you to find a community at UW? (Select all that apply)')
DECLARE @Question_22 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'I am... (major status)');
DECLARE @Question_23 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My major is...');
DECLARE @Question_24 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Which of the following platforms have you interacted with to network or search for a job or internship? (Select all that apply)');
DECLARE @Question_25 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time finding my passion and my desired major.]');
DECLARE @Question_26 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time getting an internship.]');
DECLARE @Question_27 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a hard time connecting with people within the industry.]');
DECLARE @Question_28 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [Career Service provides adequate resources for me to succeed.]');
DECLARE @Question_29 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I feel prepared to find internships.]');
DECLARE @Question_30 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have resources to get trustworthy feedback on my resumes/cover letters.]');
DECLARE @Question_31 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Can we contact you for more information?');
DECLARE @Question_32 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Are you interested in joining the DOGPAWS team?');
DECLARE @Question_33 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName LIKE '%Harry Husky%')

/* inserts into tblSURVEY_QUESTION*/
DECLARE @SurvID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Interest Survey')

INSERT INTO tblSURVEY_QUESTION (SurveyID, QuestionID, QuestionNumber)
	Values
		(@SurvID, @Question_1, 1),
		(@SurvID, @Question_2, 2),
		(@SurvID, @Question_3, 3),
		(@SurvID, @Question_4, 4),
		(@SurvID, @Question_5, 5),
		(@SurvID, @Question_6, 6),
		(@SurvID, @Question_7, 7),
		(@SurvID, @Question_8, 8),
		(@SurvID, @Question_9, 9),
		(@SurvID, @Question_10, 10),
		(@SurvID, @Question_11, 11),
		(@SurvID, @Question_12, 12),
		(@SurvID, @Question_13, 13),
		(@SurvID, @Question_14, 14),
		(@SurvID, @Question_15, 15),
		(@SurvID, @Question_16, 16),
		(@SurvID, @Question_17, 17),
		(@SurvID, @Question_18, 18),
		(@SurvID, @Question_19, 19),
		(@SurvID, @Question_20, 20),
		(@SurvID, @Question_21, 21),
		(@SurvID, @Question_22, 22),
		(@SurvID, @Question_23, 23),
		(@SurvID, @Question_24, 24),
		(@SurvID, @Question_25, 25),
		(@SurvID, @Question_26, 26),
		(@SurvID, @Question_27, 27),
		(@SurvID, @Question_28, 28),
		(@SurvID, @Question_29, 29),
		(@SurvID, @Question_30, 30),
		(@SurvID, @Question_31, 31),
		(@SurvID, @Question_32, 32),
		(@SurvID, @Question_33, 33);



/* ***************************************************************** */


EXEC uspInsertFromCSV @SurveyName = 'DogPaws Interest Survey'

GO
ALTER PROC uspInsertFromCSV
@SurveyName varchar(100)--,
--@LastPull DateTime -- time of most recent .csv download
AS
BEGIN
	DECLARE @RowNum INT = 1--(SELECT TOP 1 ResponseID FROM tblRESPONSE ORDER BY ResponseID DESC) -- most recent response time
	IF @RowNum IS NULL
		BEGIN
			SET @RowNum = 1
		END
	ELSE
		BEGIN
			SET @RowNum = @RowNum + 1
		END

	DECLARE @TotalRows INT = (SELECT COUNT(*) FROM WK_1)
	DECLARE @F varchar(50), @L varchar(50), @Email varchar(100), @Temp varchar(100)

	DECLARE @ResponseDateTime DateTime = (Select Question_1 From WK_1 Where ResponseID = @RowNum),
		@PersonPK INT

	DECLARE @SurveyID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Interest Survey')
	PRINT(@SurveyID)
	WHILE @RowNum <= @TotalRows
	BEGIN

		SET @Temp = (SELECT Question_33 FROM WK_1 WHERE ResponseID = @RowNum)

		IF @Temp IS NULL OR @Temp = 'N/A'
			BEGIN
				SET @F = 'anon'
				SET @L = 'anon'
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
		ELSE
			BEGIN
				SET @RowNum = @RowNum + 1
				CONTINUE
			 END

		SET @PersonPK = (SELECT PersonID FROM tblPERSON WHERE Email = @Email)
		PRINT(@PersonPK)
		
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Email)
		DECLARE @RespID INT = SCOPE_IDENTITY()
		PRINT(@RespID)
		PRINT('Inserted into response')
		
		DECLARE @QuestID INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
		DECLARE @SurvQuestID INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION
									WHERE SurveyID = @SurveyID AND QuestionID = @QuestID)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SurvQuestID, @RespID)
		PRINT('Inserted into SQR')

		/* Q 3-5 */

		DECLARE @Yr varchar(50), @StudType varchar(50), @Housing varchar(50), 
			@DT_ID1 INT, @DT_ID2 INT, @DT_ID3 INT, @D_ID INT, @R_ID INT, @Q_ID INT, @SQ_ID INT

		SET @Yr = (SELECT Question_3 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @StudType = (SELECT Question_4 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Housing = (SELECT Question_5 FROM WK_1 WHERE ResponseID = @RowNum)

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

		-- q3
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Yr)

		-- getting responseID
		SET @R_ID = (SELECT SCOPE_IDENTITY())
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION
						WHERE QuestionName = 'What is your class standing for the 2020-2021 school year?')
		SET @SQ_ID = (
		SELECT SurveyQuestionID
		FROM tblSURVEY_QUESTION
		WHERE SurveyID = @SurveyID
			AND QuestionID = @Q_ID
		)

		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SQ_ID, @R_ID)

		-- insert into person_detail
		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		-- repeat for q4
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@StudType, @DT_ID2)

		SET @D_ID = (SELECT SCOPE_IDENTITY())

		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @StudType)
		SET @R_ID = (SELECT SCOPE_IDENTITY())
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION
				WHERE QuestionName = 'I am an... (resident status)')

		SET @SQ_ID = (
			SELECT SurveyQuestionID
			FROM tblSURVEY_QUESTION
			WHERE SurveyID = @SurveyID
				AND QuestionID = @Q_ID
		)

		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SQ_ID, @R_ID)

		-- repeat for q5
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@Housing, @DT_ID3)

		SET @D_ID = (SELECT SCOPE_IDENTITY())

		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Housing)
		SET @R_ID = (SELECT SCOPE_IDENTITY())
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION
				WHERE QuestionName = 'I am... (housing status)')

		SET @SQ_ID = (
		SELECT SurveyQuestionID
		FROM tblSURVEY_QUESTION
		WHERE SurveyID = @SurveyID
			AND QuestionID = @Q_ID
		)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SQ_ID, @R_ID)

		/* Q6 */

		DECLARE @Q6 varchar(max) = (SELECT Question_6 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Which statements below best describe you? (Select all that apply)')
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)

		IF @Q6 = 'None of the above'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'None of the above')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		ELSE
			BEGIN
				IF @Q6 LIKE '%participate in one or more Registered Student Organization%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I participate in one or more Registered Student Organization(s) on campus')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
					END
				IF @Q6 LIKE '%officer%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I am an officer in one or more Registered Student Organization(s) on campus')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
					END
				IF @Q6 LIKE '%sports%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I participate in one or more sports teams (varsity or club)')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
					END
				IF @Q6 LIKE '%Greek%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I am in the Greek System')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
					END
				IF @Q6 LIKE '%Fraternity%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'I am in a major-related Fraternity (i.e. Professional, Academic, etc.)')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
					END

				/* IF [user typed response] */
			END
		
		
		/* Q7 */
		DECLARE @Q7 varchar(max) = (SELECT Question_7 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What experiences or goals did you have for yourself when you came to UW?')
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)

		IF @Q7 = 'Meet new people'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Meet new people')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%my major%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Get into my major')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE 'Join a club%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Join a club or RSO')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE 'Join a fraternity%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Join a fraternity or sorority')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%adult%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Learn how to be an adult (i.e. budgeting, time-management, cooking, responsibility)')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%connections%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Make connections with professors')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%Ph.D.%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Get into a Master''s or Ph.D. program')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%research%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Doing research as an undergrad')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%figure out%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Figure out what you want to do with your life')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%partner%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Find a partner')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q7 LIKE '%party%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Go to a party')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		/* IF [user typed response] */


		/* Q8 */
		DECLARE @Q8 varchar(max) = (SELECT Question_8 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What struggles did you anticipate you would have during your first year?')
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)

		PRINT(@Q8)
		IF @Q8 LIKE '%course load%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Course load, homework, assignments')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%exams%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Exams')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%Having a difficult major%'
			BEGIN
				PRINT('Q8 IF')
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Having a difficult major')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				PRINT(@RespID)
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%Getting into a difficult major%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Getting into a difficult major')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%Making friends%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Making friends')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%Finding a club that fits your interests%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Finding a club that fits your interests')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%Finding community%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Finding community')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q8 LIKE '%Adapting to living on your own%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES(@PersonPK, @ResponseDateTime, 'Adapting to living on your own')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END

		-- parse user input response

		/* Q9 */
		DECLARE @Q9 varchar(max) = (SELECT Question_9 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'In what ways do you wish you had more support during your first year?')
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)

		IF @Q9 LIKE '%access to RSOs%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Easier access to RSOs and their events throughout the year')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%commute to campus%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Finding someone to commute to campus with')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%internships%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Career development opportunities (i.e. networking, finding internships)')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END	
		IF @Q9 LIKE '%roommate%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Finding a roommate you can get along')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%community%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Developing a community')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%study groups%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Creating study groups')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%connections%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Making connections during class')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%academic resources%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Knowing what academic resources are available')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%research%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Finding research opportunities')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END
		IF @Q9 LIKE '%majors%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Exploring different majors')
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
			END

		-- insert the question index into survey_question_response	
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
	    VALUES(@SQ_ID, @RowNum)

		/* Insert response for question 10 - 12 */
		DECLARE @Question_10 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I had a hard time finding a group that I feel I belong to.]');
		DECLARE @Question_11 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [Joining an RSO helps me to make friends.]');
		DECLARE @Question_12 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I joined something I never thought I would join before coming to college.]');
		
		-- For question 10
		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, (SELECT Question_10 FROM WK_1 WHERE ResponseID = @RowNum))

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_10), SCOPE_IDENTITY())

		-- For question 11
		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, (SELECT Question_11 FROM WK_1 WHERE ResponseID = @RowNum))

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_11), SCOPE_IDENTITY())

		-- For question 12
		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, (SELECT Question_12 FROM WK_1 WHERE ResponseID = @RowNum))

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_12), SCOPE_IDENTITY())

		
		-- Question 13-17
		DECLARE @Q13 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I find it easier to make friends when we have shared common interests.]')
		DECLARE @Q14 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I find it hard to make friends at UW.]')
		DECLARE @Q15 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I initially felt lost coming when I came to UW.]')
		DECLARE @Q16 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I find it easy to form study groups.]')
		DECLARE @Q17 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have a lot of friends from class or study groups.]')
		
		PRINT @Q13
		PRINT @Q14
		PRINT @Q15
		PRINT @Q16
		PRINT @Q17

		-- 13-17 Response
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, (SELECT Question_13 FROM WK_1 WHERE ResponseID = @RowNum)),
		(@PersonPK, @ResponseDateTime, (SELECT Question_14 FROM WK_1 WHERE ResponseID = @RowNum)),
		(@PersonPK, @ResponseDateTime, (SELECT Question_15 FROM WK_1 WHERE ResponseID = @RowNum)),
		(@PersonPK, @ResponseDateTime, (SELECT Question_16 FROM WK_1 WHERE ResponseID = @RowNum)),
		(@PersonPK, @ResponseDateTime, (SELECT Question_17 FROM WK_1 WHERE ResponseID = @RowNum))

		-- 13-17 Survey_Question_Response
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q13), SCOPE_IDENTITY()),
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q14), SCOPE_IDENTITY()),
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q15), SCOPE_IDENTITY()),
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q16), SCOPE_IDENTITY()),
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q17), SCOPE_IDENTITY())


		DECLARE @Q18 varchar(max) = (SELECT Question_18 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What are some factors that made you join the RSO(s) you are a part of on campus? (If you are not in an RSO, please indicate N/A)')
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)
		
		IF @Q18 <> ''
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, @Q18)
				SET @RespID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
				PRINT('QUESTION 18')
			END
		

		DECLARE @Q19 varchar(max) = (SELECT Question_19 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What are some factors that have prevented you or discouraged you from joining an RSO on campus? (If you are in an RSO, please indicate N/A)')
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)
		IF @Q19 <> ''
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, @Q19)
				SET @R_ID = (SELECT SCOPE_IDENTITY())
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @R_ID)
				PRINT('QUESTION 19')
			END


		-- Question 20
		DECLARE @Q20 varchar(max) = (SELECT Question_20 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What platform(s) do you use to keep track of events and RSO? (Select all that apply)');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);

		IF @Q20 = 'Not Applicable (I am not in an RSO)'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Not Applicable (I am not in an RSO)')
				SET @RespID = SCOPE_IDENTITY()
				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, @RespID)
				PRINT('QUESTION 20')
			END
		ELSE
			BEGIN
				IF @Q20 LIKE '%Facebook%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'Facebook')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
						PRINT('QUESTION 20')
					END
				IF @Q20 LIKE '%RSO''s Website%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'RSO''S Website')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
						PRINT('QUESTION 20')
					END
				IF @Q20 LIKE '%Email%'
					BEGIN
						INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
						VALUES (@PersonPK, @ResponseDateTime, 'Email')
						SET @RespID = SCOPE_IDENTITY()
						INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
						VALUES(@SQ_ID, @RespID)
						PRINT('QUESTION 20')
					END
				/* IF [user typed response] */
			END

		-- Question 21
		DECLARE @Q21 VARCHAR(MAX) = (SELECT Question_21 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What are some of the programs that you have found helpful in assisting you to find a community at UW? (Select all that apply)');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);
		BEGIN
			
			PRINT @Q21

			IF @Q21 LIKE '%Advising & Orientation%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Advising & Orientation')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Dawg Daze%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Dawg Daze')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Facebook Groups%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Facebook Groups')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Posters around campus%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Posters around campus')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			-- Common User Typed Responses (Other: '')
			IF @Q21 LIKE '%Class%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Classes')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Work%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Working on or off campus')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Dorm%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Dorm Life')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Common spaces%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Common gathering areas')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Club%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Joining clubs')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%None%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'None of the above')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Roommate%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Roommate search and activities')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			 IF @Q21 LIKE '%RSO%'
				 BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Joining RSOs')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Website%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Utilizing school websites and resources')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			IF @Q21 LIKE '%Fair%'
				BEGIN
					INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
					VALUES (@PersonPK, @ResponseDateTime, 'Attending RSO fairs or other school fairs')
					SET @RespID = SCOPE_IDENTITY()
					INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
					VALUES(@SQ_ID, @RespID)
					PRINT('QUESTION 21')
				END
			-- Extra IF [User Typed Response(s)]
			-- Didn't create an IF/Else case based on "None of the above" answers since there may be other responses.



		/* Q24 */
		
		DECLARE @Question_24 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Which of the following platforms have you interacted with to network or search for a job or internship? (Select all that apply)');

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
			((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_24), SCOPE_IDENTITY())
			PRINT('QUESTION 24')
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
		DECLARE @Question_22 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'I am... (major status)');
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
			PRINT('QUESTION 22')

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_23);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_23, @ResponseID);
			PRINT('QUESTION 23')

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_25);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_25, @ResponseID);
			PRINT('QUESTION 25')

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_26);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_26, @ResponseID);
			PRINT('QUESTION 26')

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
			VALUES (@PersonPK, @ResponseDateTime, @Response_27);
		SET @ResponseID = IDENT_CURRENT('tblRESPONSE');
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
			VALUES(@SurveyQuestionID_27, @ResponseID);
			PRINT('QUESTION 27')
		


		/* Q 28-32 */
		DECLARE @Response_28 VARCHAR(100), 
		@Response_29 VARCHAR(100), @Response_30 VARCHAR(100), @Response_31 VARCHAR(100), 
		@Response_32 VARCHAR(100) -- declare variables

		SET @Response_28 = (SELECT Question_28 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Response_29 = (SELECT Question_29 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Response_30 = (SELECT Question_30 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Response_31 = (SELECT Question_31 FROM WK_1 WHERE ResponseID = @RowNum)
		SET @Response_32 = (SELECT Question_32 FROM WK_1 WHERE ResponseID = @RowNum)
	
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [Career Service provides adequate resources for me to succeed.]');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);
		INSERT INTO tblResponse(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Response_28)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
	    VALUES(@SQ_ID, SCOPE_IDENTITY()) --Insert into   tblSURVEY_QUESTION_RESPONSE
		PRINT('QUESTION 28')

		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I feel prepared to find internships.]');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);
		INSERT INTO tblResponse(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Response_29)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
	    VALUES(@SQ_ID, SCOPE_IDENTITY()) --Insert into   tblSURVEY_QUESTION_RESPONSE
		PRINT('QUESTION 29')

		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Rate your level of agreement with the following statements: [I have resources to get trustworthy feedback on my resumes/cover letters.]');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);
		INSERT INTO tblResponse(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Response_30)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
	    VALUES(@SQ_ID, SCOPE_IDENTITY()) --Insert into   tblSURVEY_QUESTION_RESPONSE
		PRINT('QUESTION 30')

		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Can we contact you for more information?');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);
		INSERT INTO tblResponse(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Response_31)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
	    VALUES(@SQ_ID, SCOPE_IDENTITY()) --Insert into   tblSURVEY_QUESTION_RESPONSE
		PRINT('QUESTION 31')
		
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Are you interested in joining the DOGPAWS team?');
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID);
		INSERT INTO tblResponse(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Response_32)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
	    VALUES(@SQ_ID, SCOPE_IDENTITY()) --Insert into   tblSURVEY_QUESTION_RESPONSE
		PRINT('QUESTION 32')
 

		/* Q33 */
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES (@PersonPK, @ResponseDateTime, @Temp)
		SET @RespID = SCOPE_IDENTITY()
		SET @Q_ID = (SELECT QuestionID FROM tblQUESTION
			WHERE QuestionName = 'Additionally, please leave your preferred first and last name here if you answered yes to either of the first two questions asked on this page (format: Harry Husky):')
		SET @SurvQuestID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION
									WHERE SurveyID = @SurveyID AND QuestionID = @Q_ID)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SurvQuestID, @RespID)
		PRINT('QUESTION 33')

		SET @RowNum = @RowNum + 1

		END
	END
END



-- sample exec
EXEC uspInsertFromCSV @SurveyName = 'DogPaws Interest Survey'--, @LastPull = '2020-05-22 12:00:00'
