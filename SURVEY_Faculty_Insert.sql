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

Select * From SURVEY_Faculty

/* *** Inserts into tblQUESTION */
DECLARE @MC INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Multiple choice')
DECLARE @RateScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Rating scale')
DECLARE @LikertScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Likert Scale')
DECLARE @ShortAns INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Short answer')
DECLARE @Ranking INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Ranking')

INSERT INTO tblQUESTION(QuestionTypeID, QuestionName)
VALUES -- start with q3 bc q1 (timestamp) and q2 (email) can be reused
	(@MC, 'What is your title during the 2020-2021 school year?'), -- q3

	(@MC, 'How long have you been working in academia?'), -- q5
	(@MC, 'How long have you been working at UW?'), -- q6

	(@MC, 'How do you recruit students for your projects?'), -- q12
	(@MC, 'What education levels do the students who work on your projects have?'), -- q13

	(@ShortAns, 'What impact do you think a platform that facilitates stronger connections between faculty and students would have on the UW community?'), --q15
	(@ShortAns, 'What comments or advice do you have about this project?'), --q16
	(@MC, 'Would you be willing to participate in a 30-minute interview with researchers from the DogPaws team?') --q17


DECLARE @Question_1 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Timestamp')
DECLARE @Question_2 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
DECLARE @Question_3 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What is your title during the 2020-2021 school year?')

DECLARE @Question_5 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How long have you been working in academia?')
DECLARE @Question_6 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How long have you been working at UW?')

DECLARE @Question_7 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in my department')
DECLARE @Question_8 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in the UW community')
DECLARE @Question_9 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'My projects are widely acknowledged in the academic community as a whole')

DECLARE @Question_12 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How do you recruit students for your projects?')
DECLARE @Question_13 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What education levels do the students who work on your projects have?')

DECLARE @Question_15 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What impact do you think a platform that facilitates stronger connections between faculty and students would have on the UW community?')
DECLARE @Question_16 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What comments or advice do you have about this project?')
DECLARE @Question_17 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Would you be willing to participate in a 30-minute interview with researchers from the DogPaws team?')


/* *** Inserts into tblSURVEY_QUESTION */
DECLARE @SurvID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Faculty Survey')
INSERT INTO tblSURVEY_QUESTION (SurveyID, QuestionID, QuestionNumber)
VALUES
	(@SurvID, @Question_1, 1),
	(@SurvID, @Question_2, 2),
	(@SurvID, @Question_3, 3),

	(@SurvID, @Question_5, 5),
	(@SurvID, @Question_6, 6),
	(@SurvID, @Question_7, 7),
	(@SurvID, @Question_8, 8),
	(@SurvID, @Question_9, 9),

	(@SurvID, @Question_12, 12),
	(@SurvID, @Question_13, 13),

	(@SurvID, @Question_15, 15),
	(@SurvID, @Question_16, 16),
	(@SurvID, @Question_17, 17)





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


		/****** questions 5 & 12 ******/
		DECLARE @SQ_ID INT, @R_ID INT, @Q5 varchar(500), @Q5_ID INT, @Q12 varchar(MAX), @Q12_ID INT
		SET @Q5_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How long have you been working in academia?')

		-- QUESTION 5
		SET @Q5 = (SELECT Question_5 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)
		 
		  -- insert into tblResponse
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
		VALUES(@PersonPK, @ResponseDateTime, @Q5)

		  -- insert into tblSQR
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q5_ID)
		SET @R_ID = (SELECT SCOPE_IDENTITY())

		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
		VALUES(@SQ_ID, @R_ID)

		  -- insert into tblDetail
		SET @DT_ID = (SELECT DetailTypeID FROM tblDETAIL_TYPE WHERE DetailTypeName = 'Faculty Experience')
		
		INSERT INTO tblDETAIL(DetailName, DetailTypeID)
		VALUES(@Q5, @DT_ID)

		  -- insert into tblPersonDetail
		SET @D_ID = (SELECT SCOPE_IDENTITY())

		INSERT INTO tblPERSON_DETAIL(PersonID, DetailID)
		VALUES(@PersonPK, @D_ID)

		-- QUESTION 12
		SET @Q12_ID = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'How do you recruit students for your projects?')
		SET @Q12 = (SELECT Question_12 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)
		SET @SQ_ID = (SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Q12_ID)

		IF @Q12 LIKE '%Undergraduate Research Center%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Undergraduate Research Center')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, SCOPE_IDENTITY())
			END
		IF @Q12 LIKE '%Handshake%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Handshake')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, SCOPE_IDENTITY())
			END
		IF @Q12 LIKE '%Postings on your website%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Postings on your website')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, SCOPE_IDENTITY())
			END
		IF @Q12 LIKE '%Through recommendations of other professors%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Through recommendations of other professors')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, SCOPE_IDENTITY())
			END
		IF @Q12 LIKE '%Advertising your projects in class%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'Advertising your projects in class')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, SCOPE_IDENTITY())
			END
		IF @Q12 LIKE '%N/A (Do not have projects currently)%'
			BEGIN
				INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName)
				VALUES (@PersonPK, @ResponseDateTime, 'N/A (Do not have projects currently)')

				INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID)
				VALUES(@SQ_ID, SCOPE_IDENTITY())
			END
		/****** end questions 5 & 12 ******/


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


	--Inserts for question 15-17
		--Declare QuestionID's and Responses
		DECLARE @Question_15 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What impact do you think a platform that facilitates stronger connections between faculty and students would have on the UW community?')
		DECLARE @Q15_Response varchar(50) = (SELECT Question_15 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		DECLARE @Question_16 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What comments or advice do you have about this project?')
		DECLARE @Q16_Response varchar(50) = (SELECT Question_16 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		DECLARE @Question_17 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Would you be willing to participate in a 30-minute interview with researchers from the DogPaws team?')
		DECLARE @Q17_Response varchar(50) = (SELECT Question_17 FROM SURVEY_Faculty WHERE ResponseID = @RowNum)

		--Insert Into tblRESPONSE and tblSURVEY_QUESTION_RESPONSE
		--Question 15
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
			(@PersonPK, @ResponseDateTime, @Q15_Response)

		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
			((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_15), SCOPE_IDENTITY())

		--Question 16
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
			(@PersonPK, @ResponseDateTime, @Q16_Response)

		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
			((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_16), SCOPE_IDENTITY())

		--Question 17
		INSERT INTO tblRESPONSE(PersonID, ResponseDateTime, ResponseName) VALUES
			(@PersonPK, @ResponseDateTime, @Q17_Response)

		INSERT INTO tblSURVEY_QUESTION_RESPONSE(SurveyQuestionID, ResponseID) VALUES
			((SELECT SurveyQuestionID FROM tblSURVEY_QUESTION WHERE SurveyID = @SurveyID AND QuestionID = @Question_17), SCOPE_IDENTITY())


	END -- end while loop
END -- end proc

Select * From tblRESPONSE
Select * From tblSURVEY_QUESTION
Select * From tblSURVEY_QUESTION_RESPONSE