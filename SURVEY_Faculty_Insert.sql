/* Insert Faculty Survey CSV */

/* Setup (do once only)

SELECT * FROM SURVEY_Faculty

ALTER TABLE SURVEY_Faculty
ADD ResponseID INT PRIMARY KEY IDENTITY(1,1)
r
INSERT INTO tblSURVEY_TYPE(SurveyTypeName, SurveyTypeDescr)
VALUES('Faculty', 'Faculty Survey')
INSERT INTO tblSURVEY(SurveyName, SurveyBeginDate, SurveyEndDate, SurveyTypeID)
VALUES('DogPaws Faculty Survey', 'July 6, 2020', 'September 22, 2020', (SELECT SurveyTypeID FROM tblSURVEY_TYPE WHERE SurveyTypeName = 'Faculty'))

INSERT INTO tblDETAIL_TYPE(DetailTypeName)
VALUES('Faculty Title'), ('Faculty College'), ('Faculty Total Experience'), ('Faculty UW Experience')
*/

USE DOGPAWS_Test
GO

-- Survey Result
SELECT * FROM SURVEY_Faculty


/* *** Inserts into tblQUESTION */
DECLARE @MC INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Multiple choice')
DECLARE @RateScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Rating scale')
DECLARE @LikertScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Likert Scale')
DECLARE @ShortAns INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Short answer')
DECLARE @Ranking INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Ranking')

INSERT INTO tblQUESTION(QuestionTypeID, QuestionName)
VALUES -- start with q3 bc q1 (timestamp) and q2 (email) can be reused
	(@MC, 'What is your title during the 2020-2021 school year?'), -- q3

	(@MC, 'How long have you been working at UW?'), -- q6

	(@MC, 'What education levels do the students who work on your projects have?') -- q13


DECLARE @Question_1 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Timestamp')
DECLARE @Question_2 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
DECLARE @Question_3 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What is your title during the 2020-2021 school year?')

DECLARE @Question_6 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How long have you been working at UW?')

DECLARE @Question_7 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in my department')
DECLARE @Question_8 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in the UW community')
DECLARE @Question_9 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in the academic community as a whole')

DECLARE @Question_13 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What education levels do the students who work on your projects have?')


/* *** Inserts into tblSURVEY_QUESTION */
DECLARE @SurvID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Faculty Survey')
INSERT INTO tblSURVEY_QUESTION (SurveyID, QuestionID, QuestionNumber)
VALUES
	(@SurvID, @Question_1, 1),
	(@SurvID, @Question_2, 2),
	(@SurvID, @Question_3, 3),

	(@SurvID, @Question_6, 6),
	(@SurvID, @Question_7, 7),
	(@SurvID, @Question_8, 8),
	(@SurvID, @Question_9, 9),
	(@SurvID, @Question_13, 13)





/* ************************************************************* */




GO
CREATE PROC uspInsertFacultySurveyCSV
AS
BEGIN
	DECLARE @SurveyID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Faculty Survey')
	DECLARE @RowNum INT = 1
	DECLARE @TotalRows INT = (SELECT COUNT(*) FROM SURVEY_Faculty)
	DECLARE @Email varchar(100), @PersonPK INT,
		@ResponseDateTime DateTime = (Select Question_1 From SURVEY_Faculty Where ResponseID = @RowNum)

	WHILE @RowNum <= @TotalRows
	BEGIN
		SET @Email = (SELECT Question_2 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)
		IF NOT EXISTS (SELECT P.PersonID FROM tblPERSON P
						JOIN tblRESPONSE R ON P.PersonID = R.PersonID
						JOIN tblSURVEY_QUESTION_RESPONSE SQR ON R.ResponseID = SQR.ResponseID
						JOIN tblSURVEY_QUESTION SQ ON SQR.SurveyQuestionID = SQ.SurveyQuestionID
						JOIN tblSURVEY S ON SQ.SurveyID = S.SurveyID
							WHERE Email = @Email AND S.SurveyID = @SurveyID) -- person who has taken this specific survey
			BEGIN
				INSERT INTO tblPERSON(Fname, Lname, Email)
				VALUES('anon', 'anon', @Email)
			END
		ELSE -- person has already taken this survey
			BEGIN
				SET @RowNum = @RowNum + 1
				CONTINUE
			 END
	
		SET @PersonPK = (SELECT PersonID FROM tblPERSON WHERE Email = @Email)

		/* Q2 */ 
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Email)
		DECLARE @RespID INT = SCOPE_IDENTITY()

		DECLARE @QuestID INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
		DECLARE @SurvQuestID INT = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION
									WHERE SurveyID = @SurveyID AND QuestionID = @QuestID)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SurvQuestID, @RespID)

		/* Q3 */
		DECLARE @ResponseName varchar(30) = (SELECT Question_3 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @ResponseName)
		SET @RespID = SCOPE_IDENTITY()

		SET @QuestID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What is your title during the 2020-2021 school year?')
		SET @SurvQuestID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION
									WHERE SurveyID = @SurveyID AND QuestionID = @QuestID)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SurvQuestID, @RespID)

		DECLARE @DT_ID INT = (SELECT DetailTypeID FROM tblDETAIL_TYPE WHERE DetailTypeName = 'Faculty Title')

		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@ResponseName, @DT_ID)

		DECLARE @D_ID INT = SCOPE_IDENTITY()
		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		/* Q4 */
		SET @ResponseName= (SELECT Question_4 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @ResponseName)
		SET @RespID = SCOPE_IDENTITY()

		SET @QuestID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What is your title during the 2020-2021 school year?')
		SET @SurvQuestID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION
									WHERE SurveyID = @SurveyID AND QuestionID = @QuestID)
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SurvQuestID, @RespID)

		SET @DT_ID = (SELECT DetailTypeID FROM tblDETAIL_TYPE WHERE DetailTypeName = 'Faculty College')
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@ResponseName, @DT_ID)

		SET @D_ID = SCOPE_IDENTITY()
		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)


		/******* Insert for Question 6 & 13 ********/

		-- For question 6
		DECLARE @Question_6 int = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How long have you been working at UW?');
		DECLARE @Q6_Resp varchar(50) = (SELECT Question_6 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, @Q6_Resp)

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_6), SCOPE_IDENTITY())

		-- Insert into tblDETAIL and tblPERSON_DETAIL
		SET @DT_ID = (SELECT DetailTypeID FROM tblDETAIL_TYPE WHERE DetailTypeName = 'Faculty UW Experience')

		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@Q6_Resp, @DT_ID)

		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, SCOPE_IDENTITY())

		-- For question 13
		DECLARE @Question_13 int = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What education levels do the students who work on your projects have?');
		DECLARE @Q13_Resp varchar(MAX) = (SELECT Question_13 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)
		DECLARE @Q13_SQID int = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_13)

		IF @Q13_Resp LIKE '%First-Year Undergraduate%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'First-Year Undergraduate')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END
		IF @Q13_Resp LIKE '%Second-Year Undergraduate%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Second-Year Undergraduate')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END
		IF @Q13_Resp LIKE '%Third-Year Undergraduate%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Third-Year Undergraduate')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END
		IF @Q13_Resp LIKE '%Fourth-Year Undergraduate%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Fourth-Year Undergraduate')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END
		IF @Q13_Resp LIKE '%Master''s Student%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Master''s Student')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END
		IF @Q13_Resp LIKE '%Ph.D. Student%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Ph.D. Student')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END
		IF @Q13_Resp LIKE '%N/A (Do not have projects currently)%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'N/A (Do not have projects currently)')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@Q13_SQID, SCOPE_IDENTITY())
			END



-- insert question for 7-9
-- For question 7
		DECLARE @Question_7 int = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in my department');
		DECLARE @Q7_Resp varchar(50) = (SELECT Question_7 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, @Q7_Resp)

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_7), SCOPE_IDENTITY())


-- For question 8
		DECLARE @Question_8 int = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in the UW community');
		DECLARE @Q8_Resp varchar(50) = (SELECT Question_8 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, @Q8_Resp)

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_8), SCOPE_IDENTITY())


-- For question 9
		DECLARE @Question_9 int = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in the academic community as a whole');
		DECLARE @Q9_Resp varchar(50) = (SELECT Question_9 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		-- Insert into tblRESPONSE
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
		(@PersonPK, @ResponseDateTime, @Q8_Resp)

		-- Insert into tblSURVEY_QUESTION_RESPONSE
		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
		((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_8), SCOPE_IDENTITY())

	END -- end while loop
END -- end proc