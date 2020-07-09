/* Insert Faculty Survey CSV */

/* Setup (do once only)

SELECT * FROM SURVEY_Faculty

ALTER TABLE SURVEY_Faculty
ADD ResponseID INT PRIMARY KEY IDENTITY(1,1)

INSERT INTO tblSURVEY_TYPE(SurveyTypeName, SurveyTypeDescr)
VALUES('Faculty', 'Faculty Survey')
INSERT INTO tblSURVEY(SurveyName, SurveyBeginDate, SurveyEndDate, SurveyTypeID)
VALUES('DogPaws Faculty Survey', 'July 6, 2020', 'September 22, 2020', (SELECT SurveyTypeID FROM tblSURVEY_TYPE WHERE SurveyTypeName = 'Faculty'))

INSERT INTO tblDETAIL_TYPE(DetailTypeName)
VALUES('Faculty Title'), ('Faculty College'), ('Faculty Total Experience'), ('Faculty UW Experience')
*/


/* *** Inserts into tblQUESTION */
DECLARE @MC INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Multiple choice')
DECLARE @RateScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Rating scale')
DECLARE @LikertScale INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Likert Scale')
DECLARE @ShortAns INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Short answer')
DECLARE @Ranking INT = (SELECT QuestionTypeID FROM tblQUESTION_TYPE WHERE QuestionTypeName = 'Ranking')

INSERT INTO tblQUESTION(QuestionTypeID, QuestionName)
VALUES -- start with q3 bc q1 (timestamp) and q2 (email) can be reused
	(@MC, 'What is your title during the 2020-2021 school year?') -- q3



DECLARE @Question_1 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Timestamp')
DECLARE @Question_2 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'Email')
DECLARE @Question_3 INT = (SELECT QuestionID FROM tblQUESTION WHERE QuestionName = 'What is your title during the 2020-2021 school year?')


/* *** Inserts into tblSURVEY_QUESTION */
DECLARE @SurvID INT = (SELECT SurveyID FROM tblSURVEY WHERE SurveyName = 'DogPaws Faculty Survey')
INSERT INTO tblSURVEY_QUESTION (SurveyID, QuestionID, QuestionNumber)
VALUES
	(@SurvID, @Question_1, 1),
	(@SurvID, @Question_2, 2),
	(@SurvID, @Question_3, 3)





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




		SET @RowNum = @RowNum + 1
	END -- end while loop
END -- end proc