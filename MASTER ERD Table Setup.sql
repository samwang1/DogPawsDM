/*** SURVEY ***/

-- detail type, detail, person detail, person
-- USE DOGPAWS_Surveys_Temp

USE DOGPAWS_MASTER

GO

Create Table tblSURVEY_TYPE(
	SurveyTypeID int Identity Not Null,
	SurveyTypeName varchar(100) Not Null,
	SurveyTypeDescr varchar(500) Not Null,
	Constraint pktblSURVEY_TYPE Primary Key (SurveyTypeID)
);
Go

Create Table tblOBJECTIVE(
	ObjectiveID int Identity Not Null,
	ObjectiveName varchar(100) Not Null,
	ObjectiveDescr varchar(500) Not Null,
	Constraint pktblOBJECTIVE Primary Key (ObjectiveID)
);
Go

Create Table tbLDISTRIBUTION(
	DistributionID int Identity Not Null,
	DistributionName varchar(100) Not Null,
	DistributionDescr varchar(500) Not Null,
	Constraint pktblDistribution Primary Key (DistributionID)
);

Go
CREATE TABLE tblSURVEY ( 
SurveyID INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 
SurveyTypeID INT FOREIGN KEY REFERENCES tblSURVEY_TYPE(SurveyTypeID) NOT NULL, 
SurveyName VARCHAR(500) NOT NULL, 
SurveyBeginDate DATETIME NOT NULL, 
SurveyEnd DATETIME NULL
) 

GO
Create Table tblSURVEY_DISTRIBUTION(
	SurveyDistID int Identity Not Null,
	SurveyID int Not Null,
	DistributionID int Not Null,
	SurveyDisDate date Not Null,
	Constraint pktblSURVEY_DISTRIBUTION Primary Key (SurveyDistID),
	Constraint fkSurveyID Foreign Key (SurveyID) References tblSURVEY(SurveyID),
	Constraint fkDistributionID Foreign Key (DistributionID) References tblDISTRIBUTION(DistributionID)
);
Go

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

CREATE TABLE tblPROFILE_TYPE(
	ProfileTypeID INT PRIMARY KEY IDENTITY(1,1),
	ProfileTypeName varchar(50) NOT NULL,
	ProfileTypeDesc varchar(500)
)

CREATE TABLE tblPROFILE(
	ProfileID INT PRIMARY KEY IDENTITY(1,1),
	ProfileTypeID INT FOREIGN KEY REFERENCES tblPROFILE_TYPE(ProfileTypeID),
	Fname varchar(20) NOT NULL,
	Lname varchar(20) NOT NULL,
	BirthDate DATE,
	Age INT,
	Gender varchar(10),
	NetID INT,
	OptIn BIT,
	Email varchar(50),
	Registered bit,
	[Password] varchar(50)
)

CREATE TABLE tblPROFILE_DETAIL(
	ProfileDetailID INT PRIMARY KEY IDENTITY(1,1),
	ProfileID INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID),
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

GO 
CREATE TABLE tblRESPONSE ( 
ResponseID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
ProfileID INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID) NOT NULL, 
ResponseDateTime DATETIME NOT NULL, 
ResponseName VARCHAR(500) NOT NULL 
)

GO
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

GO 
CREATE TABLE tblSURVEY_QUESTION_RESPONSE ( 
SurvQuesRespID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
SurveyQuestionID INT FOREIGN KEY REFERENCES tblSURVEY_QUESTION(SurveyQuestionID) NOT NULL, 
ResponseID INT FOREIGN KEY REFERENCES tblRESPONSE(ResponseID) NOT NULL
)

-- create Table tblSURVEY_OBJECTIVE
Create Table tblSURVEY_OBJECTIVE(
    SurveyObjectiveID int Constraint pkSurveyObjectiveID Primary Key Identity,
    SurveyID int,
    ObjectiveID int
)
go

-- create Table tblSURVEY_STATUS
Create Table tblSURVEY_STATUS(
    SurveyStatusID int Constraint pkSurveyStatusID Primary Key Identity,
    SurveyID int,
    StatusID int,
    BeginDate date
)
go

-- create Table tblSTATUS
Create Table tblSTATUS(
    StatusID int Constraint pkStatusID Primary Key Identity,
    StatusName nvarchar(100),
    StatusDescr nvarchar(100)
)
go

-- alter the table to add with constraints (foreign keys)
Alter Table tblSURVEY_OBJECTIVE
Add Constraint fkSurveyIDSO Foreign Key(SurveyID) References tblSURVEY(SurveyID),
    Constraint fkObjectiveID Foreign Key(ObjectiveID) References tblOBJECTIVE(ObjectiveID)
Alter Table tblSURVEY_STATUS
Add Constraint fkSurveyIDSS Foreign Key(SurveyID) References tblSURVEY(SurveyID),
    Constraint fkStatusID Foreign Key(StatusID) References tblSTATUS(StatusID)

INSERT INTO tblDETAIL_TYPE(DetailTypeName)
VALUES('student year'), ('resident status'), ('housing status');

INSERT INTO tblSURVEY_TYPE(SurveyTypeName, SurveyTypeDescr)
VALUES('Interest', 'Initial DogPaws Interest Survey')

INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Multiple choice', 'The respondents select one or more options from a list of predefined answers.')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Rating scale', 'The respondents select the number that most accurately represents their response from a range of values. (i.e. 1 to 10)')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Likert scale', 'The respondents select the options that most accurately represents their response from a range of values. (i.e. strongly agree, agree, disagree, strongly disagree)')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Short answer', 'The respondents will type their answer into a comment box and don�t provide specific pre-set answer options.')
INSERT INTO tblQUESTION_TYPE(QuestionTypeName, QuestionTypeDescr) VALUES ('Ranking', 'The respondents will order the list of options according to their preference.')



/*** ACTIVITY ***/

Create Table tblLOCATION(
	LocationID int Primary Key Identity(1,1),
	LocationName varchar(100) Not Null,
	LocationDesc varchar(500)
);

Create Table tblBUILDING(
	BuildingID int Primary Key Identity(1,1),
	LocationID INT FOREIGN KEY REFERENCES tblLOCATION(LocationID),
	BuildingName varchar(100) Not Null,
	BuildingDesc varchar(500),
	BuildingShortName varchar(10)
);


-- Section 3

CREATE TABLE tblQUARTER(
    QuarterID int PRIMARY KEY Identity(1,1),
    QuarterName varchar(20) NOT NULL
);

CREATE TABLE tblCOURSE(
    CourseID INT PRIMARY KEY Identity(1,1),
	CourseName varchar(100) NOT NULL,
    CoursePrefix varchar(10),
    CourseLevel varchar(10)
);

CREATE TABLE tblCLASS(
    ClassID int Identity,
    CourseID int,
    QuarterID int,
    [Year] varchar(4),
	Section varchar(2),
    CONSTRAINT pkClass PRIMARY KEY (ClassID),
    CONSTRAINT fkCourse FOREIGN KEY (CourseID) REFERENCES tblCOURSE(CourseID),
    CONSTRAINT fkQuarter FOREIGN KEY (QuarterID) REFERENCES tblQUARTER(QuarterID)
);


CREATE TABLE tblINTEREST_TYPE(
	InterestTypeID INT PRIMARY KEY IDENTITY(1,1),
	InterestTypeName VARCHAR(100) NOT NULL,
	InterestTypeDescr VARCHAR(500) NULL
);
GO

CREATE TABLE tblACTIVITY_TYPE(
	ActivityTypeID INT PRIMARY KEY IDENTITY(1,1),
	ActivityTypeName VARCHAR(100) NOT NULL,
	ActivityTypeDescr VARCHAR(500) NULL
);
GO

CREATE TABLE tblINTEREST(
	InterestID INT PRIMARY KEY IDENTITY(1,1),
	InterestTypeID INT FOREIGN KEY REFERENCES tblINTEREST_TYPE(InterestTypeID) NOT NULL,
	InterestName VARCHAR(100) NOT NULL,
	InterestDescr VARCHAR(500) NULL
);
GO


CREATE TABLE tblACTIVITY (
	ActivityID INT PRIMARY KEY IDENTITY(1,1),
	ProfileID INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID) NOT NULL,
	ClassID INT FOREIGN KEY REFERENCES tblCLASS(ClassID),
	BuildingID INT FOREIGN KEY REFERENCES tblBUILDING(BuildingID) NOT NULL,
	InterestID INT FOREIGN KEY REFERENCES tblINTEREST(InterestID) NOT NULL,
	ActivityTypeID INT FOREIGN KEY REFERENCES tblACTIVITY_TYPE(ActivityTypeID)
)

CREATE TABLE tblPROFILE_ACTIVITY (
	ProfileActivityID INT PRIMARY KEY IDENTITY(1,1),
	ProfileID INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID) NOT NULL,
	ActivityID INT FOREIGN KEY REFERENCES tblACTIVITY(ActivityID) NOT NULL,
	ActivityTime DATETIME
)

CREATE TABLE tblRATING (
	RatingID INT PRIMARY KEY IDENTITY(1,1),
	RatingName varchar(50) NOT NULL,
	RatingAbbrev varchar(50) NOT NULL,
	RatingNumeric varchar(50) NOT NULL,
	RatingDescr varchar(500)
)

CREATE TABLE tblREVIEW (
	ReviewID INT PRIMARY KEY IDENTITY(1,1),
	ActivityID INT FOREIGN KEY REFERENCES tblACTIVITY(ActivityID) NOT NULL,
	RatingID INT FOREIGN KEY REFERENCES tblRATING(RatingID) NOT NULL,
	ReviewContent varchar(2000) NOT NULL,
	ReviewDate datetime NOT NULL
)

-- tblRELATIONSHIP
CREATE TABLE tblRELATIONSHIP (
	RelationshipID INT PRIMARY KEY IDENTITY(1,1),
	RelationshipName VARCHAR(30) NOT NULL
)

-- tblFRIEND
CREATE TABLE tblFRIEND (
	FriendID INT PRIMARY KEY IDENTITY(1,1),
	ProfileID1 INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID) NOT NULL,
	ProfileID2 INT FOREIGN KEY REFERENCES tblPROFILE(ProfileID) NOT NULL,
	RelationshipID INT FOREIGN KEY REFERENCES tblRELATIONSHIP(RelationshipID) NOT NULL,
	AddDate DATETIME NOT NULL
)