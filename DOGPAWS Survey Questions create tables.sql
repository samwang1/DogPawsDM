-- detail type, detail, person detail, person
USE DOGPAWS_Surveys_Temp
GO

CREATE TABLE tblDETAIL_TYPE(
DetailTypeID INT PRIMARY KEY IDENTITY(1,1),
DetailTypeName varchar(50) NOT NULL,
DetailTypeDescr varchar(500)
)

CREATE TABLE tblDETAIL(
DetailID INT PRIMARY KEY IDENTITY(1,1),
DetailName varchar(50) NOT NULL,
DetailTypeID INT FOREIGN KEY REFERENCES tblDETAIL_TYPE(DetailTypeID),
DetailDesc varchar(500)
)

CREATE TABLE tblPERSON(
PersonID INT PRIMARY KEY IDENTITY(1,1),
Fname varchar(20) NOT NULL,
Lname varchar(20) NOT NULL,
BirthDate DATE NOT NULL,
NetID INT NOT NULL,
Email varchar(50)
)

CREATE TABLE tblPERSON_DETAIL(
PersonDetailID INT PRIMARY KEY IDENTITY(1,1),
PersonID INT FOREIGN KEY REFERENCES tblPERSON(PersonID),
DetailID INT FOREIGN KEY REFERENCES tblDETAIL(DetailID),
DateValue DATE,
CharValue CHAR,
NumericValue NUMERIC
)

CREATE TABLE tblQUESTION_TYPE(
QuestionTypeID int PRIMARY KEY IDENTITY(1,1),
QuestionTypeName varchar(50) NOT NULL,
QuestionTypeDescr varchar(200)
)

CREATE TABLE tblQUESTION(
QuestionID int PRIMARY KEY IDENTITY(1,1),
QuestionTypeID int NOT NULL FOREIGN KEY REFERENCES tblQUESTION_TYPE(QuestionTypeID),
QuestionName varchar(500) NOT NULL
)

CREATE TABLE tblSURVEY_QUESTION(
SurveyQuestionID int PRIMARY KEY IDENTITY(1,1),
SurveyID int NOT NULL FOREIGN KEY REFERENCES tblSURVEY(SurveyID),
QuestionID int NOT NULL FOREIGN KEY REFERENCES tblQUESTION(QuestionID),
QuestionNumber int NOT NULL
)


-- Question Type Insert
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Multiple choice', 'The respondents select one or more options from a list of predefined answers.')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Rating scale', 'The respondents select the number that most accurately represents their response from a range of values. (i.e. 1 to 10)')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Likert scale', 'The respondents select the options that most accurately represents their response from a range of values. (i.e. strongly agree, agree, disagree, strongly disagree)')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Short answer', 'The respondents will type their answer into a comment box and don’t provide specific pre-set answer options.')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Ranking', 'The respondents will order the list of options according to their preference.')
